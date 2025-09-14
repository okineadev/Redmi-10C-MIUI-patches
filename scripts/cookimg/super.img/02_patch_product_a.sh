#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Expanding product_a.img..."
fallocate -l 5G images/super/product_a.img
e2fsck -yf images/super/product_a.img
resize2fs images/super/product_a.img 5G

log "Disabling shared_blocks for product_a.img..."
e2fsck -yE unshare_blocks images/super/product_a.img

log "Mounting product_a.img..."
mkdir -p images/super/product_a
sudo mount -t ext4 -o loop,rw images/super/product_a.img images/super/product_a

log "Applying product_a patches..."
./patches/03-super.img/02-product_a.img/apply.sh

log "Finalizing product_a.img..."
sudo umount images/super/product_a
for i in {1..3}; do
  e2fsck -yf images/super/product_a.img
  resize2fs -M images/super/product_a.img || true
done
rm -rf images/super/product_a
