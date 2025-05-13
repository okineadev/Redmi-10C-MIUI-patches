#!/usr/bin/env bash

# Remove partner ID between Xiaomi and OneDrive
sudo rm images/super/mi_ext_a/product/etc/onedrive_token.txt
sudo sed -i '/^ro\.microsoft\.onedrive_partner_code=\/mi_ext\/product\/etc\/onedrive_token\.txt$/d' images/super/mi_ext_a/etc/build.prop
