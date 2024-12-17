#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/realme
rm -rf kernel/oplus
rm -rf vendor/realme
rm -rf hardware/oplus
rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf vendor/oplus
rm -rf vendor/lineage-priv/keys/
# rm -rf packages/apps/ViMusic
# rm -rf packages/apps/Droid-ify


echo "========================================================================"
echo "DELETED DIRECTORIES"
echo "========================================================================"


repo init -u https://github.com/2by2-Project/android.git -b 15 --git-lfs

echo "========================================================================"
echo "REPO INITIALIZED"
echo "========================================================================"


# Clone local_manifests repository
git clone https://github.com/Debarpan102/android-aosp-local-manifests --depth 1 -b 15-2by2 .repo/local_manifests
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
sudo apt install openssl libssl-dev && sudo apt install libssl-dev
sudo apt-get install -y libfl-dev


echo "========================================================================"
echo "SYSTEM UPGRADED"
echo "========================================================================"


# Clone Keys

DIRKEYS="vendor/lineage-priv/keys/"
# Check if the directory exists
if [ -d "$DIRKEYS" ]; then
    echo "Directory $DIRKEYS exists. Deleting it..."
    rm -rf "$DIRKEYS"
    echo "Directory deleted."
else
    echo "Directory $DIRKEYS does not exist. No need to delete."
fi

#echo "Cloning the repository..."
#git clone https://github.com/DevInfinix/devinfinix-aosp-roms-keys --depth=1 -b 14.0-los21 "$DIRKEYS"

echo "========================================================================"
echo "NOT CLONING KEYS"
echo "========================================================================"


echo "========================================================================"
echo "BUILDING........."
echo "========================================================================"


# Lineage22 
source build/envsetup.sh
lunch lineage_ice-ap3a-userdebug
mka bacon
