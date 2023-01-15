#!/bin/bash
set -e

echo "Executing pre filesystem image creation script"

# The environment variables BR2_CONFIG, HOST_DIR, STAGING_DIR,
# TARGET_DIR, BUILD_DIR, BINARIES_DIR and BASE_DIR are defined


DEFAULT_IMAGE_DIR="/openmiko/build/buildroot-2016.02/output/images"
BASE_DIR=${BASE_DIR:-/openmiko/build/buildroot-2016.02/output}
IMAGES="${BASE_DIR}/images"
HOST_DIR=${HOST_DIR:-/openmiko/build/buildroot-2016.02/output/host}
TARGET_DIR=${TARGET_DIR:-/openmiko/build/buildroot-2016.02/output/target}

#remove not needed modul. If the modul is disabled in the config, the other moduls are not built :(
rm -rf "${TARGET_DIR}/lib/modules/3.10.14/kernel/drivers/net/wireless/rtl818x/rtl8188eu"

# remove /var/log symlink. Due to overlayfs bug it is not possible to modify it. It is recreated on boot in the overlayfs
rm -rf "${TARGET_DIR}/var/log"

cd /src
GIT_REVISION=$(git rev-parse --quiet --short HEAD)

echo $GIT_REVISION > $TARGET_DIR/etc/VERSION
