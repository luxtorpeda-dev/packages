#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="linuxdata/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

if [[ ! -z "${DIALOGRESPONSE_CDKEY}" ]]; then
    CDKEY="$DIALOGRESPONSE_CDKEY"
else
    CDKEY=$("$STEAM_ZENITY" --entry --title="CD Key" --text="Enter your CD Key (Can Be Found in Steam)")
fi

find {Web} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

mkdir -p linuxdata/Animations
ln -rsf Animations/* linuxdata/Animations

mkdir -p linuxdata/Help
ln -rsf Help/* linuxdata/Help

mkdir -p linuxdata/Speech
ln -rsf Speech/* linuxdata/Speech

mkdir -p linuxdata/System
ln -rsf System/* linuxdata/System

mkdir -p linuxdata/Textures
ln -rsf Textures/* linuxdata/Textures

ln -rsf Benchmark linuxdata/Benchmark
ln -rsf ForceFeedback linuxdata/ForceFeedback
ln -rsf KarmaData linuxdata/KarmaData
ln -rsf Manual linuxdata/Manual
ln -rsf maps linuxdata/maps
ln -rsf Music linuxdata/Music
ln -rsf Prefabs linuxdata/Prefabs
ln -rsf Sounds linuxdata/Sounds
ln -rsf StaticMeshes linuxdata/StaticMeshes
ln -rsf "ut2004 content 2" linuxdata/"ut2004 content 2"
    
echo "$CDKEY" > linuxdata/System/cdkey

rm linuxdata/System/User.ini
cp System/User.ini linuxdata/System/User.ini

sed -i "s/InputClass=Class'Engine.PlayerInput'/InputClass=Class'foxWSFix.foxPlayerInput'/" linuxdata/System/User.ini
echo -e "\n\n[XGame.xPlayer]\nInputClass=Class'foxWSFix.foxPlayerInput'" >> linuxdata/System/User.ini

cp -rfv linuxdata/System/Default.ini linuxdata/System/Default.ini-backup
grep -v "ut2004master2.epicgames.com" linuxdata/System/Default.ini > tmp.ini
mv tmp.ini linuxdata/System/Default.ini
sed -i "s/ut2004master1.epicgames.com/utmaster.openspy.net/" linuxdata/System/Default.ini
