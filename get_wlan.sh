# !/bin/bash
date

wl=$(iwconfig | awk '/wlan/ && NR==1 {print $1}')
echo $wl 
echo $wl | egrep "^wlan" >/dev/null 2>&1
if [ $? -eq 0  ]; then
       #echo yes
       ifdown $wl
       ./create_ap
fi

