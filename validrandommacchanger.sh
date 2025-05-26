#!/bin/bash
read -p "Network Device Name: " interface
ip link set dev "$interface" down
macchanger -l > vendormac.txt
vendor_unique_identifier=$(shuf -n1 vendormac.txt | awk '{print$3}')
device_identifier=$(printf '%02x:%02x:%02x' $[RANDOM%255] $[RANDOM%255] $[RANDOM%255])
ip link set dev "$interface" address "$vendor_unique_identifier:$device_identifier" 
ip link set dev "$interface" up
echo "Your new mac address is : $vendor_unique_identifier:$device_identifier"
