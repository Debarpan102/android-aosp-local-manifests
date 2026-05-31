#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oneplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf hardware/qcom-caf/sm8350/ 
rm -rf vendor/qcom/
rm -rf tools/extract-utils/
rm -rf dump/
rm -rf dump1/
rm -rf dump2/
rm -rf prebuilts/gcc/linux-x86/
rm -rf dump3/
rm -rf release-files/
rm -rf release-files-eng
rm -rf release-files-gapps
rm -rf release-files-user
echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

# repo init
repo init -u https://github.com/yaap/manifest.git -b sixteen --git-lfs

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"

# Clone repos
git clone https://github.com/Debarpan102/android_device_realme_ice.git -b 16.0-yaap device/realme/ice
git clone https://github.com/Debarpan102/android_device_oneplus_sm8350-common.git -b 16.0-yaap device/oneplus/sm8350-common
git clone https://github.com/Debarpan102/proprietary_vendor_realme_ice.git -b 16.0 vendor/realme/ice
git clone https://github.com/Debarpan102/proprietary_vendor_oneplus_sm8350-common.git -b sixteen vendor/oneplus/sm8350-common
git clone https://github.com/Debarpan102/android_hardware_oplus.git -b sixteen hardware/oplus
git clone https://github.com/Debarpan102/kernel_oneplus_sm8350.git -b rebase-05312026 kernel/oneplus/sm8350

echo "========================================================================"
echo "CLONED REPOS"
echo "========================================================================"

# sync 
/opt/crave/resync.sh

# hals
rm -rf hardware/qcom-caf/sm8350/audio
git clone https://github.com/LineageOS/android_hardware_qcom_audio.git -b lineage-23.2-caf-sm8350 hardware/qcom-caf/sm8350/audio

#fixup
cd hardware/lineage/compat
git remote add derp https://github.com/DerpFest-AOSP/android_hardware_lineage_compat.git
git fetch derp
git cherry-pick 47184142ffd1d5215169d134689705245cc11030
cd -

echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"

# yaap
. build/envsetup.sh
lunch yaap_ice-eng
m yaap
mkdir release-files-eng
cp -r out/target/product/ice/YAAP-16* release-files-eng/
lunch yaap_ice-user
TARGET_BUILD_GAPPS=true m yaap
mkdir release-files-gapps
cp -r out/target/product/ice/YAAP-16* release-files-gapps/
lunch yaap_ice-user
m yaap
mkdir release-files-user
cp -r out/target/product/ice/YAAP-16* release-files-user/

echo "========================================================================"
echo "BUILD COMPLETE"
echo "========================================================================"
