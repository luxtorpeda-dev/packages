#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

set -e

if [ ! -f run.swf ]; then
    export PATH="$PATH:./jdk-11.0.12/bin/"
    if [[ $LUX_ORIGINAL_EXE_FILE == "Samorost2.exe" ]]; then
        java -jar ffdec/ffdec.jar -extract "Samorost 2 Original (2005)/Samorost2.exe" -o run.swf biggest
    else
        java -jar ffdec/ffdec.jar -extract "$LUX_ORIGINAL_EXE_FILE" -o run.swf biggest
    fi
fi
./ruffle_desktop run.swf
