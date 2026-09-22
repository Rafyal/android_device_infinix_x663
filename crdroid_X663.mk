# Inherit from Android AOSP core
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from crDroid common configuration
$(call inherit-product, vendor/crdroid/config/common.mk)

# Device identifier
PRODUCT_NAME := crdroid_X663
PRODUCT_DEVICE := X663
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix Note 11
PRODUCT_MANUFACTURER := Infinix
