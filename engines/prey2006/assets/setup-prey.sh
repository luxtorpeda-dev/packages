#!/bin/bash

mkdir -p ./linuxdata/

create_relative_symlink () {
        local -r target=$1
        local -r symlink="linuxdata/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

find base -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

# Copying instead of symlink, because the engine can't find the original data (it changes the path to linuxofficial incorrectly)
cp -r linuxofficial/data/prey-linux-data/* linuxdata
cp -r linuxofficial/data/prey-linux-x86/* linuxdata

rm linuxdata/libgcc_s.so.1
rm linuxdata/libSDL-1.2.so.0

ln -rsf libSDL-1.2.so.0 linuxdata/libSDL-1.2.so.0
chmod +x ./linuxdata/prey.x86
chmod +x ./linuxdata/prey

if [ ! -f ~/.prey/base/preykey ]; then
    mkdir -p ~/.prey/base
    ln -s "$PWD/linuxdata/base/preykey" ~/.prey/base/preykey
fi
