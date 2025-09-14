#!/usr/bin/env bash

source scripts/shared/lib.sh

log "Downloading lpunpack & lpmake..."
wget -q https://raw.githubusercontent.com/Exynos-nibba/lpunpack-lpmake-mirror/d0f9da322b764871e54072d1b3e9d67c09cd715c/binary/{lpunpack,lpmake}
chmod +x ./lpunpack ./lpmake
