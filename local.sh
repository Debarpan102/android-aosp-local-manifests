#!/bin/bash

# repo init
repo init -u https://github.com/yaap/manifest.git -b seventeen --git-lfs

repo sync -j$(nproc --all) --no-tags --no-clone-bundle --current-branch

# hals
rm -rf hardware/qcom-caf/sm8350/audio
git clone https://github.com/LineageOS/android_hardware_qcom_audio.git -b lineage-24.0-caf-sm8350 hardware/qcom-caf/sm8350/audio

#fixup
cd hardware/lineage/compat
git remote add derp https://github.com/DerpFest-AOSP/android_hardware_lineage_compat.git
git fetch derp
git cherry-pick 47184142ffd1d5215169d134689705245cc11030
cd -

rm -rf vendor/qcom/opensource/commonsys-intf/display
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_display-commonsys-intf.git vendor/qcom/opensource/commonsys-intf/display
