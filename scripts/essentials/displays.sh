#!/bin/bash

# Install Arandr GUI app
sudo apt install arandr

# Install autorandr
sudo apt-get install autorandr


# Allow touch-pad on i3wm
xinput set-prop "MSFT0001:00 06CB:7F28 Touchpad" "libinput Tapping Enabled" 1
