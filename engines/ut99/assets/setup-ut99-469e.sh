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

mkdir -p linuxdata-469e/System64
ln -rs System/* linuxdata-469e/System64

mkdir -p linuxdata-469e/Textures
ln -rsf Textures/* linuxdata-469e/Textures

ln -rsf Help linuxdata-469e/Help
ln -rsf Maps linuxdata-469e/Maps
ln -rsf Music linuxdata-469e/Music
ln -rsf Sounds linuxdata-469e/Sounds

rm linuxdata-469e/System64/UnrealTournament.ini

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    cp System/UnrealTournament-override-469e-steamdeck.ini linuxdata-469e/System64/UnrealTournament.ini
else
    cp System/UnrealTournament-override-469e.ini linuxdata-469e/System64/UnrealTournament.ini
fi

cp -rfv linuxdata-469e/System/* linuxdata-469e/System64

ln -rsf linuxdata-469e/System64/de.u linuxdata-469e/System64/De.u
ln -rsf linuxdata-469e/System64/de.int linuxdata-469e/System64/De.int
ln -rsf linuxdata-469e/System64/multimesh.u linuxdata-469e/System64/MultiMesh.u
ln -rsf linuxdata-469e/System64/multimesh.int linuxdata-469e/System64/MultiMesh.int

ln -rsf utbonuspack4/Maps/* linuxdata-469e/Maps
ln -rsf utbonuspack4/System/* linuxdata-469e/System
ln -rsf utbonuspack4/Textures/* linuxdata-469e/Textures
