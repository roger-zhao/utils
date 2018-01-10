#!/bin/sh

echo $1 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$1/direction

COUNTER=0
while [ $COUNTER -lt $2 ]; do
   echo 1 > /sys/class/gpio/gpio$1/value
   sleep .35
   echo 0 > /sys/class/gpio/gpio$1/value
   sleep .65
   done

echo $1 > /sys/class/gpio/unexport


