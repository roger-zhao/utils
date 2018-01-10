#! /bin/bash
date

echo "==========================================================================="

KERNEL_DIR=tmp_kernel

if [ $# = 0 ]
then
    echo " Usage: $1 <kernel_file_name>"
    echo "==========================================================================="
    exit
else
    # echo "dtb"
    rm -rf $KERNEL_DIR
    mkdir $KERNEL_DIR
    tar -zvxf $1 -C $KERNEL_DIR
    cd $KERNEL_DIR
    echo "zImage"
    cp -f zImage /boot/uboot/
    echo "modules"
    cp -rf lib/modules /lib/
    echo "am335x-boneblack.dtb"
    # cp -f dtbs/am335x-boneblack-forSMT.dtb /boot/uboot/dtbs/am335x-boneblack.dtb
    cd -
    # rm -rf $KERNEL_DIR
fi
sync
sync

echo "update $1 done, need to reboot..."
echo "==========================================================================="


