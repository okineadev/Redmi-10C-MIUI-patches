#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

product_a="images/super/product_a"

sudo git apply "$SCRIPT_DIR/remove-default-audiorecording-permissions.patch"

# Remove bloatware APKs from the `product_a.img` file, including Google apps and other unnecessary applications.
sudo rm -rf \
    $product_a/app/{CalendarGoogle,GameCenterGlobal,GoogleLocationHistory,GoogleOne,MIUIGuardProviderGlobal,MIUIMiPicks,MIUISecurityAddGlobal,MiLinkGlobal,YouTube,com.google.mainline.telemetry,PaymentService_Global,MIUIVideoPlayer,PlayAutoInstallStubApp,MSA-Global} \
    $product_a/data-app/{Drive,GlobalWPSLITE,GoogleNews,MIBrowserGlobal_removable,MICOMMUNITY_OVERSEA,MIDrop,MISTORE_OVERSEA,Meet,MicrosoftOneDrive,Opera,Podcasts,SmartHome,Videos,YTMusic} \
    $product_a/pangu/system/app/facebook-appmanager \
    $product_a/pangu/system/priv-app/{dtag-appenabler,facebook-installer,facebook-services} \
    $product_a/priv-app/{FamilyLinkParentalControls,GoogleAssistant,MIUIMusicGlobal,MIUIYellowPageGlobal}

# Remove dynamic icons
sudo rm -rf $product_a/media/theme/miui_mod_icons/dynamic/**

# Remove all partner IDs
sudo sed -i -E '/^ro\.(booking|netflix|wps|csc\.spotify|facebook)/d' "images/super/product_a/etc/build.prop"
