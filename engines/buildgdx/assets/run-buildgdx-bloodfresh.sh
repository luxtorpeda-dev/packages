#!/bin/bash

gamepath="$PWD"
configpath=~/M210Projects/BloodGDX/bloodgdx.ini
mkdir -p ~/M210Projects/BloodGDX
echo "$configpath"

if [ ! -f ${configpath} ]; then
    echo "Config file does not exist, creating."

cat >"$configpath" <<EOL
[Main]
Path = ${gamepath}
EOL
fi

export PATH="$PATH:./jdk-11.0.12/bin/:./"
java -DLWJGL_DISABLE_XRANDR=true -jar BuildGDX.jar
