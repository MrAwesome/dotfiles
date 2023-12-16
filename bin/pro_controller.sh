#!/bin/bash

CONTROLLER_BLUETOOTH_NAME="Pro Controller"

INITIAL_SUCCESS=$(timeout 10 bluetoothctl connect 'DC:CD:18:A3:7D:3E' | rg "Paired: yes")

if [[ -n "$INITIAL_SUCCESS" ]]; then
    echo "Successfully connected to Pro Controller"
    exit 0
fi

# Get the MAC address of the Pro Controller
echo "Press the sync button on the controller, then wait up to 10 seconds..."
CONTROLLER=$(timeout 10 bluetoothctl scan on | rg "$CONTROLLER_BLUETOOTH_NAME" | awk '{ print $3 }')

if [[ -z "$CONTROLLER" ]]; then
    bluetoothctl connect 'DC:CD:18:A3:7D:3E'
else
    bluetoothctl connect "$CONTROLLER"
fi 

