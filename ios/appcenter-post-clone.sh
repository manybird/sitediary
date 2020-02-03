#!/usr/bin/env bash
#Place this script in project/ios/

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH


#  Warning: CocoaPods installed but not initialized. Skipping pod install.
#  CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on the Dart side.
#  Without CocoaPods, plugins will not work on iOS or macOS.
#  For more info, see https://flutter.dev/platform-plugins
#  To initialize CocoaPods, run:
#  pod setup

flutter channel stable

# CocoaPods installed but not initialised
# https://github.com/flutter/flutter/issues/41253
# https://github.com/flutter/flutter/issues/41291
# I'm also getting this issue with 1.8.1, I can also confirm installing cocoapods 1.7.5 fixes it.
# Make sure to uninstall previous versions or it won't work! :)
sudo gem which cocoapods
sudo gem uninstall cocoapods
sudo gem install cocoapods -v 1.7.5
# sudo gem install cocoapods
pod setup

flutter doctor -v

echo "Installed flutter to `pwd`/flutter"

flutter build ios --release --no-codesign