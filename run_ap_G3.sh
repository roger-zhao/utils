#!/bin/sh

date
rmmod r8188eu
sleep 1
insmod 8188eu.ko
sleep 3

wl=$(iwconfig | awk '/wl/ && NR==1 {print $1}')
ip link set $wl name wlan0
ifconfig wlan0 down 
ifconfig wlan0 up
sleep 1

/root/WU810N-AP/control_ap start wlan0 eth0
