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

mkdir -p linuxdata-469b/System
ln -rs System/* linuxdata-469b/System

mkdir -p linuxdata-469b/Textures
ln -rsf Textures/* linuxdata-469b/Textures

ln -rsf Help linuxdata-469b/Help
ln -rsf Maps linuxdata-469b/Maps
ln -rsf Music linuxdata-469b/Music
ln -rsf Sounds linuxdata-469b/Sounds

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    cp System/UnrealTournament-override-469b-steamdeck.ini linuxdata-469b/System/UnrealTournament.ini
else
    cp System/UnrealTournament-override-469b.ini linuxdata-469b/System/UnrealTournament.ini
fi
