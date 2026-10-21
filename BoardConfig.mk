DEVICE_PATH := device/infinix/x663

# Arsitektur
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

TARGET_BOARD_PLATFORM := mt6768

# Tanpa kernel/bootloader/radio: pakai boot dan vendor stock
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_NO_RADIOIMAGE := true

# Filesystem dan metadata
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_METADATA_PARTITION := true

# Dynamic partitions (dari lpdump Virtual A/B)
BOARD_SUPER_PARTITION_SIZE := 7755374592
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 7744888832
BOARD_MAIN_PARTITION_LIST := system

# Treble
BOARD_VNDK_VERSION := current

# Tambah di paling bawah:
include vendor/lineage/config/BoardConfigLineage.mk
