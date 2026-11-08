#
# BoardConfig.mk - Infinix Note 11 (X663), MT6769H / MT6768 platform
#
# Verified on the device:
#   ro.hardware        = mt6768
#   ro.vendor.api_level = 30        -> stock vendor is Android 11
#   lpdump             = virtual A/B: system_a/system_ext_a/product_a/vendor_a
#                        inside a single physical super, _b slots empty
#   super              = 7755374592 bytes, group "main" max = 7744888832
#   boot               = 100663296 bytes (96 MiB, after the repartitioner)
#
# Layout: virtual A/B + dynamic partitions, recovery lives in boot,
# kernel + dtb are PREBUILT from the stock boot.img.
#
DEVICE_PATH := device/infinix/x663

# ------------------------------------------------------------------ build hacks
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

-include vendor/infinix/x663/BoardConfigVendor.mk

# ------------------------------------------------------------------ virtual A/B
AB_OTA_UPDATER := true
BOARD_USES_RECOVERY_AS_BOOT := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta_system \
    vendor

# ------------------------------------------------------------------ architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_USES_64_BIT_BINDER := true

# ------------------------------------------------------------------ platform
TARGET_BOARD_PLATFORM := mt6768
TARGET_BOOTLOADER_BOARD_NAME := mt6768
TARGET_NO_BOOTLOADER := true

# ------------------------------------------------------------------ kernel (prebuilt)
BOARD_KERNEL_IMAGE_NAME := Image.gz

BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_KERNEL_SECOND_OFFSET := 0x00e88000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user

# Populated by extract_boot.sh from the stock boot.img.
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtb
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --board "CY-X663-H6915"

BOARD_KERNEL_SEPARATED_DTBO := false
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# ------------------------------------------------------------------ partitions
# Values below come from `lpdump` on the device.
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Virtual A/B: one physical super, slot-suffixed logical partitions.
BOARD_SUPER_PARTITION_SIZE := 7755374592
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 7744888832

# Current on-device sizes, for reference:
#   system_a      5690392 sectors  ~2.71 GiB
#   system_ext_a  4019320 sectors  ~1.92 GiB
#   vendor_a      1879864 sectors  ~918 MiB
#   product_a       21256 sectors  ~10.4 MiB
# ~1.66 GiB of group space is free, so a ROM system image can grow.
BOARD_MAIN_PARTITION_LIST := \
    product \
    system \
    system_ext \
    vendor

BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6768
TARGET_OTA_ASSERT_DEVICE := Infinix-X663,X663

# ------------------------------------------------------------------ verified boot
# flags 3 = disable dm-verity + disable verification. Without this the bootloader
# rejects boot/vbmeta signed with test keys and you get an immediate bootloop.
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# ------------------------------------------------------------------ VINTF
# Intentionally empty: the stock vendor partition already ships its own
# /vendor/etc/vintf/manifest.xml (49 HALs, target-level 5 = Android 11).
# Registering that same file as DEVICE_MANIFEST_FILE would make the *system*
# claim to provide vendor HALs and fail the runtime VINTF check.
# Add DEVICE_MANIFEST_FILE back only when you start building vendor from blobs.
# DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/manifest.xml

# ------------------------------------------------------------------ sepolicy
# NOT set: the stock vendor partition carries its own compiled vendor policy.
# sepolicy/vendor/ in this tree has an empty file_contexts and no .te files,
# so registering it would replace a working policy with an empty one.
# BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true

# ------------------------------------------------------------------ VNDK
# ro.vendor.api_level = 30 confirmed on the device.
BOARD_VNDK_VERSION := 30
VENDOR_SECURITY_PATCH := 2023-09-05

# ------------------------------------------------------------------ crDroid
# BoardConfigCrdroid.mk is part of vendor/crdroid. `-include` so a renamed or
# missing file does not abort the build (verify: ls vendor/crdroid/config/).
-include vendor/crdroid/config/BoardConfigCrdroid.mk
