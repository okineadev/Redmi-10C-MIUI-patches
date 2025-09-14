#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Converting and unpacking super.img..."
simg2img images/super.img images/super.unsparse.img
mkdir -p images/super
./lpunpack images/super.unsparse.img images/super
