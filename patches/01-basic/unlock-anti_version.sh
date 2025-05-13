#!/usr/bin/env bash

# Set anti_version to 2 to bypass anti-rollback protection
# Anti-rollback version on Redmi 10C is always `1`
# So we need to set greater version like `2`
echo "2" > images/anti_version.txt
