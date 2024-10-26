#!/bin/sh

SOURCE_PATH=$1
TARGET_PATH=$2

#Replace icons
cp $SOURCE_PATH/AppIcon60x60@2x.png $TARGET_PATH
cp $SOURCE_PATH/AppIcon76x76@2x~ipad.png $TARGET_PATH

#Set info values
buddy=/usr/libexec/PlistBuddy
INFO="$TARGET_PATH/Info.plist"
$buddy -c "Set:CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconName 'AppIconAdHoc'" $INFO
