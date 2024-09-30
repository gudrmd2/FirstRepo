#!/usr/bin/env bash
#
# 1. recognize sd
# 2. find cmdline.txt, config.txt
# 3. find 192.168.218.2 & modify
# 4. modify echo
# 5. unmount /media/usr/bootfs&rootfs

SDPATH=/media/user/bootfs
CONFIG=config.txt
CMDLINE=cmdline.txt
IPADDR=192.168.218.2


#1
function detectSD(){
	if [ -d "${SDPATH}" ]; then 
 		echo "SD Card Detected!"
		return
	fi
		echo "CANNOT find SD!"
		exit
}

#2
function detectCMDLINE(){
	sleep 1

	if [ -f "${SDPATH}/${CMDLINE}" ]; then 
 		echo "${CMDLINE} Found!"
 		echo 0
	else
		echo "CANNOT Find ${CMDLINE}!"
		echo 1
	fi
}

detectSD
isCMDLINE=`detectCMDLINE`

if [ $isCMDLINE -eq 0 ];then
	sed -i "s/${IPADDR}/111.111.111.111/" "${SDPATH}/${CMDLINE}"
	if [ $? -eq 0 ]; then
		echo "${CMDLINE} edited successfully!"
	else
		echo "CANNOT edit ${CMDLINE}!"
	fi
fi
sleep 1

umount /media/user/bootfs/
echo "Device bootfs unmounted!"