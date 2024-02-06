#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata-standard-no-sdlcompat/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

CDKEY="$DIALOGRESPONSE_CDKEY"

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata-standard-no-sdlcompat/Animations
ln -rsf Animations/* linuxdata-standard-no-sdlcompat/Animations

mkdir -p linuxdata-standard-no-sdlcompat/Help
ln -rsf Help/* linuxdata-standard-no-sdlcompat/Help

mkdir -p linuxdata-standard-no-sdlcompat/Speech
ln -rsf Speech/* linuxdata-standard-no-sdlcompat/Speech

mkdir -p linuxdata-standard-no-sdlcompat/System
ln -rsf System/* linuxdata-standard-no-sdlcompat/System

mkdir -p linuxdata-standard-no-sdlcompat/Textures
ln -rsf Textures/* linuxdata-standard-no-sdlcompat/Textures

ln -rsf Benchmark linuxdata-standard-no-sdlcompat/Benchmark
ln -rsf ForceFeedback linuxdata-standard-no-sdlcompat/ForceFeedback
ln -rsf KarmaData linuxdata-standard-no-sdlcompat/KarmaData
ln -rsf Manual linuxdata-standard-no-sdlcompat/Manual
ln -rsf maps linuxdata-standard-no-sdlcompat/maps
ln -rsf Music linuxdata-standard-no-sdlcompat/Music
ln -rsf Prefabs linuxdata-standard-no-sdlcompat/Prefabs
ln -rsf Sounds linuxdata-standard-no-sdlcompat/Sounds
ln -rsf StaticMeshes linuxdata-standard-no-sdlcompat/StaticMeshes
ln -rsf "ut2004 content 2" linuxdata-standard-no-sdlcompat/"ut2004 content 2"
    
echo "$CDKEY" > linuxdata-standard-no-sdlcompat/System/cdkey

rm linuxdata-standard-no-sdlcompat/System/User.ini
cp System/User.ini linuxdata-standard-no-sdlcompat/System/User.ini

cp -rfv linuxdata-standard-no-sdlcompat/System/Default.ini linuxdata-standard-no-sdlcompat/System/Default.ini-backup
grep -v "ut2004master2.epicgames.com" linuxdata-standard-no-sdlcompat/System/Default.ini > tmp.ini
mv tmp.ini linuxdata-standard-no-sdlcompat/System/Default.ini
sed -i "s/ut2004master1.epicgames.com/ut2004master.333networks.com/" linuxdata-standard-no-sdlcompat/System/Default.ini
