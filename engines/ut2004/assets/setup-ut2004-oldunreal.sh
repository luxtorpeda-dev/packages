#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata-oldunreal/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata-oldunreal/Animations
ln -rsf Animations/* linuxdata-oldunreal/Animations

mkdir -p linuxdata-oldunreal/Help
ln -rsf Help/* linuxdata-oldunreal/Help

mkdir -p linuxdata-oldunreal/Speech
ln -rsf Speech/* linuxdata-oldunreal/Speech

mkdir -p linuxdata-oldunreal/System
ln -rsf System/* linuxdata-oldunreal/System

mkdir -p linuxdata-oldunreal/Textures
ln -rsf Textures/* linuxdata-oldunreal/Textures

ln -rsf Benchmark linuxdata-oldunreal/Benchmark
ln -rsf ForceFeedback linuxdata-oldunreal/ForceFeedback
ln -rsf KarmaData linuxdata-oldunreal/KarmaData
ln -rsf Manual linuxdata-oldunreal/Manual
ln -rsf maps linuxdata-oldunreal/Maps
ln -rsf Music linuxdata-oldunreal/Music
ln -rsf Prefabs linuxdata-oldunreal/Prefabs
ln -rsf StaticMeshes linuxdata-oldunreal/StaticMeshes
ln -rsf "ut2004 content 2" linuxdata-oldunreal/"ut2004 content 2"

mkdir -p linuxdata-oldunreal/Sounds
ln -rsf Sounds/* linuxdata-oldunreal/Sounds

cp -rfv linuxdata-oldunreal-binaries/* linuxdata-oldunreal
    
rm linuxdata-oldunreal/System/User.ini
cp System/User.ini linuxdata-oldunreal/System/User.ini

cp -rfv linuxdata-oldunreal/System/Default.ini linuxdata-oldunreal/System/Default.ini-backup
grep -v "ut2004master2.epicgames.com" linuxdata-oldunreal/System/Default.ini > tmp.ini
mv tmp.ini linuxdata-oldunreal/System/Default.ini
sed -i "s/ut2004master1.epicgames.com/ut2004master.333networks.com/" linuxdata-oldunreal/System/Default.ini
sed -i "s/GUI2K4.UT2K4MainMenu/GUI2K4.UT2K4MainMenuWS/" linuxdata-oldunreal/System/Default.ini
