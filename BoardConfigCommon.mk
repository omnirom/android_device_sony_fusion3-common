# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from Sony common
include device/sony/common/BoardConfigCommon.mk

# inherit from msm8960-common
include device/sony/msm8960-common/BoardConfigCommon.mk

TARGET_SPECIFIC_HEADER_PATH += device/sony/fusion3-common/include

# Kernel properties
TARGET_KERNEL_SOURCE := kernel/sony/apq8064

# Platform
TARGET_BOOTLOADER_BOARD_NAME := MSM8960
TARGET_BOARD_PLATFORM := msm8960
BOARD_VENDOR_PLATFORM := fusion3

# Dumpstate
BOARD_LIB_DUMPSTATE := libdumpstate.sony

# Architecture
TARGET_CPU_VARIANT := krait

# Bionic
BOARD_USES_LEGACY_MMAP := true

# Kernel information
BOARD_KERNEL_BASE     := 0x80200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE  := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 maxcpus=2 androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS  := --ramdisk_offset 0x02000000

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME          := "wlan"
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"

BOARD_USE_SONY_MACUPDATE := true

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_RELEASE_CPPFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
TARGET_NO_RPC := true

# Bluetooth
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_CUSTOM_BOOTIMG_MK := device/sony/fusion3-common/custombootimg.mk
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB := device/sony/fusion3-common/rootdir/fstab.qcom
RECOVERY_FSTAB_VERSION := 2

# Filesystem
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

# QCOM/CAF hardware
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
BOARD_USES_QCOM_HARDWARE := true
TARGET_QCOM_AUDIO_VARIANT := caf
TARGET_QCOM_DISPLAY_VARIANT := caf
TARGET_QCOM_MEDIA_VARIANT := caf

# Graphics
BOARD_EGL_CFG := device/sony/fusion3-common/rootdir/system/lib/egl/egl.cfg
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_LEGACY_ALSA_AUDIO := true
TARGET_USES_QCOM_COMPRESSED_AUDIO := true
BOARD_HAVE_NEW_QCOM_CSDCLIENT := true

# Sensors
SOMC_CFG_SENSORS := true
SOMC_CFG_SENSORS_LIGHT_LM3533 := yes
SOMC_CFG_SENSORS_GYRO_MPU3050 := yes
SOMC_CFG_SENSORS_PROXIMITY_APDS9702 := yes
SOMC_CFG_SENSORS_ACCEL_BMA250NA_INPUT := yes
SOMC_CFG_SENSORS_COMPASS_AK8963 := yes

# TWRP
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_HAS_NO_RECOVERY_PARTITION := true
TW_FLASH_FROM_STORAGE := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
#TW_INCLUDE_CRYPTO := true
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/platform/msm_sdcc.1/by-name/userdata"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,barrier=1,noauto_da_alloc,discard"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"
TW_INCLUDE_FUSE_EXFAT := true
TW_MAX_BRIGHTNESS := 255
TW_NO_USB_STORAGE := true
TW_NO_SCREEN_BLANK := true

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/sony/fusion3-common/sepolicy

BOARD_SEPOLICY_UNION += \
    bluetooth_loader.te \
    bridge.te \
    camera.te \
    device.te \
    dhcp.te \
    domain.te \
    drmserver.te \
    file.te \
    file_contexts \
    init.te \
    init_shell.te \
    kickstart.te \
    mac_update.te \
    mediaserver.te \
    mpdecision.te \
    netd.te \
    netmgrd.te \
    property_contexts \
    qmux.te \
    rild.te \
    servicemanager.te \
    surfaceflinger.te \
    system_app.te \
    system_server.te \
    tee.te \
    te_macros \
    thermald.te \
    ueventd.te \
    wpa_supplicant.te

# Logd
TARGET_USES_LOGD := false

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Memory management
MALLOC_IMPL := dlmalloc
