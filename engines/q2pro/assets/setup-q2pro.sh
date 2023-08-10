#!/bin/bash

mkdir -p baseq2/music
ln -rsf rerelease/baseq2/music/track02.ogg baseq2/music/02.ogg
ln -rsf rerelease/baseq2/music/track03.ogg baseq2/music/03.ogg
ln -rsf rerelease/baseq2/music/track04.ogg baseq2/music/04.ogg
ln -rsf rerelease/baseq2/music/track05.ogg baseq2/music/05.ogg
ln -rsf rerelease/baseq2/music/track06.ogg baseq2/music/06.ogg
ln -rsf rerelease/baseq2/music/track07.ogg baseq2/music/07.ogg
ln -rsf rerelease/baseq2/music/track08.ogg baseq2/music/08.ogg
ln -rsf rerelease/baseq2/music/track09.ogg baseq2/music/09.ogg
ln -rsf rerelease/baseq2/music/track10.ogg baseq2/music/10.ogg
ln -rsf rerelease/baseq2/music/track11.ogg baseq2/music/11.ogg

mkdir -p rogue/music
ln -rsf rerelease/baseq2/music/track17.ogg rogue/music/02.ogg
ln -rsf rerelease/baseq2/music/track12.ogg rogue/music/03.ogg
ln -rsf rerelease/baseq2/music/track13.ogg rogue/music/04.ogg
ln -rsf rerelease/baseq2/music/track14.ogg rogue/music/05.ogg
ln -rsf rerelease/baseq2/music/track14.ogg rogue/music/06.ogg
ln -rsf rerelease/baseq2/music/track18.ogg rogue/music/07.ogg
ln -rsf rerelease/baseq2/music/track15.ogg rogue/music/08.ogg
ln -rsf rerelease/baseq2/music/track19.ogg rogue/music/09.ogg
ln -rsf rerelease/baseq2/music/track20.ogg rogue/music/10.ogg
ln -rsf rerelease/baseq2/music/track21.ogg rogue/music/11.ogg

mkdir -p xatrix/music
ln -rsf rerelease/baseq2/music/track09.ogg xatrix/music/02.ogg
ln -rsf rerelease/baseq2/music/track12.ogg xatrix/music/03.ogg
ln -rsf rerelease/baseq2/music/track13.ogg xatrix/music/04.ogg
ln -rsf rerelease/baseq2/music/track07.ogg xatrix/music/05.ogg
ln -rsf rerelease/baseq2/music/track14.ogg xatrix/music/06.ogg
ln -rsf rerelease/baseq2/music/track02.ogg xatrix/music/07.ogg
ln -rsf rerelease/baseq2/music/track15.ogg xatrix/music/08.ogg
ln -rsf rerelease/baseq2/music/track03.ogg xatrix/music/09.ogg
ln -rsf rerelease/baseq2/music/track04.ogg xatrix/music/10.ogg
ln -rsf rerelease/baseq2/music/track16.ogg xatrix/music/11.ogg

currentDir="$PWD"

create_relative_symlink () {
        local -r target=$1
        local -r symlink="../q2pro/$2/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

create_relative_symlink_music () {
        local -r target=$1
        local -r symlink="../q2pro/$2/$(dirname "$target")/track$(basename "$target")"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

pushd baseq2
find {pak0.pak,pak1.pak,pak2.pak,players,video} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name" "baseq2"
done

find music -type f  | while read -r file_name ; do
    create_relative_symlink_music "$file_name" "baseq2"
done

popd

if [ -d "ctf" ]
then
    pushd ctf
    find {pak0.pak,server.cfg} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "ctf"
    done
    popd
fi

if [ -d "rogue" ]
then
    pushd rogue
    find {pak0.pak,video} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "rogue"
    done
    
    find music -type f  | while read -r file_name ; do
        echo "$file_name"
        create_relative_symlink_music "$file_name" "rogue"
    done
    popd
fi

if [ -d "xatrix" ]
then
    pushd xatrix
    find {pak0.pak,video} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "xatrix"
    done
    
    find music -type f  | while read -r file_name ; do
        create_relative_symlink_music "$file_name" "xatrix"
    done
    popd
fi
