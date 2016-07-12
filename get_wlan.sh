# !/bin/bash
date
# first_wlan=$(ifconfig | awk '/eth/ && NR==1 {print $1}')
first_wlan=$(iwconfig | awk '/wlan/ && NR==1 {print $1}')
echo "first wlan:<"$first_wlan">"

