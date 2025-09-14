#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Applying base patches..."
./patches/01-basic/apply.sh
