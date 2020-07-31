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

mkdir -p linuxdata-436/System
ln -rsf System/* linuxdata-436/System

mkdir -p linuxdata-436/Textures
ln -rsf Textures/* linuxdata-436/Textures

ln -rsf Help linuxdata-436/Help
ln -rsf Maps linuxdata-436/Maps
ln -rsf Music linuxdata-436/Music
ln -rsf Sounds linuxdata-436/Sounds

cp -r linuxextras/* linuxdata-436
cp System/UnrealTournament-override.ini linuxdata/System/UnrealTournament.ini

if [[ -z $(lspci | grep NVIDIA) ]]; then
    sed -i "s/GameRenderDevice=OpenGLDrv.OpenGLRenderDevice/GameRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-436/System/UnrealTournament.ini
    sed -i "s/WindowedRenderDevice=OpenGLDrv.OpenGLRenderDevice/WindowedRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-436/System/UnrealTournament.ini
    sed -i "s/RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-436/System/UnrealTournament.ini
fi
