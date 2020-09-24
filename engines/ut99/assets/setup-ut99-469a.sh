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

mkdir -p linuxdata-469a/System
ln -rs System/* linuxdata-469a/System

mkdir -p linuxdata-469a/Textures
ln -rsf Textures/* linuxdata-469a/Textures

ln -rsf Help linuxdata-469a/Help
ln -rsf Maps linuxdata-469a/Maps
ln -rsf Music linuxdata-469a/Music
ln -rsf Sounds linuxdata-469a/Sounds

cp System/UnrealTournament-override.ini linuxdata-469a/System/UnrealTournament.ini

if [[ -z $(lspci | grep NVIDIA) ]]; then
    sed -i "s/GameRenderDevice=OpenGLDrv.OpenGLRenderDevice/GameRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-469a/System/UnrealTournament.ini
    sed -i "s/WindowedRenderDevice=OpenGLDrv.OpenGLRenderDevice/WindowedRenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-469a/System/UnrealTournament.ini
    sed -i "s/RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=SDLSoftDrv.SDLSoftwareRenderDevice/" linuxdata-469a/System/UnrealTournament.ini
fi
