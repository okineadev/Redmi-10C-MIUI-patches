#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Converting userdata.img..."
simg2img images/userdata.img images/userdata.raw.img

log "Mounting userdata.raw.img..."
mkdir -p images/userdata
sudo mount -t f2fs -o loop,rw images/userdata.raw.img images/userdata

log "Applying userdata patches..."
./patches/02-userdata.img/apply.sh

log "Repacking userdata.img..."
sudo umount images/userdata
rm -f images/userdata.img
img2simg images/userdata.raw.img images/userdata.img
rm -f images/userdata.raw.img
rm -rf images/userdata
