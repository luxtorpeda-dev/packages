#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

cd linuxdata

pulseaudiolib=""

if [[ -f "/usr/lib/i386-linux-gnu/pulseaudio/libpulsedsp.so" ]]; then
    pulseaudiolib="/usr/lib/i386-linux-gnu/pulseaudio/libpulsedsp.so"
elif [[ -f "/usr/lib32/pulseaudio/libpulsedsp.so" ]]; then
    pulseaudiolib="/usr/lib32/pulseaudio/libpulsedsp.so"
elif [[ -n $(cat /etc/os-release | grep NixOS) ]]; then
    pulseaudiolib="$(nix-store --query -R $(which steam-run) | grep steam-run-fhs | tail -n1)/lib32/pulseaudio/libpulsedsp.so"
fi

if [ -z "$pulseaudiolib" ]; then
    zenity --error --text="Could not find libpulsedsp.so"
    exit 0
fi

LD_PRELOAD="$LD_PRELOAD $pulseaudiolib" padsp ./ut
