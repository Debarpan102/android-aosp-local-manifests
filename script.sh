#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/bcr
# rm -rf vendor/lineage-priv/keys/
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"

repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/Debarpan102/android-aosp-local-manifests --depth 1 -b lineage-22.1 .repo/local_manifests
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


echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"

echo "========================================================================"
echo "NOT CLONING KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Lineage-22.1
source build/envsetup.sh
breakfast ice
