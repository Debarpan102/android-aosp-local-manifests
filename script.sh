#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf hardware/qcom-caf/sm8350/audio
rm -rf vendor/qcom/common
rm -rf tools/extract-utils
# rm -rf vendor/bcr
# rm -rf vendor/lineage-priv/keys/
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

echo "========================================================================"
echo "REPO INITIALIZED AND SYNCED"
echo "========================================================================"


# Clone repos
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus

git clone https://github.com/Infinity-X-Devices/device_realme_ice.git -b 16 device/realme/ice
git clone https://github.com/Debarpan102/android_device_oneplus_sm8350-common.git -b 3.0-infinityX device/oneplus/sm8350-common
git clone --depth 1 https://github.com/Debarpan102/proprietary_vendor_realme_ice.git -b lineage-22.2 vendor/realme/ice
git clone --depth 1 https://github.com/Debarpan102/proprietary_vendor_oneplus_sm8350-common.git -b 16.0 vendor/oneplus/sm8350-common
git clone --depth 1 https://github.com/Debarpan102/android_hardware_oplus.git -b 3.0-infinityX hardware/oplus
git clone --depth 1 https://github.com/Debarpan102/kernel_oplus_RMX3461.git -b 147 kernel/oplus/RMX3461
echo "========================================================================"
echo "CLONED REPOS"
echo "========================================================================"

# sync 
/opt/crave/resync.sh

# Upgrade System and install openssl

sudo apt update && sudo apt upgrade -y
sudo apt update && sudo apt install libc6-dev
sudo apt install openssl libssl-dev -y && sudo apt install libssl-dev -y
sudo apt-get install libfl-dev -y

echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"

echo "========================================================================"
echo "NOT CLONING KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# yaap
. build/envsetup.sh
lunch infinity_ice-user
m bacon

