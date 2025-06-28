#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
# rm -rf vendor/bcr
# rm -rf vendor/lineage-priv/keys/
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

repo init -u https://github.com/yaap/manifest.git -b sixteen --git-lfs

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/Debarpan102/android-aosp-local-manifests --depth 1 -b 16.0-yaap .repo/local_manifests
if [ ! 0 == 0 ]
    then curl -o .repo/local_manifests https://github.com/Debarpan102/android-aosp-local-manifests.git
fi

echo "========================================================================"
echo "CLONED REPOS"
echo "========================================================================"


# Resync

/opt/crave/resync.sh

echo "========================================================================"
echo "RESYNCED"
echo "========================================================================"


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

