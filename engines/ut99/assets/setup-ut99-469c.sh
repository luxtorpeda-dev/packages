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

mkdir -p linuxdata-469c/System64
ln -rs System/* linuxdata-469c/System64

mkdir -p linuxdata-469c/Textures
ln -rsf Textures/* linuxdata-469c/Textures

ln -rsf Help linuxdata-469c/Help
ln -rsf Maps linuxdata-469c/Maps
ln -rsf Music linuxdata-469c/Music
ln -rsf Sounds linuxdata-469c/Sounds

rm linuxdata-469c/System64/UnrealTournament.ini

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    cp System/UnrealTournament-override-469c-steamdeck.ini linuxdata-469c/System64/UnrealTournament.ini
else
    cp System/UnrealTournament-override-469c.ini linuxdata-469c/System64/UnrealTournament.ini
fi

cp -rfv linuxdata-469c/System/* linuxdata-469c/System64

ln -rsf linuxdata-469c/System64/de.u linuxdata-469c/System64/De.u
ln -rsf linuxdata-469c/System64/de.int linuxdata-469c/System64/De.int
ln -rsf linuxdata-469c/System64/multimesh.u linuxdata-469c/System64/MultiMesh.u
ln -rsf linuxdata-469c/System64/multimesh.int linuxdata-469c/System64/MultiMesh.int

ln -rsf utbonuspack4/Maps/* linuxdata-469c/Maps
ln -rsf utbonuspack4/System/* linuxdata-469c/System
ln -rsf utbonuspack4/Textures/* linuxdata-469c/Textures
