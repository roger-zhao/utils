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
img_file="/root/SMT-G3-FS-2018-01-16.tar.gz"

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

if [ -f $sd_flag_file ];then
        echo "Running in SD OS"
        echo "execute tar cmd to backup new version"
        echo ".................backuping.........................."
        
        tmp_fs=/root/tmp
        mkdir -p $tmp_fs
        mount ${expect_file}p2 $tmp_fs
	
        sync
        sync
	cd $tmp_fs
        tar -czf $img_file * 
	cd /root;
        umount ${tmp_fs}
	set -v on
        sync 
        sync 
        sync 
        sync 
        sleep 2

        echo ".................back up successfully !!!"
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
