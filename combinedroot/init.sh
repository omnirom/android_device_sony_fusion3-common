#!/sbin/busybox sh
set +x
_PATH="$PATH"
export PATH=/sbin

busybox cd /
busybox date >>boot.txt
exec >>boot.txt 2>&1
busybox rm /init

# include device specific vars
source /sbin/bootrec-device

# create directories
busybox mkdir -m 755 -p /dev/block
busybox mkdir -m 755 -p /dev/input
busybox mkdir -m 555 -p /proc
busybox mkdir -m 755 -p /sys

# create device nodes
# Per linux Documentation/devices.txt
busybox mknod -m 600 /dev/block/mmcblk0 b 179 0
for i in $(busybox seq 0 12); do
	busybox mknod -m 600 /dev/input/event${i} c 13 $(busybox expr 64 + ${i})
done
busybox mknod -m 666 /dev/null c 1 3

# mount filesystems
busybox mount -t proc proc /proc
busybox mount -t sysfs sysfs /sys

# trigger vibration
busybox echo 100 > ${BOOTREC_VIBRATOR}

# trigger blue(-ish) LED
busybox echo 51 > ${BOOTREC_LED_RED}
busybox echo 181 > ${BOOTREC_LED_GREEN}
busybox echo 229 > ${BOOTREC_LED_BLUE}

# android ramdisk
load_image=/sbin/ramdisk.cpio

# keycheck
busybox timeout -t 3 keycheck

# boot decision
if [ $? -eq 42 ] || busybox grep -q warmboot=0x77665502 /proc/cmdline ; then
	busybox echo 'RECOVERY BOOT' >>boot.txt
	# white(-ish) led for recoveryboot
	busybox echo 131 > ${BOOTREC_LED_RED}
	busybox echo 229 > ${BOOTREC_LED_GREEN}
	busybox echo 51 > ${BOOTREC_LED_BLUE}
	# recovery ramdisk
	busybox mknod -m 600 ${BOOTREC_FOTA_NODE}
	busybox mount -o remount,rw /
	busybox ln -sf /sbin/busybox /sbin/sh
	extract_elf_ramdisk -i ${BOOTREC_FOTA} -o /sbin/ramdisk-recovery.cpio -t / -c
	if [ $? -eq 255 ]; then
		# Try again!
		busybox echo 'Unable to extract FOTAKernel ramdisk! Retrying...' >>boot.txt
		extract_elf_ramdisk -i ${BOOTREC_FOTA} -o /sbin/ramdisk-recovery.cpio -t / -d
		busybox mv /sbin/ramdisk-recovery.cpio /sbin/ramdisk-recovery.cpio.lzma
		busybox lzma -d /sbin/ramdisk-recovery.cpio.lzma
	fi
	busybox rm /sbin/sh
	load_image=/sbin/ramdisk-recovery.cpio
else
	busybox echo 'ANDROID BOOT' >>boot.txt
	# poweroff LED
	busybox echo 0 > ${BOOTREC_LED_RED}
	busybox echo 0 > ${BOOTREC_LED_GREEN}
	busybox echo 0 > ${BOOTREC_LED_BLUE}
fi

# unpack the ramdisk image
busybox cpio -ui < ${load_image}

busybox umount /proc
busybox umount /sys

busybox rm -fr /dev/*
busybox date >>boot.txt
export PATH="${_PATH}"
exec /init
