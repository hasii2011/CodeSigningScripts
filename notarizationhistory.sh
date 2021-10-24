#!/usr/bin/env bash
#
# assumes Xcode 13 is installed
# assumes I added an entry APP_PASSWORD to my keychain
# It is a Apple Developer Id application password necessary to run the notarytool
#
clear
xcrun notarytool history -p "APP_PASSWORD"  >> notaryhistory.log