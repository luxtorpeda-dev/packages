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

mkdir -p linuxdata-451/System
ln -rsf System/* linuxdata-451/System

mkdir -p linuxdata-451/Textures
ln -rsf Textures/* linuxdata-451/Textures

ln -rsf Help linuxdata-451/Help
ln -rsf Maps linuxdata-451/Maps
ln -rsf Music linuxdata-451/Music
ln -rsf Sounds linuxdata-451/Sounds

cp System/UnrealTournament-override.ini linuxdata/System/UnrealTournament.ini

if [[ -z $(lspci | grep NVIDIA) ]]; then
    sed -i "s/GameRenderDevice=OpenGLDrv.OpenGLRenderDevice/GameRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-451/System/UnrealTournament.ini
    sed -i "s/WindowedRenderDevice=OpenGLDrv.OpenGLRenderDevice/WindowedRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-451/System/UnrealTournament.ini
    sed -i "s/RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-451/System/UnrealTournament.ini
fi
