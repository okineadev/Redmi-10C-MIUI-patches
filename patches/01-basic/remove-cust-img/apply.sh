#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

rm images/cust.img
git apply "$SCRIPT_DIR/remove-cust-img.patch"
