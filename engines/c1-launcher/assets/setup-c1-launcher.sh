#!/bin/bash
if [[ "$SteamAppId" == "17300" ]]; then # Crysis
   for exe in Crysis CrysisDedicatedServer CrysisHeadlessServer EditorLauncher; do
      ln -sf "$PWD/c1-launcher/Crysis/Bin32/$exe.exe" "Bin32/"
      ln -sf "$PWD/c1-launcher/Crysis/Bin64/$exe.exe" "Bin64/"
   done
elif [[ "$SteamAppId" == "17330" ]]; then # Crysis Warhead
      ln -sf "$PWD/c1-launcher/Crysis Warhead/Bin64/CrysisWarheadLauncher.exe" "Bin64/"
else
  exit 1
fi