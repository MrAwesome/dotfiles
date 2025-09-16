-- Async range filter with temporary highlight
do
  local counter = 0
  local function new_ns()
    counter = counter + 1
    return vim.api.nvim_create_namespace("AsyncRangeRunning" .. counter)
  end

  -- Light red bg by default; user can override via :hi AsyncRangeRunning
  pcall(vim.api.nvim_set_hl, 0, "AsyncRangeRunning", { bg = "#ffd6d6", ctermbg = 224, default = true })

  local function highlight_range(buf, ns, l1, l2)
    -- l1/l2 are 1-based inclusive
    for l = l1 - 1, l2 - 1 do
      pcall(vim.api.nvim_buf_add_highlight, buf, ns, "AsyncRangeRunning", l, 0, -1)
    end
  end

  local function clear_range(buf, ns, l1, l2)
    pcall(vim.api.nvim_buf_clear_namespace, buf, ns, l1 - 1, l2)
  end

  local function replace_lines(buf, l1, l2, text)
    local lines = vim.split(text or "", "\n", { plain = true })
    -- Drop trailing empty line if output ended with newline (mimics :%!)
    if #lines > 0 and lines[#lines] == "" then
      table.remove(lines)
    end
    vim.api.nvim_buf_set_lines(buf, l1 - 1, l2, false, lines)
  end

  local function run_vim_system(cmd, input, cb)
    vim.system({ "sh", "-c", cmd }, { stdin = input, text = true }, function(res)
      cb(res.code, res.stdout or "", res.stderr or "")
    end)
  end

  local function run_jobstart(cmd, input, cb)
    local stdout_chunks, stderr_chunks = {}, {}
    local job = vim.fn.jobstart({ "sh", "-c", cmd }, {
      stdin = "pipe",
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data and #data > 0 then
          table.insert(stdout_chunks, table.concat(data, "\n"))
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          table.insert(stderr_chunks, table.concat(data, "\n"))
        end
      end,
      on_exit = function(_, code)
        cb(code, table.concat(stdout_chunks, ""), table.concat(stderr_chunks, ""))
      end,
    })
    if job <= 0 then
      cb(1, "", "jobstart failed")
      return
    end
    vim.fn.chansend(job, input)
    vim.fn.chanclose(job, "stdin")
  end

  vim.api.nvim_create_user_command("AsyncFilter", function(opts)
    local bufnr = 0
    local l1, l2 = opts.line1, opts.line2
    if opts.range == 0 then
      l1 = vim.api.nvim_win_get_cursor(0)[1]
      l2 = l1
    end

    local ns = new_ns()
    highlight_range(bufnr, ns, l1, l2)

    local lines = vim.api.nvim_buf_get_lines(bufnr, l1 - 1, l2, false)
    local input = table.concat(lines, "\n") .. "\n" -- send trailing newline like :%!

    local function finish(code, out, err)
      vim.schedule(function()
        if code == 0 and vim.api.nvim_buf_is_loaded(bufnr) then
          replace_lines(bufnr, l1, l2, out)
        else
          vim.notify(string.format("AsyncFilter failed (%d): %s", code, err or ""), vim.log.levels.ERROR)
        end
        clear_range(bufnr, ns, l1, l2)
      end)
    end

    if vim.system then
      run_vim_system(opts.args, input, finish)
    else
      run_jobstart(opts.args, input, finish)
    end
  end, {
    range = true,
    nargs = 1,
    complete = "shellcmd",
    desc = "Asynchronously filter the given range through a shell command, highlighting while it runs",
  })
end
