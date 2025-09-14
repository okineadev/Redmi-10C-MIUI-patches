#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Installing simg2img if missing..."
sudo apt install android-sdk-libsparse-utils -y
