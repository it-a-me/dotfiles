#!/bin/sh 
ID="F4:4E:FD:00:71:F9"

bluetoothctl disconnect "$ID" && bluetoothctl connect "$ID"
