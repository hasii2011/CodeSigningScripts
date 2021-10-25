[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

## About The Project
If you use Apple’s Xcode developer environment developing and publishing code signed applications appears to be largely handled by that tool chain.  

To Apple’s credit they have various technical papers scattered around the developer help pages that with serious study you can glean the required information to code sign your non Apple/Swift applications.  

Be aware you will have to pay a developer fee for this privilege.  The piper must be paid.  Resistance is futile.

The scripts in this repository are inspired this [post](https://hsanchezii.wordpress.com/2021/10/06/code-signing-python-py2app-applications/).  It references the document [Apple Code Signing Py2app Applications](https://www.scribd.com/document/530430186/Code-Signing-Py2App-Applications)

## How to use the scripts

You must first create the py2app OS X app

Run the following scripts;  Save the submission ID 
from step 3

1. `./python39zipsign.sh`
2. `./signapp.sh`
3. `./notarizeapp.sh`
4. `./stapleapp.sh `
5. `./scripts/codesign/verifysigning.sh`


Once the above completes remove the zip created by `notarizeapp.sh` and rezip the application.

That is the file to put on the GitHub release as a binary.

## References
[Manual Code Signing Example](https://developer.apple.com/forums/thread/130855)
