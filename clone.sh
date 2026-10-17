#!/bin/bash

# Clone repos
git clone https://github.com/Debarpan102/android_device_realme_ice.git -b 17.0-yaap device/realme/ice
git clone https://github.com/Debarpan102/android_device_oneplus_sm8350-common.git -b test device/oneplus/sm8350-common
git clone https://github.com/Debarpan102/proprietary_vendor_realme_ice.git -b 16.0 vendor/realme/ice
git clone https://github.com/Debarpan102/proprietary_vendor_oneplus_sm8350-common.git -b seventeen vendor/oneplus/sm8350-common
git clone https://github.com/Debarpan102/android_hardware_oplus.git -b seventeen hardware/oplus
git clone https://github.com/Debarpan102/kernel_oneplus_sm8350.git -b seventeen kernel/oneplus/sm8350
git clone https://gitlab.com/ziti-resources/vendor_oplus_camera.git -b 17 vendor/oplus/camera