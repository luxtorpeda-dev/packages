#!/bin/bash

cd ../

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata/System
ln -rsf System/* linuxdata/System

mkdir -p linuxdata/Textures
ln -rsf Textures/* linuxdata/Textures

ln -rsf Help linuxdata/Help
ln -rsf Maps linuxdata/Maps
ln -rsf Music linuxdata/Music
ln -rsf Sounds linuxdata/Sounds

cp -r linuxextras/* linuxdata
cp System/UnrealTournament-override.ini linuxdata/System/UnrealTournament.ini
