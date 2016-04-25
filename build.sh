#!/bin/sh

XCODE_BASE=/Applications/Xcode.app
RESULT_DIR="./app/iXpand Drive.app"
IDENTITY= #Use your own identifier

rm -f "$RESULT_DIR/iXpand Drive"
rm -rf "$RESULT_DIR"/_CodeSignature
rm -f "$RESULT_DIR"/embedded.mobileprovision
rm -f "$RESULT_DIR"/Info.plist
rm -f "$RESULT_DIR"/GoogleService-Info.plist
rm -f "iXpand Drive.app.xcent"

cp embedded.mobileprovision "$RESULT_DIR"
cp Info.plist "$RESULT_DIR"
cp GoogleService-Info.plist "$RESULT_DIR"

$XCODE_BASE/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -std=c++11 -stdlib=libstdc++ \
 -arch armv7 -arch arm64 \
 -isysroot $XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk \
 "iXpand Drive.a" \
 -dead_strip -ObjC \
 -Llib -Fframeworks \
 -l"AFNetworking" -l"BlocksKit" -l"Bolts" -l"CSStickyHeaderFlowLayout" -l"CocoaAsyncSocket" -l"CocoaHTTPServer" -l"CocoaLumberjack" -l"DFCache" -l"FBSDKCoreKit" -l"FBSDKLoginKit" -l"FXKeychain" -l"GGLCore" -l"GGLSignIn" -l"GIPNSURL+FIFE_external" -l"GSDK_Overload_external" -l"GTMOAuth2_external_external" -l"GTMOAuth2_internal_external" -l"GTMSessionFetcher_core_external" -l"GTMSessionFetcher_full_external" -l"GTMStackTrace_external" -l"GTM_AddressBook_external" -l"GTM_DebugUtils_external" -l"GTM_GTMURLBuilder_external" -l"GTM_KVO_external" -l"GTM_NSData+zlib" -l"GTM_NSDictionary+URLArguments_external" -l"GTM_NSScannerJSON_external" -l"GTM_NSStringHTML_external" -l"GTM_NSStringXML_external" -l"GTM_Regex_external" -l"GTM_RoundedRectPath_external" -l"GTM_StringEncoding_external" -l"GTM_SystemVersion_external" -l"GTM_UIFont+LineHeight_external" -l"GTM_core_external" -l"GTM_iPhone_external" -l"InstagramKit" -l"LocalyticsAMP_x64" -l"NSLogger" -l"NSLogger-CocoaLumberjack-connector" -l"OpenInChrome_external" -l"ProtocolBuffers_external" -l"RFQuiltLayout" -l"RHAddressBook" -l"Reachability" -l"SSZipArchive" -l"SVWebViewController" -l"SignIn_external" -l"UICKeyChainStore" -l"apptentive-ios" -l"bz2" -l"c++" -l"iconv" -l"sqlite3" -l"stdc++" -l"xml2" -l"z" \
 -framework "AVFoundation" -framework "AddressBook" -framework "AddressBookUI" -framework "AssetsLibrary" -framework "AudioToolbox" -framework "CFNetwork" -framework "CoreData" -framework "CoreFoundation" -framework "CoreGraphics" -framework "CoreLocation" -framework "CoreMotion" -framework "CoreText" -framework "Crashlytics" -framework "Fabric" -framework "Foundation" -framework "HockeySDK" -framework "ImageIO" -framework "MessageUI" -framework "MobileCoreServices" -framework "MobileVLCKit" -framework "OpenGLES" -framework "QuartzCore" -framework "QuickLook" -framework "SafariServices" -framework "Security" -framework "SystemConfiguration" -framework "UIKit" -weak_framework "Accounts" -weak_framework "AdSupport" -weak_framework "AudioToolbox" -weak_framework "CoreGraphics" -weak_framework "CoreLocation" -weak_framework "CoreTelephony" -weak_framework "Foundation" -weak_framework "QuartzCore" -weak_framework "Security" -weak_framework "Social" -weak_framework "StoreKit" -weak_framework "UIKit" \
 -framework CoreData -framework ExternalAccessory -framework MediaPlayer \
 -fobjc-link-runtime -miphoneos-version-min=8.2 \
 -o "$RESULT_DIR/iXpand Drive"

plutil -convert xml1 -o "iXpand Drive.app.xcent" "App.entitlements"

export CODESIGN_ALLOCATE=$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate
export PATH="$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:$XCODE_BASE/Contents/Developer/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# /usr/bin/codesign --force --sign $IDENTITY --resource-rules="ResourceRules.plist" --entitlements "iXpand Drive.app.xcent" "$RESULT_DIR"
/usr/bin/codesign --force --sign $IDENTITY --entitlements "iXpand Drive.app.xcent" --timestamp=none "$RESULT_DIR"
