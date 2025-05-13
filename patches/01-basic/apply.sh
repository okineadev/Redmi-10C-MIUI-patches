#!/usr/bin/env bash

# shellcheck disable=SC1091

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# Unlock anti-rollback protection
. "$SCRIPT_DIR/unlock-anti_version.sh"

# Fix Python scripts
git apply "$SCRIPT_DIR/update-scripts-to-python3.patch"

# Remove `images/cust.img` and all other references to it
. "$SCRIPT_DIR/remove-cust-img/apply.sh"
