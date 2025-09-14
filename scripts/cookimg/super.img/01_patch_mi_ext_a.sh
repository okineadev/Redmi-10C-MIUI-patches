#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Expanding mi_ext_a.img..."
fallocate -l 50M images/super/mi_ext_a.img
e2fsck -yf images/super/mi_ext_a.img
resize2fs images/super/mi_ext_a.img 50M

log "Disabling shared_blocks for mi_ext_a.img..."
e2fsck -yE unshare_blocks images/super/mi_ext_a.img

log "Mounting mi_ext_a.img..."
mkdir -p images/super/mi_ext_a
sudo mount -t ext4 -o loop,rw images/super/mi_ext_a.img images/super/mi_ext_a

log "Applying mi_ext_a patches..."
./patches/03-super.img/01-mi_ext_a.img/apply.sh

log "Finalizing mi_ext_a.img..."
sudo umount images/super/mi_ext_a
rm -rf images/super/mi_ext_a
for i in {1..3}; do
  e2fsck -yf images/super/mi_ext_a.img
  resize2fs -M images/super/mi_ext_a.img || true
done
