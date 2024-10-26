#!/bin/sh

TARGET_PATH=$1

buddy=/usr/libexec/PlistBuddy

INFO="$TARGET_PATH/Info.plist"
INFO_EXT="$TARGET_PATH/Plugins/NSE.appex/Info.plist"

$buddy -c "Set:CFBundleIdentifier 'that.app.adhoc'" $INFO
$buddy -c "Set:CFBundleIdentifier 'that.app.adhoc.nse'" $INFO_EXT
