#! /bin/sh
sleep 10
date
echo "===================================================================================================="
echo "start to execute $0"

if ! id | grep -q root; then
	echo "must be run as root"
	exit
fi

echo "start to get current fs drive"
unset root_drive
unset expect_file
unset uboot_file
unset img_file
# img_file="/root/SMT-version.img.gz"
img_file="/root/SMT-fs.tar.gz"

root_drive="$(cat /proc/cmdline | sed 's/ /\n/g' | grep root=UUID= | awk -F 'root=' '{print $2}' || true)"
if [ ! "x${root_drive}" = "x" ] ; then
	root_drive="$(/sbin/findfs ${root_drive} || true)"
else
    root_drive="$(cat /proc/cmdline | sed 's/ /\n/g' | grep root=PARTUUID= | awk -F 'root=' '{print $2}' || true)"
    if [ ! "x${root_drive}" = "x" ] ; then
	    root_drive="$(/sbin/findfs ${root_drive} || true)"
    else
	    root_drive="$(cat /proc/cmdline | sed 's/ /\n/g' | grep root= | awk -F 'root=' '{print $2}' || true)"
    fi
fi
#echo $root_drive 
if [ "x${root_drive}" = "x/dev/mmcblk0p2" ] ; then
	#expect_file="/dev/mmcblk1p2"
	expect_file="/dev/mmcblk1"
    uboot_file=/dev/mmcblk0p1
fi

if [ "x${root_drive}" = "x/dev/mmcblk1p2" ] ; then
	#expect_file="/dev/mmcblk0p2"
	expect_file="/dev/mmcblk0"
    uboot_file=/dev/mmcblk1p1
fi

if [ "x${root_drive}" = "x/dev/mmcblk1p1" ] ; then
	#expect_file="/dev/mmcblk0p2"
	expect_file="/dev/mmcblk0"
    uboot_file=/dev/mmcblk1p1
fi

if [ "x${root_drive}" = "x/dev/mmcblk0p1" ] ; then
	#expect_file="/dev/mmcblk0p2"
	expect_file="/dev/mmcblk1"
    uboot_file=/dev/mmcblk1p1
fi

echo "cuurent fs drive :" $root_drive
echo "expect file :"$expect_file
sd_flag_file="/root/sd_new_img"

if [ -f $sd_flag_file ];then
        echo "Running in SD OS"
        echo "execute dd cmd to flash new version"
        echo none > /sys/class/leds/beaglebone:green:usr3/trigger
        echo ".................flashing.........................."
        
        tmp_fs=/root/tmp
        mkdir -p $tmp_fs
        mount ${expect_file}p2 $tmp_fs
        rm -rf ${tmp_fs}/*
        sync
        sync
        tar -zxvf $img_file -C ${tmp_fs}
        umount ${tmp_fs}
        #zcat /home/debian/Flash_APM_Dir/SMT-2015-12-05_debian-OS_ZM8620.img.gz |dd of=$expect_file bs=8M
        # zcat $img_file | dd of=$expect_file bs=512 count=7400001
	    set -v on
        # zcat $img_file | dd of=$expect_file bs=8M 
        sync 
        sync 
        sync 
        sync 
        sleep 2
        # echo 0 > /sys/class/leds/beaglebone:green:usr3/brightness
        # echo 255 > /sys/class/leds/beaglebone:green:usr3/brightness
	# alarm
        # echo 80 > /sys/class/gpio/export
	    # echo out > /sys/class/gpio/gpio80/direction
	    # echo 1 > /sys/class/gpio/gpio80/value

        echo ".................flash successfully !!!"
        echo "pls remove sd card and reboot!!"
else
        echo "Running in EMMC OS"
        echo "start to judge if insert sd card"
        if [ ! x"$(fdisk -l | grep $expect_file | awk '{print $1}')" = x ];then       
        #if [ $expect_file = $(fdisk -l | grep $expect_file | awk '{print $1}') ];then       
           echo "sd card inserted"
#           mv /boot/uboot/MLO /boot/uboot/MLO.bk
#           mv /boot/uboot/u-boot.img /boot/uboot/u-boot.img
           echo "reboot!!!"
           sync
           sync
           echo "$0 end !!!"
#           reboot
        else
           echo "not insert sd card"
           exit
        fi
fi

date
echo "$0 end !!!"
echo "===================================================================================================="
