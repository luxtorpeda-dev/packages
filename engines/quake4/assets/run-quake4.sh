#!/bin/bash

create_relative_symlink () {
        local -r target=$1
        local -r symlink="linuxdata/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

if [ ! -f ready ]; then
    iconv -c -t UTF-8 < EULA.txt > EULA-utf8.txt
    zenity --text-info --title="EULA" --filename="EULA-utf8.txt" --checkbox="I have read and agree to these terms."
    if [ "$?" != 0 ]
    then
        exit 0
    fi

    rm quake4-linux-1.4.2.x86.run
    wget https://www.quaddicted.com/files/idgames2/idstuff/quake4/linux/quake4-linux-1.4.2.x86.run
    chmod +x quake4-linux-1.4.2.x86.run
    ./quake4-linux-1.4.2.x86.run  --noexec --target linuxofficial
    
    mkdir -p ./linuxdata
    find {q4base,q4mp} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name"
    done
    
    cp -r linuxofficial/* linuxdata # Copying instead of symlink, because the engine can't find the original data (it changes the path to linuxofficial incorrectly)
    
    rm ./linuxdata/bin/Linux/x86_64/libgcc_s.so.1
    rm ./linuxdata/bin/Linux/x86_64/libstdc++.so.6
    chmod +x ./linuxdata/bin/Linux/x86_64/quake4smp.x86

    rm linuxdata/q4base/Quake4Config.cfg
    ln -s ../../Quake4Config.cfg linuxdata/q4base/Quake4Config.cfg
    
    if [ ! -f ~/.quake4/q4base/quake4key ]; then
        mkdir -p ~/.quake4/q4base
        ln -s "$PWD/linuxdata/q4base/quake4key" ~/.quake4/q4base/quake4key
    fi
    
    touch ready
fi

cd linuxdata
LD_LIBRARY_PATH="./bin/Linux/x86_64" ./bin/Linux/x86_64/quake4smp.x86
