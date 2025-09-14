#!/usr/bin/env bash

# Run only the top-level scripts (00–05)
for script in scripts/cookimg/super.img/*.sh; do
  bash "$script"
done
