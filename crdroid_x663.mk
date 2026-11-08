$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/infinix/x663/device.mk)

$(call inherit-product, vendor/crdroid/config/common_full_phone.mk)

PRODUCT_NAME := crdroid_x663
PRODUCT_DEVICE := x663
PRODUCT_BRAND := Infinix
PRODUCT_MANUFACTURER := INFINIX MOBILITY LIMITED
PRODUCT_MODEL := Infinix X663

# Verify on the phone: wm density (the upstream X663 tree uses 320).
TARGET_SCREEN_DENSITY := 480

# No super.img: a super built without `vendor` would erase the stock vendor
# partition when flashed. Flash system/system_ext/product images individually
# from PBRP instead. Set this to true only when vendor is part of the build.
PRODUCT_BUILD_SUPER_PARTITION := false
