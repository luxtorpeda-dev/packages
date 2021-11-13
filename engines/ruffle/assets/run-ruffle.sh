#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

set -e

export PATH="$PATH:./jdk-11.0.12/bin/"
java -jar ffdec/ffdec.jar -extract $LUX_ORIGINAL_EXE_FILE -o output.swf biggest
./ruffle_desktop output.swf
