#!/usr/bin/env bash
# 🍳 `cookimg.sh`

source scripts/shared/lib.sh

# Run only the top-level scripts (00–05)
for script in scripts/cookimg/*.sh; do
  bash "$script"
done


# ========== DONE ==========
log "All patches applied successfully!"
