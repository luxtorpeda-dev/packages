#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

set -e

if [[ $LUX_ORIGINAL_EXE_FILE == "Samorost2.exe" ]]; then
    if [ ! -f "Samorost 2 Original (2005)/run.swf" ]; then
        export PATH="$PATH:./jdk-11.0.12/bin/"
        echo "Extracting .swf from Samorost2.exe"
        java -jar ffdec/ffdec.jar -extract "Samorost 2 Original (2005)/Samorost2.exe" -o run.swf biggest
        mv run.swf "Samorost 2 Original (2005)/run.swf"
    fi
    echo "Samorost 2 Original is launching"
    ./ruffle_desktop "Samorost 2 Original (2005)/run.swf"
    else
        if [ ! -f run.swf ]; then
            export PATH="$PATH:./jdk-11.0.12/bin/"
            java -jar ffdec/ffdec.jar -extract "$LUX_ORIGINAL_EXE_FILE" -o run.swf biggest
            echo "Trying to extract .swf from .exe"
        else
            echo "run.swf exists"
        fi
        echo "Launching .swf"
        ./ruffle_desktop run.swf
fi
