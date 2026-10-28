$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/infinix/x663/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
PRODUCT_PACKAGES -= DownloadProvider DownloadProviderUi

PRODUCT_NAME := crdroid_x663
PRODUCT_DEVICE := x663
PRODUCT_BRAND := Infinix
PRODUCT_MANUFACTURER := INFINIX MOBILITY LIMITED
PRODUCT_MODEL := Infinix X663
TARGET_SCREEN_DENSITY := 480
PRODUCT_BUILD_SUPER_PARTITION := false

PRODUCT_COPY_FILES += \
    device/infinix/x663/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml
