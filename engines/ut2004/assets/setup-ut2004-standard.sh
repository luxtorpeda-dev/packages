#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata-standard/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

CDKEY="$DIALOGRESPONSE_CDKEY"

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata-standard/Animations
ln -rsf Animations/* linuxdata-standard/Animations

mkdir -p linuxdata-standard/Help
ln -rsf Help/* linuxdata-standard/Help

mkdir -p linuxdata-standard/Speech
ln -rsf Speech/* linuxdata-standard/Speech

mkdir -p linuxdata-standard/System
ln -rsf System/* linuxdata-standard/System

mkdir -p linuxdata-standard/Textures
ln -rsf Textures/* linuxdata-standard/Textures

ln -rsf Benchmark linuxdata-standard/Benchmark
ln -rsf ForceFeedback linuxdata-standard/ForceFeedback
ln -rsf KarmaData linuxdata-standard/KarmaData
ln -rsf Manual linuxdata-standard/Manual
ln -rsf maps linuxdata-standard/maps
ln -rsf Music linuxdata-standard/Music
ln -rsf Prefabs linuxdata-standard/Prefabs
ln -rsf Sounds linuxdata-standard/Sounds
ln -rsf StaticMeshes linuxdata-standard/StaticMeshes
ln -rsf "ut2004 content 2" linuxdata-standard/"ut2004 content 2"
    
echo "$CDKEY" > linuxdata-standard/System/cdkey

rm linuxdata-standard/System/User.ini
cp System/User.ini linuxdata-standard/System/User.ini

cp -rfv linuxdata-standard/System/Default.ini linuxdata-standard/System/Default.ini-backup
grep -v "ut2004master2.epicgames.com" linuxdata-standard/System/Default.ini > tmp.ini
mv tmp.ini linuxdata-standard/System/Default.ini
sed -i "s/ut2004master1.epicgames.com/ut2004master.333networks.com/" linuxdata-standard/System/Default.ini
