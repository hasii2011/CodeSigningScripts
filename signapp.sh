#!/usr/bin/env bash

tput clear
source ./common.sh
setProjectsBase

PROJECT_DIR=${1}
APPLICATION_NAME=${2}

# If either of the parameters do not exist the function will
# print an error messaged and exit the script with a non-zero 
# status code
validateParameters ${PROJECT_DIR} ${APPLICATION_NAME}


export APP="${APPLICATION_NAME}.app"

FULL_PROJECT_DIR="${PROJECTS_BASE}/${PROJECT_DIR}"
FULL_APP_NAME="${FULL_PROJECT_DIR}/dist/${APP}"

export LOGFILE="CodeSigning.log"
#
# PyGitIssueClone.app/Contents/Frameworks/liblzma.5.dylib: main executable failed strict validation
# manually copy from: /usr/local/Cellar/xz/5.2.5/lib/liblzma.5.dylib
# https://stackoverflow.com/questions/62095338/py2app-fails-macos-signing-on-liblzma-5-dylib
#
export GOOD_LIB='/usr/local/Cellar/xz/5.2.5/lib/liblzma.5.dylib'
export DIR_TO_OVER_WRITE="${APP}/Contents/Frameworks"

cp -vp ${GOOD_LIB} ${DIR_TO_OVER_WRITE}
#
#  Ugh code signing will be the death of me
#
rm -vrf ${FULL_APP_NAME}/Contents/Resources/lib/python3.9/todoist/.DS_Store
rm -vrf ${FULL_APP_NAME}/Contents/Resources/lib/python3.9/numpy/f2py/tests/src/assumed_shape/.f2py_f2cmap

#
# This is a real certificate - expires 21 September 2026
#
export IDENTITY="Developer ID Application: Humberto Sanchez II (NA8Z96F8V9)"
export OPTIONS="--verbose --force --timestamp --options=runtime "
#
#  assumes Xcode 13 is installed
#
echo "Sign frameworks"
echo "" > ${LOGFILE}
codesign --sign "${IDENTITY}" ${OPTIONS} "${FULL_APP_NAME}/Contents/Frameworks/Python.framework/Versions/3.9/Python" >> ${LOGFILE} 2>&1

echo "Sign libraries"

find "${FULL_APP_NAME}" -iname '*.so' -or -iname '*.dylib' |
    while read libfile; do
        codesign --sign "${IDENTITY}" ${OPTIONS} "${libfile}" >> ${LOGFILE} 2>&1 ;
    done;

codesign --sign "${IDENTITY}" ${OPTIONS} "${FULL_APP_NAME}/Contents/MacOS/python"           >> ${LOGFILE} 2>&1
codesign --sign "${IDENTITY}" ${OPTIONS} "${FULL_APP_NAME}/Contents/MacOS/PyGitIssueClone"  >> ${LOGFILE} 2>&1

