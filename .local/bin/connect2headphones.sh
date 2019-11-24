#!/usr/bin/env sh
sudo systemctl start bluetooth.service
sleep 2 && bluetoothctl connect 41:42:88:68:2D:3D
