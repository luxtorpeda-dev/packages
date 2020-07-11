#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

if [ ! -f "/usr/lib/libopenal.so" ]; then
    "$STEAM_ZENITY" --error --text "OpenAL Not Found. Exiting"
    exit 0
fi

if [ ! -f "/usr/lib/libstdc++.so.5" ]; then
    "$STEAM_ZENITY" --error --text "libstdc++.so.5 Not Found. Exiting"
    exit 0
fi

if [ ! -f ready ]; then
    iconv -c -t UTF-8 < ./System/License.int > ./System/License.txt
    "$STEAM_ZENITY" --text-info --title="License" --filename="./System/License.txt" --checkbox="I have read and agree to these terms."
    if [ "$?" != 0 ]
    then
        exit 0
    fi
    
    mkdir -p ./linuxdata/
    CDKEY=$("$STEAM_ZENITY" --entry --title="CD Key" --text="Enter your CD Key (Can Be Found in Steam)")
    
    rm ut2004-lnxpatch3369-2.tar.bz2
    wget http://treefort.icculus.org/ut2004/ut2004-lnxpatch3369-2.tar.bz2

    find {Animations,Help,Speech,System,Textures,Web} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name"
    done

    ln -rsf Benchmark linuxdata/Benchmark
    ln -rsf ForceFeedback linuxdata/ForceFeedback
    ln -rsf KarmaData linuxdata/KarmaData
    ln -rsf Manual linuxdata/Manual
    ln -rsf maps linuxdata/maps
    ln -rsf Music linuxdata/Music
    ln -rsf Prefabs linuxdata/Prefabs
    ln -rsf Sounds linuxdata/Sounds
    ln -rsf StaticMeshes linuxdata/StaticMeshes
    ln -rsf "ut2004 content 2" linuxdata/"ut2004 content 2"

    tar xjf ut2004-lnxpatch3369-2.tar.bz2 -C linuxdata --strip-components=1

    ln -s /usr/lib/libopenal.so linuxdata/System/openal.so
    
    echo "$CDKEY" > linuxdata/System/cdkey

    touch ready
fi

cd linuxdata/System
./ut2004-bin-linux-amd64
