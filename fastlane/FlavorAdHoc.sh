#!/bin/zsh

#Relative to fastlane folder
#$1 => product_name
#$2 => build dir
BUILD=../$2
ADHOC_TARGET_NAME=AdHoc$1
CONFIG_ADHOC=../../AdHocConfig
TARGET_APP=Payload/$1.app

#Unpack Release ipa
cd $BUILD
mkdir $ADHOC_TARGET_NAME
cd $ADHOC_TARGET_NAME
tar -xf ../$1.ipa

#Modify contents
$CONFIG_ADHOC/AddSettings.sh ${CONFIG_ADHOC} ${TARGET_APP}
$CONFIG_ADHOC/ReplaceIcons.sh ${CONFIG_ADHOC} ${TARGET_APP}
$CONFIG_ADHOC/SetBundleIdentifiers.sh ${TARGET_APP}

#Remove old signature
rm -rf "$TARGET_APP/_CodeSignature"
rm -rf "$TARGET_APP/Plugins/NSE.appex/_CodeSignature"

#Package AdHoc ipa
zip -r $ADHOC_TARGET_NAME.zip Payload
cd ..
mv ./$ADHOC_TARGET_NAME/$ADHOC_TARGET_NAME.zip ./$ADHOC_TARGET_NAME.ipa
rm -r ./$ADHOC_TARGET_NAME
