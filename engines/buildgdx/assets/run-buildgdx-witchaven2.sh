#!/bin/bash

gamepath="$PWD/GAME/WHAVEN2"
configpath=~/M210Projects/Witchaven2GDX/witchaven2gdx.ini
mkdir -p ~/M210Projects/Witchaven2GDX
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
