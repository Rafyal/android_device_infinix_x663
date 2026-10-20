# Inherit konfigurasi dasar crDroid
$(call inherit-product, vendor/crdroid/config/common_full_phone.mk)

# API Level dan VNDK dari stock vendor
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_EXTRA_VNDK_VERSIONS := 31

# Memaksa ADB aktif untuk keperluan debug (hapus saat build final)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=adb
