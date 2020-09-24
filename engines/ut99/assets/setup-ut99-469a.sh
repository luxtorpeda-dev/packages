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

mkdir -p linuxdata-469a/System
ln -rs System/* linuxdata-469a/System

mkdir -p linuxdata-469a/Textures
ln -rsf Textures/* linuxdata-469a/Textures

ln -rsf Help linuxdata-469a/Help
ln -rsf Maps linuxdata-469a/Maps
ln -rsf Music linuxdata-469a/Music
ln -rsf Sounds linuxdata-469a/Sounds

cp System/UnrealTournament-override-469.ini linuxdata-469a/System/UnrealTournament.ini
