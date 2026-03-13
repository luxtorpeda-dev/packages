#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata-oldunreal-v2/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata-oldunreal-v2/Animations
ln -rsf Animations/* linuxdata-oldunreal-v2/Animations

mkdir -p linuxdata-oldunreal-v2/Help
ln -rsf Help/* linuxdata-oldunreal-v2/Help

mkdir -p linuxdata-oldunreal-v2/Speech
ln -rsf Speech/* linuxdata-oldunreal-v2/Speech

mkdir -p linuxdata-oldunreal-v2/System
ln -rsf System/* linuxdata-oldunreal-v2/System

mkdir -p linuxdata-oldunreal-v2/Textures
ln -rsf Textures/* linuxdata-oldunreal-v2/Textures

mkdir -p linuxdata-oldunreal-v2/Maps
ln -rsf maps/* linuxdata-oldunreal-v2/Maps

mkdir -p linuxdata-oldunreal-v2/StaticMeshes
ln -rsf StaticMeshes/* linuxdata-oldunreal-v2/StaticMeshes

ln -rsf Benchmark linuxdata-oldunreal-v2/Benchmark
ln -rsf ForceFeedback linuxdata-oldunreal-v2/ForceFeedback
ln -rsf KarmaData linuxdata-oldunreal-v2/KarmaData
ln -rsf Manual linuxdata-oldunreal-v2/Manual
ln -rsf Music linuxdata-oldunreal-v2/Music
ln -rsf Prefabs linuxdata-oldunreal-v2/Prefabs
ln -rsf "ut2004 content 2" linuxdata-oldunreal-v2/"ut2004 content 2"

mkdir -p linuxdata-oldunreal-v2/Sounds
ln -rsf Sounds/* linuxdata-oldunreal-v2/Sounds

cp -rfv linuxdata-oldunreal-v2-binaries/* linuxdata-oldunreal-v2
    
rm linuxdata-oldunreal-v2/System/User.ini
cp System/User.ini linuxdata-oldunreal-v2/System/User.ini

cp -rfv linuxdata-oldunreal-v2/System/Default.ini linuxdata-oldunreal-v2/System/Default.ini-backup
grep -v "ut2004master2.epicgames.com" linuxdata-oldunreal-v2/System/Default.ini > tmp.ini
mv tmp.ini linuxdata-oldunreal-v2/System/Default.ini
sed -i "s/ut2004master1.epicgames.com/ut2004master.333networks.com/" linuxdata-oldunreal-v2/System/Default.ini

grep -q 'UT2K4MainMenuWS' linuxdata-oldunreal-v2/System/Default.ini || sed -i 's/GUI2K4.UT2K4MainMenu/GUI2K4.UT2K4MainMenuWS/' linuxdata-oldunreal-v2/System/Default.ini

cp -rfv ./linuxdata-oldunreal-extra/* linuxdata-oldunreal-v2
