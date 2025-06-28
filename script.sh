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
# rm -rf vendor/bcr
# rm -rf vendor/lineage-priv/keys/
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

repo init -u https://github.com/yaap/manifest.git -b sixteen --git-lfs

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

git clone https://github.com/Debarpan102/android_device_realme_ice.git -b 16.0-yaap device/realme/ice
git clone https://github.com/Debarpan102/android_device_oneplus_sm8350-common.git -b 16.0-yaap device/oneplus/sm8350-common
git clone --depth 1 https://github.com/Debarpan102/proprietary_vendor_realme_ice.git -b lineage-22.2 vendor/realme/ice
git clone --depth 1 https://github.com/Debarpan102/proprietary_vendor_oneplus_sm8350-common.git -b 16 vendor/oneplus/sm8350-common
git clone --depth 1 https://github.com/Debarpan102/android_hardware_oplus.git -b 16.0-yaap hardware/oplus
git clone --depth 1 https://github.com/Debarpan102/kernel_oplus_RMX3461.git -b stable-r1 kernel/oplus/RMX3461
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

export CLANG_PATH=$PWD/prebuilts/clang/host/linux-x86/clang-r522817/bin
export PATH=$CLANG_PATH:$PATH
alias clang=$CLANG_PATH/clang
alias clang++=$CLANG_PATH/clang++
alias ld.lld=$CLANG_PATH/ld.lld
export CC=$CLANG_PATH/clang
export CXX=$CLANG_PATH/clang++
export LD=$CLANG_PATH/ld.lld

git config --global user.email "debarpan102github@gmail.com"
git config --global user.name "Debarpan102"
cd hardware/qcom-caf/sm8350/audio/hal/audio_extn
git fetch https://github.com/StatiXOS/android_hardware_qcom_audio refs/changes/34/15434/2 && git cherry-pick FETCH_HEAD
cd -
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
lunch yaap_ice-user
m yaap

