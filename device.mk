LOCAL_PATH := device/infinix/x663

# Verified on device: virtual A/B (lpdump shows system_a/system_ext_a/vendor_a/
# product_a inside one physical super) with recovery-as-boot.
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_VIRTUAL_AB_OTA := true
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_CHARACTERISTICS := phone

# First-stage fstab must land in the ramdisk; the stock vendor supplies its own
# second-stage fstab at /vendor/etc/fstab.mt6768, so it is not copied here.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6768:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6768

# ro.vendor.api_level = 30: ship the matching VNDK snapshot so system libs can
# talk to the Android 11 vendor. Drop both lines if you later build vendor.
PRODUCT_EXTRA_VNDK_VERSIONS := 30
PRODUCT_PACKAGES += com.android.vndk.v30

# configs/ (audio, media, wifi, seccomp, permissions) belongs to the vendor
# image, which is stock. Copying it into /system is either ignored or conflicts
# with the vendor copies. It stays here for the day vendor is built from blobs.
