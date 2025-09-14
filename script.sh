#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oneplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf hardware/qcom-caf/sm8350/audio
rm -rf vendor/qcom/
rm -rf tools/extract-utils
rm -rf prebuilts/
rm -rf dump/
rm -rf dump2/
rm -rf dump3/

echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

repo init -u https://github.com/yaap/manifest.git -b sixteen --git-lfs

echo "========================================================================"
echo "REPO INITIALIZED AND SYNCED"
echo "========================================================================"

# Clone repos

git clone https://github.com/Debarpan102/android_device_realme_ice.git -b 16.0-yaap device/realme/ice
git clone https://github.com/Debarpan102/android_device_oneplus_sm8350-common.git -b 16.0-yaap device/oneplus/sm8350-common
git clone https://github.com/Debarpan102/proprietary_vendor_realme_ice.git -b lineage-22.2 vendor/realme/ice
git clone https://github.com/Debarpan102/proprietary_vendor_oneplus_sm8350-common.git -b 16.0 vendor/oneplus/sm8350-common
git clone https://github.com/Debarpan102/android_hardware_oplus.git -b sixteen hardware/oplus
git clone https://github.com/Debarpan102/kernel_oneplus_sm8350.git -b sixteen-legacy kernel/oneplus/sm8350

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
echo "BUILDING........."
echo "========================================================================"

# yaap
. build/envsetup.sh
lunch yaap_ice-user
m yaap
mkdir release-files
cp -r out/target/product/ice/YAAP-16* release-files/
lunch yaap_ice-user
TARGET_BUILD_GAPPS=true m yaap

echo "========================================================================"
echo "BUILD COMPLETE"
echo "========================================================================"



