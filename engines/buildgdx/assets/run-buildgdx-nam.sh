#!/bin/bash

gamepath="$PWD/../NAM"
configpath=~/M210Projects/NamGDX/namgdx.ini
mkdir -p ~/M210Projects/NamGDX
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
