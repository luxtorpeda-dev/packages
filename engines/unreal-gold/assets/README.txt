Unreal Gold requires a Windows installer to get the necessary Linux binaries.

This Windows installer has to be downloaded manually, do to the luxtorpeda client not being able to download the files directory.

To do this, go to https://www.oldunreal.com/downloads/unreal/oldunreal-patches/, pick UnrealGoldPatch227i.7z and download it. Then go to the game directory and copy the 7z to the System directory.

Because of this installer, wine is needed to be installed. If the current system has Steam running under a flatpak, these commands may need to be run under the host system.

If the installer failed running directly from Steam, after copying the 7z file, such as if wine was not installed, the following steps can be followed. If Wine is installed, then running directly in Steam again can be tried as well.

Wine is required to be installed to continue.

1. Go to the directory where Unreal Gold is installed. There should be a file called UnrealGoldPatch227i.exe inside the System directory
2. Open up a Terminal window in the System directory and run "wine UnrealGoldPatch227i.exe"
3. This should launch the Unreal Gold 227i patch installer.
4. When it asks for the Destination Folder, this will be a wine-based path and it need to be entered in manually. The Z:\ drive is where the root file system can be accessed. For example, if the path to the installation is "/run/media/d10sfan/Storage/SteamLibrary/steamapps/common/Unreal Gold/", the wine path would be "Z:\run\media\d10sfan\Storage\SteamLibrary\steamapps\common\Unreal Gold"
5. Make sure to pick the Linux native files in the wizard.
6. Once the installer is complete, click Finish. Do not click Play.
7. Go back to Steam and attempt to play Unreal Gold.
