### 47.2 (2021-12-13)

* [Thanks to ToughGuyKunio] Added Godot
* raze - Update to 1.3.1
* [Thanks to ToughGuyKunio] Added Renpy
* warzone2100 - Update to 4.2.4

### 47.1 (2021-11-21)

* openrct2 - Update to v0.3.5.1
* rigelengine - Update to 0.8.2
* [Thanks to sponsors for funds to buy the game] dosbox-staging - Add support for MoM
* augustus - Update to 3.1.0
* realrtcw - Support steam assets
* vkquake - Update to 1.12.1
* [Thanks to ToughGuyKunio] Added blastem
* warzone2100 - Update to 4.2.3
* raze - Update to 1.3.0
* openxray - Update to December 2021 RC1

### 47.0 (2021-11-12)

* openhexagon - Update to 2.1.2
* Added starting point for ruffle support
* Added nwjs with 0.54
* [Thanks to ToughGuyKunio] ruffle - add The Basement Collection

### 46.0 (2021-11-06)

* openrct2 - Update to 0.3.5
* openmw - Fixes for launch issues
* opengothic - Update to 1.0.1311
* [Thanks to JoshuaFern] dosbox-staging - Enhance run script. This requires client version 46 and up.
* [Thanks to JoshuaFern] dosbox-staging - Add XCom Games
* [Thanks to JoshuaFern] buildgdx -Add OneUnitWholeBlood
* eduke32 - Update to 0dff2879
* warzone2100 - Update to 4.2.1

### 45.0 (2021-11-01)

* Add support for packages that used Zenity to use egui-based prompts, with zenity used as a fallback.
* [Thanks to JoshuaFern] dosbox-staging - Improve launch script
* openhexagon - Update to 2.1.0
* [Thanks to VortexAcherontic] raze - Fixed addon selection for Megaton Edition
* [Thanks to VortexAcherontic] eduke32 - Fixed addon selection for Megaton Edition
* openhexagon - Update to 2.1.1
* openmw - Update to 0.47. On first launch after upgrading, you may get an error saying that there is an openmw.cfg file. If you see that error, follow the instructions to remove or move, since the engine now expects the cfg file in ~/.config/openmw

### 40.1 (2021-11-01)

* rbdoom-3-bfg - Update to 1.3.0
* scummvm - Check for Original folder
* ja2 - Add error if classic not found
* ut2004 - Fix missing piece for foxPlayerInput
* Restore runescape
* source-sdk-2013 - Add downfall
* ut2004 - Upgrade to foxWSFix-2.2.0 - Requires removing "ready" file to go through setup again to see it.
* Add new UI and re-structure packages.json file.
* fs2open - Update to 21.4.1

### 40.0 (2021-10-18)

* Added freespace support with compiled version of the original engine and support for FreespacePort, which requires Freespace 2 to be installed and launched with luxtorpeda-dev client at least once. 
* vkquake - Update to 625e65a
* gzdoom - Update to 4.7.1
* vkquake - Update to 1.11.1
* gzdoom - Fix wadsmoosh
* [Thanks to sponsors for funds to buy the game] rottexpr - Add dark war support
* [Thanks to sponsors for funds to buy the game] gzdoom - Add REKKR
* openrct2 - Enable steam overlay
* warzone2100 - Update to 4.2.0
* perimeter - Update to 1189111 & added expansion pack
* openhexagon - Update to 2.0.7
* classic-rbdoom-3-bfg - Update to 1.2.8
* easyrpg-player - Update to 0.7.0

### 39.0 (2021-10-10)

* scummvm - Update to 2.5.0
* vkquake - Update to 82b69a2
* classic-rbdoom-3-bfg - Add steam integration
* julius - Update to 1.7.0
* quake3e - Update to 2021-10-14 
* raze - Update to 1.2.1

### 37.0 (2021-09-27)

* source-sdk-2013 - Support automatic detection of game folders
* realrtcw - Support automatic game folder detection
* [Thanks to thaewrapt] dxx-rebirth - Support new game update
* [Thanks to sponsor for funds to buy game] Added buildgdk, for Witchaven and also added to Powerslave, Blood Fresh Supply, and NAM.
* avp - Fix for other languages
* classic-rbdoom-3-bfg - Update to latest commit

### 36.0 (2021-09-24)

* Add support for building against steam runtime
* Added support for common library build scripts, so engines that share libraries do not have to each define the build scripts for them. Now can set ```export LIBRARIES="fluidsynth zmusic"``` as an example, which will clone, build, and copy the license and library files to the artifact.
* Re-built all games for new runtime. This will lead to better tooling support with the newer build system, easier to maintain library build scripts, and the engines have been updated to their latest.
* Added terminal-recall to runtime. Thanks to ToughGuyKunio for the key
* fs2open - Update to 21.4.0

### 30.4 (2021-09-14)

* dhewm3 - Add demo support
* ioquake3 - Add support for Quake 3 Arena Demo
* Add zandronum, using upstream provided download
* openloco - Update to 21.09.1

### 30.3 (2021-09-03)

* rigelengine - Update to 0.8.1. Thanks to lethal-guitar
* perimeter - Update to 0b355d5
* Added Object N
* openloco - Update to 21.09
* gzdoom - Add Relentless Frontier Demo
* Added wigzdoom for Project Absentia
* gzdoom - Add Strife Veteran Edition

### 30.2 (2021-08-19)

* Update Quake to support new updates. Steam will ask you to pick the game you want to play (such as quake and the mission packs). Picking that will determine what you play with the engine you pick in luxtorpeda. Picking any engine other than the fte quakeworld re-release will use the original game pak version. Picking that one will use the pak from the re-release with that engine and what game you picked in the Steam prompt. Then there's also an option for the brand new mission pack, using ftequakeworld.
* Added the mission packs for Quake (Dimension of the Past and Machine). Past uses the original dopa download, as the re-release one causes crashes in certain areas. Machine looks good other than some localization issues from.
* Added FTE QuakeWorld for Quake, Quake 2, and Quake 3. Quake has option for re-release with FTE QuakeWorld
* ftequakeworld - Add quake 2 expansions and hexen 2
* rigelengine - Update to 0.8.0
* dosbox-staging - Update to 0.77.1
* vkquake - Update to latest, added re-release asset support and localization extraction steps
* vkquake - Update to 1.11

### 30.1 (2021-08-07)

* arxlibertatis - Fix for too many file descriptors
* source-sdk-2013 - Fix for too many file descriptors
* gzdoom - Update to 4.6.1
* Added koi-farm
* Added easyrpg-player
* warzone2100 - Update to 4.1.3
* Added pcexumed support and added powerslave support from raze
* Added perimeter
* openloco - Update to 21.08

### 26.1 (2021-08-03)

* opengothic - Update to v1.0.1177
* warzone2100 - Update to 4.1.2

### 25.9 (2021-07-27)

* openrct2 - Update to v0.3.4.1
* warzone2100 - Update to 4.1.1

### 25.8 (2021-07-06)

* warzone2100 - Update to 4.1.0
* vkquake2 - Update to 1.5.8
* arxlibertatis - Update to 1.2
* dosbox-staging - Update to 0.77.0
* raze - Update to 1.1.3
* openloco - Update to 21.07
* OpenRCT2 - Update to 0.3.4
* quake3e - Update to 2021-07-20

### 25.7 (2021-06-26)

* Re-add re3
* Re-add reVC
* opengothic - Update to v1.0.1123

### 25.6 (2021-06-15)

* yquake2 - Update to 8.00

### 25.5 (2021-05-27)

* realrtcw - Fix launch to use non-steam version
* quake3e - Update to 2021-05-27
* vkquake - Update to 1.05.3
* reone - Update to 0.19.0

### 25.4 (2021-05-10)

* sonic-cd-11-decomp - Update to v1.1.2
* raze - Update to 1.1.0
* openloco - Update to 21.05
* source-sdk-2013 - Add zenity info prompts
* xash3d-fwgs-19 - Add zenity info prompts
* realrtcw - Add zenity info prompts
* raze - Update to 1.1.1
* raze - Update to 1.1.2 and support blood better
* Added etqw, user provided binaries
* gzdoom - Add doom 2 master levels 
* augustus - Update to 3.0
* gzdoom - Update to 4.6.0

### 25.3 (2021-05-03)

* openhexagon - Update to 2.0.5
* fs2open - Update to 21.2.0
* realrtcw - Update to 3.2
* reone - Update to 0.18.0

### 25.2 (2021-04-18)

* raze - Update to 1.0.2
* opengothic - Update to v1.0.1035
* warzone2100 - Update to 4.0.1
* rbdoom-3-bfg - Update to latest master (09c9f25)
* raze - Update to 1.0.3
* fs2open - Update to 21.2.0 RC3
* Add portal reloaded
* Add ja2-stracciatella

### 25.2 (2021-04-08)

* engge - Update to v0.8.0-beta
* raze - Update to 1.0.1
* fs2open - Update to Release 21.2.0 RC2
* reone - Update to 0.17.0
* openxcom-oxce - Update to 119283d
* openloco - Update to 21.04

### 25.1 (2021-03-26)

* openapoc - Update to Alpha build v0.386
* bstone - Update to v1.2.11
* warzone2100 - Update to 4.0.0-beta3
* quake3e - Update to 2021-03-28
* fs2open - Update to 21.2.0 RC1
* vkquake2 - Update to 1.5.7
* Added engge
* openhexagon - Update to 7f47e31
* warzone2100 - Update to 4.0

### 24.3 (2021-03-13)

* Added raze
* openrct2 - Update to 0.3.3
* Added half-life-before
* dhewm3 - Update to 1.5.1
* Added rottexpr
* Added ecwolf
* Added bstone
* reone - Update to 0.16.1
* raze - Update to 0.9.1 beta
* Added runelite
* Added runescape
* Added RigelEngine
* Added OpenHexagon
* warzone 2100 - Update to 4.0.0-beta2

### 24.2 (2021-03-03)

* warzone-2100 - Update to 4.0.0-beta1
* openloco - Update to 21.03
* reone - Update to 0.16.0
* ut99 - Support 469b

### 24.1 (2021-02-26)

* openmw - Workaround for morrowind.ini steam cloud save case
* Added source-sdk-2013, with scripts to launch Entropy Zero and Minerva source mods
* dhewm3 - Update to 1.5.1 RC3
* Added support for Hexen Deathkings
* metadata - Improvements to table look 
* source-sdk-2013 - Add support for year-long-alarm
* source-sdk-2013 - Add support for resistance-element

### 23.17 (2021-02-14)

* reVC - Update to v1.0
* re3 - Update to v1.0
* Added eduke32
* Added rednukem
* Added commander-genius

### 23.16 (2021-02-11)

* Added hammer of thyrion
* openlara - Update to latest master
* reVC - Update to ddcc19d7cf4b5a76fadc224966a0fa074b142592
* re3 - Update to 8d27dba4cdec4d3b39bf87ce5baef5962e58312c
* openjk - Update to d2ed03a016f54917bc1dcf06bcc59d3f674fb533
* vkquake2 - Update to 1.5.6
* Added eduke32 voidsw
* Added NBlood

### 23.15 (2021-01-28)

* Added quakespasm-spiked
* reone - Update to 0.15.0
* xash3d-fwgs-19 - Added support for absolute zero via upstream download
* Added solarus

### 23.14 (2021-01-24)

* Added shockolate
* realrtcw - Update to 1/24/2021 release
* Added OpenLoco
* Added Unreal Gold - See https://github.com/luxtorpeda-dev/packages/blob/master/engines/unreal-gold/assets/README.txt
* sonic-cd-11-decomp - Update to v1.1.0
* vkquake - Add mission packs
* Added darkplaces-2017
* yquake2 - Fix mission packs
* Added prboom-plus
* fs2open - Update to 21.0

### 23.13 (2021-01-19)

* Added vkQuake2
* Added alive_reversing

### 23.12 (2021-01-16)

* quake3e - Update to 2021-01-16
* vkquake - Update to 1.05.2
* doomsday - Update to 2.3.0
* reone - Update to 0.14.0
* Added sonic CD decomp
* ut2004 - Update foxWSFix-UT2k4 to 2.1.0
* opengothic - Update to 0.35

### 23.11 (2021-01-14)

* Added wrath-darkplaces
* Updated arx-libertatis
* fs2open - Update to Release 21.0 RC4
* Added Daikatana
* Added serious sam 2

### 23.10 (2021-01-11)

* fs2open - Update to Release 21.0 RC3
* reone - Update to 0.13.0
* rune - Add User.ini template for download speed

### 23.9 (2021-01-05)

* fs2open - Update to Release 21.0 RC2
* julius - Update to 1.6.0
* cortex command - Update to pre release 3.0
* rune - Fix for default.ini path

### 23.8 (2020-12-27)

* Added rune
* classic rbdoom 3 bfg - Update to 1.2.7
* fs2open - Update to 20.1 RC1
* openxray - Update December 2020 Preview
* reone - Update to 0.12.0
* re3 - Update to 14f7dba
* reVC - Update to c93fb5e443f9afe082abf708918fcd3db807596d

### 23.7 (2020-12-02)

* realrtcw - Update to latest
* Added quake3e
* dosbox-staging - Update to 0.76.0

### 23.6 (2020-11-28)

* reone - Update to 0.11.1
* Added reVC

### 23.5 (2020-11-18)

* reone - Update to 0.10.0
* Add augustus
* opengothic - Update to 0.32

### 23.4 (2020-11-06)

* openrct2 - Update to 0.3.2
* reone - Update to 0.9.0

### 23.3 (2020-10-31)

* Fix for deprecated github action environment variable use
* opengothic - Update to v0.31
* realrtcw - Support steam release
* fs2open - Update to latest master
* dosbox-staging - Update to 0.75.2
* julius - Update to 1.5.1
* re3 - Update to 4cfb3b0984c1de2820691b4b5f1c63cd19c498fb
* gzdoom - Update to 4.5.0
* openxray - Update to October 2020 Preview
* reone - Update to lastest master

### 23.2 (2020-09-28)

* Fix for re3 to include TEXT directory
* Update scummvm to 2.2.0

### 23.1 (2020-09-27)

* Added realrtcw - Currently has to download about 5 gb worth of assets, so first launch will take a while.
* Added reone - Engine is still very much WIP
* Added re3 for Grand Theft Auto 3
* Updated openrct2 to 0.3.1

### 23.0 (2020-09-23)

* Added support for ut99 469a

### 22.3 (2020-09-18)

* Added cortex-command

### 22.2 (2020-09-07)

* Added chocolate doom
* Added serious engine
* Added REminiscence

### 22.1 (2020-09-06)

* Added classic-rbdoom-3-bfg
* Added doomsday

### 20.2 (2020-08-24)

* Added good robot using ubuntu 18.04 container
* Updated openxray with fix for SDL full screen
* opengothic - Upgrade to v0.29
* dosbox-staging - Upgrade to 0.75.1

### 20.1 (2020-08-17)

* Updated openrct2 to 0.3.0

### 20.0 (2020-08-06)

* Added scummvm as an engine option
* Added residualvm as an engine option
* Added choice of container for use in building
* Added openxray, using ubuntu 18.04 container
* Added initial dosbox-staging support

### 19.0 (2020-07-30)

* Added common QT 5.9 for use with engine building and usage.
* Added openmw launcher support using common qt
* Added openapoc launcher support using common qt
* Added warzone 2100 using common qt
* Added openmw-tes3mp support using common qt

### 17.0 (2020-07-29)

- Added openxcom
- Added openxcom-oxce

### 16.0 (2020-07-15)

- Added ut99 (proprietary engine)

### 14.0 (2020-07-13)

- Added prey 2006 (proprietary engine)

### 13.0 (2020-07-12)

- Changed quake4 to use new interactive setup.
- Changed ut2004 to use new interactive setup.

### 11.0 (2020-07-11)

- Added ut 2004 (proprietary engine)
  - Client will ask before taking any steps if you want to use this engine
  - Engine script will be downloaded, along with the following libraries to help improve game experience:
    - sdlcl - SDL 2 compatibility layer
    - openal - Needed for sound to work
    - libstdc++.so.5 - Needed for game to launch, most modern distros do not have this version installed by default.
  - Engine script will take care of presenting the original EULA, downloading the installer, extracting the data, and setting up. The process will ask for the cd key, which can be seen in the Steam client.
  
### 10.0 (2020-07-09)

- Added openapoc
- Added quake 4 (proprietary engine)
  - Client will ask before taking any steps if you want to use this engine
  - Engine script and override default configuration will be downloaded
  - Engine script will take care of presenting the original EULA, downloading the installer, extracting the data, and setting up. In this case, it'll also copy the cd key to the proper place, so it's just launch and go.
  
### 9.0 (2020-07-07)

- Changed engine package creation for the following games to use common packages:
  - dhewm3
  - arxlibertatis
  - gzdoom
  - yquake2
  - ioquake3
- Updated dxx-rebirth engine to use SDL2 instead of SDL1. Fixed an issue with playback of music files.
- Updated gzdoom engine to use 4.4.2, with included fluidsynth and GCC 9 build support. Newer version should also fix crashing issues.
- Updated dxx-rebirth to latest master, using the new GCC 9 build support.
- Added openrct2, using the new GCC 9 build system. Steam overlay needs to be disabled for this game.

### 8.0 (2020-07-06)

- Patch for Arx Libertatis engine to use borderless full screen mode.
- Added new engines
  - dxx-rebirth
  - ctp2
  
### 3.0 (2020-06-13)

- Added new engine
  - jk2mv
  
### 1.0 (2020-05-30)

- Added new engines
  - Freespace 2
  - AVP
  - OpenGothic
  - RBDoom-3-BFG
  - Julius
