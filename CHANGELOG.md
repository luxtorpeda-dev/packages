### 2024-02-03

* gzdoom - Add support for Beyond Sunset

### 2024-01-05

* DOOM Retro - Update to 5.2.0
* odamex - Update to 0880dd0
* dominatrix - Update to v1.1
* DOOM Retro - Update to v5.2.1
* SeriousSamClassic-VK - Update to 1.10.6d
* Added M.A.X.

### 2023-12-27

* Added DXX-Redux
* Augustus - Update to 4.0.0
* Daggerfall Unity - Update to 1.0.0
* scummvm - Update to 2.8.0
* OpenRCT2 - Update to 0.4.7

### 2023-12-11

* Daikatana - Update to 2023-08-17
* DOOM Retro - Update to 5.1.1
* ut99 - Update to v469d
* dsda-doom - Update to 0.27.5
* DOOM Retro - Update to 5.1.3

### 2023-11-27

* [madscientist16] Daggerfall Unity - Update to 0.16.2 RC
* warzone2100 - Update to 4.4.2

### 2023-11-05

* Add Eternity Engine
* warzone2100 - Update to 4.4.0
* OSS-Cosmic-Amnesia - Update to v1026
* Added Sin Gold port
* Add cloud save support for chocolate-doom and crispy-doom
* Hammer of Thyrion - Support cloud saves
* JA2 - Update to 0.21.0
* iortcw - Add support for steam cloud
* Add support for Russian Doom

### 2023-10-14

* Doom Retro - Update to 5.0.6
* SeriousSamClassic-VK - Update to 1.10.6
* Doom64Ex-Plus - Update to 3.6.5.9
* International Doom - Update to 7.2.1
* ja2 - Update to 0.20.0

### 66.1.0 (2023-09-05)

* Added DREAMM support
* Add support for Hiigara engine
* Add support for OSS-Cosmic Amnesia
* DOOM Retro - Update to 5.0
* Daggerfall Unity - Update to 0.16.0
* openmw - Fix for fps issues on deck

### 66.0b (2023-09-03)

* OpenRCT2 - Update to 0.4.6

### 66.0 (2023-08-14)

* runescape - Extract deb with client instead of ar cli command, now this will show up as setup steps on the progress screen
* openlara - Extract iso with client instead of cli commands, now this will show up as setup steps on the progress screen
* scummvm - Extract iso with client instead of cli command, now this will show up as setup steps on the progress screen
* ecwolf - Update to 1.4.1
* darkplaces - Update to latest github project
* Daggerfall Unity - Update to 0.15.4 Beta

### 65b (2023-08-02) 

* chocolate-doom - Update to 20abc8b
* Updated engines to use vcpkg for library depedencies where possible
* Doom Runner - Update to 1.8.1
* crispy-doom - Add support for additional Doom games
* Classic-RBDOOM-3-BFG - Update to 1.3.0
* yquake2, vkquake2, q2pro - Support remaster update music, provided from Steam download
* fteqw - Update to latest
* runescape - Switch to using client extraction of ar

### 65.1 (2023-07-10)

* OpenGothic - Update to v1.0.2207
* vkquake2 - Update to 1.5.9
* Doom Runner - Update to 1.7.3
* Godot - Add support for Cruelty Squad
* [neuromancer] scummvm - Update to 2.7.1
* openmw - Update to 0.48.0, use upstream binaries
* Doom Runner - Update to v1.8.0

### 65.0 (2023-06-15)

* Rigel-Engine - Fix for launch
* gzdoom - Fix wadsmoosh python use
* qzdl - Fix wadsmoosh python use
* doom-runner - Fix wadsmoosh python use
* openrct2 - Add missing classic app id for build
* runescape - Run under steam linux runtime
* dosbox-staging - Add MOO2
* Classic-RBDOOM-3-BFG - Update to 93f46f2, fixing OpenPlatform for achivements
* prboom-plus - Update to 2.6.66
* DOOM64EX+ - Update to 3.6.5.8
* Daggerfall Unity - Update to 0.15.3 Beta

### 65.0 (2023-06-09)

* Remove decode_as_zip, as new client will automatically detect
* Remove duplicated information in "information" key as client will now get it from the same place as the web UI
* Remove copy_only, as that'll be assumed if the file is not detected as an archive
* fsport - Update to use new 7z client feature, so extracting status will be visible in the client UI
* metadata - Update to new structured format, which the client can parse easier and makes the client easier to update
* building - Update sniper runtime version used to 0.20230509.49493
* scummvm - Add The 7th Guest

### 63.3 (2023-06-04)

* SeriousSamClassic-VK - Update to 258fd1d
* RVGL - Update to 23.0602a1

### 63.2 (2023-05-15)

* doom-retro - Update to 4.9.2
* Add support for AnodyneFNA, thanks to flibitijibibo for the package request
* ironwail - Add support for re-release, in light of news about vkquake no longer in active development; Switch Horde maps to use ironwail
* quake-injector - Add option for ironwail
* Daikatana - Update to 2023-03-12
* RBDOOM-3-BFG - Update to 1.5.1
* SeriousSamClassic-VK - Update to f6a559f
* openjk - Add support for steam cloud. Started some work in supporting Steam Cloud, in general this will copy your saves from a user directory where the engine stores them to the area that steam expects for cloud saving (usually in the game directory), and the symlinks the steam cloud directory back. Currently each game will require setting ```LUX_STEAM_CLOUD=1 %command%``` in the launch options, with a plan for a future client release to set it for all engines via the config. Note that the original directory is moved before the link so you can go back to that if needed.
* renpy - Add Midnight Witch
* unreal-gold - Add support for 64-bit

### 63.1 (2023-04-22)

* doom-retro - Update to 4.9.1
* RBDOOM-3-BFG - Update to 1.5.0
* openrct2 - Update to 0.4.5

### 63.0 (2023-04-13)

* Re-build engines using Steam Linux Runtime - Sniper
* crispy-doom - Update to 6.0
* eduke32 - Update to 6537106e
* exhumed - Update to 09143c3
* Hammer of Thyrion - Update to f22de3d
* ioquake3 - Update to 18f3b6b
* iortcw - Update to 48116b9
* ete - Update to 1e69cda
* nblood - Update to 09143c3
* netduke32 - Update to v1.2.1
* notblood - Upgrade to 7813e43
* openjk - Update to d3e8c8d
* OpenLoco - Update to v23.03
* OpenTESArena - Update to 2d443bd
* openxcom - Update to 82b7b11
* OpenXcom OXCE Plus - Update to 7.8.18
* q2pro - Update to 6a70d47
* qss-m Update to 1.5.5
* rednukem - Update to 09143c3
* serious-engine - Update to 5725e81
* vanilla-conquer - Update to 83c152c
* voidsw - Update to 6537106e
* cortex-command - Update to latest
* doukutsu-rs - Update to 5821f06
* raze - Update to 1.7.1
* **doom-runner - Update to 1.7.1**
* qzdl - Update to 44aaec0
* OpenApoc - Update to a224501
* doomseeker - Update to 9fab457
* **openmw-latest - Update to 0.48 RC9**
* warzone2100 - Update to 4.3.5
* **classic-rbdoom-3-bfg - Update to latest**
* perimeter - Update to latest

### 62.0 (2023-04-06)

* runescape - Update to 2.2.11
* commander-genius - Automatically download catalogue
* doom-retro - Update to 4.9
* DOOM64EX+ - Update to 3.6.5.7

### 61.7 (2023-03-27)

* warzone2100 - Update to 4.3.4
* openrct2 - Update to v0.4.4
* OpenApoc - Update to 20230328
* Added doom64ex-plus
* Added dsda-doom
* avp - Allow for unlimited saves
* SeriousSamClassic-VK - Update to 306f653
* raze - Update to 1.7.0

### 61.6 (2023-03-08)

* doom-retro - Update to 4.8.1
* vkquake - Update to 1.30.1
* etlegacy - Update to 2.81.1
* ruffle - Update to 8a2d440
* ironwail - Update to 0.7.0
* [electricbrass] Odamex - Update to 10.3.0
* scummvm - Add support for Sam & Max Hit the Road

### 61.5 (2023-02-24)

* Added QSS-M
* OpenRA - TiberianDawnHD - Update to release-20230225
* [neuromancer] scummvm - Update to 2.7.0

### 61.4 (2023-02-05)

* ET: Legacy - Update to 2.81.0
* Added Ozymandias
* OpenGothic - Update to v1.0.1891
* openrct2 - Added classic support
* ut99 - Master server update
* ut2004 - Master server update
* openxcom-oxce - Update to 7.8

### 61.3 (2023-01-15)

* inter-doom - Update to 6.2
* OpenLoco - Update to v22.12
* ut99 - Fix for case sensitive imports & update config & add bonus pack 4
* inter-doom - Update to 6.2.1
* ecwolf - Update to 1.4.0
* Add openra-tiberiandawnhd, for the Remastered Collection, support for Tiberian Dawn
* doukutsu-rs - Update to 0.100.0-beta5
* Add Vanilla Conquer for original game assets from Remastered Collection

### 61.2 (2023-01-01)

* inter-doom - Update to 6.1
* warzone2100 - Update to 4.3.3
* Daikatana - Update to 1.3 2022-12-22
* [mkasick & d10sfan] ecwolf - Update to latest & support SOD for Wolf3D steam listing
* dosbox-staging - Update to 0.80.1
* raze - Update to 1.6.2

### 61.1 (2022-12-18)

* doom-retro - Update to 4.7.2
* raze - Update to 1.6.1
* dosbox-staging - Update to 0.80.0

### 61.0 (2022-12-02)

* gzdoom - Update to 4.10.0
* vkquake - Update to 1.22.3
* raze - Update to 1.6.0
* doom-retro - Update to 4.7.1
* unreal-gold - Update to 227j
* OpenRCT2 - Update to 0.4.3

### 60.0 (2022-11-17)

* webui - Update to angular 15
* OpenLoco - Update to v22.11

### 59.2 (2022-10-31)

* daggerfall-unity - Update to 0.14.5 Beta
* ut99 - Update to 469c
* scummvm - Update to 2.6.1
* warzone2100 - Update to 4.3.1
* Added NotBlood
* gzdoom - Update to 53c2ac7
* warzone2100 - Update to 4.3.2

### 59.1 (2022-10-01)

* ironwail - Update to 9c25cea
* quakespasm-spiked - Update to e9822ae
* source-sdk-2013 - Add entropy-zero2
* openrct2 - Update to 0.4.2
* OpenLoco - Update to v22.10
* openjk - Use for academy mp
* Added Odamex
* [jcotton42] dxx-rebirth - Update to e3faab0899bc86184fdd67568ccc4f237c5f6807
* Added doomseeker
* quake3e - Update to 2022-10-14
* OpenGothic - Update to v1.0.1705
* openxcom-oxce - Update to 7.7.6

### 59.0 (2022-09-11)

* Added Crispy Doom
* Added International Doom
* [jm2] etqw - Add auto download/install support for full game
* [Ryhon0] OpenGothic - Add Gothic 1 Support
* bstone - Update to v1.2.12
* dosbox-staging - Update to 0.79.0
* augustus - Update to 3.2.0
* inter-doom - Update to 6.0.1
* iortcw - Update to 6cbc480
* dosbox-staging - Update to 0.79.1

### 56.1 (2022-08-23)

* runescape - Update to 2.2.10
* misc - Restore other Doom II listings
* Added ezQuake
* doom-retro - Update to 4.6.1
* ruffle - Update to 576c35a
* Added a2pro
* Added cnq3
* dxx-rebirth - Update to 366b048879d62a3096357509fc856dde1abfb7ff
* doom-retro - Update to 4.6.2

### 56.0 (2022-08-06)

* Added HomeworldSDL
* fs2open - Update to 22.2.0
* dxx-rebirth - Update to d1ed53e
* daggerfall-unity - Update to 0.14.3 Beta
* Updated logic to handle Doom II update, so that all of the launch options can work with the doom engines. Note that Master Levels only works with gzdoom, and an error will show up related to that if another engine is picked for that option.
* Updated logic to handle Quake II update
* Daggerfall Unity - Update to 0.14.4 Beta
* doom-retro - Update to 4.6.0.1

### 55.3 (2022-08-01)

* [Thanks to sponsors for funds to buy the games] Added RVGL
* scummvm - Update to 2.6.0

### 55.2 (2022-07-18)

* Daggerfall Unity - Update to 0.14.2 Beta
* raze - Update to 1.5.0
* classic-rbdoom-3-bfg - Add fix for other languages

### 55.1 (2022-06-26)

* serious-engine - Switch to SeriousSamClassic-VK
* avp - Fix FMVs
* Added daggerfall-unity
* OpenGothic - Update to v1.0.152
* OpenLoco - Update to 22.06.1
* gzdoom - Update to 4.8.2
* OpenRCT2 - Update to 0.4.1
* Added gardensofkadesh, for Homeworld 1 Classic
* eduke32 - Fix for world tour
* daggerfall-unity - Update to 0.14.1
* Removed buildgdx for now due to crashing issues
* vkQuake - Update to 1.20.3

### 55.0 (2022-05-29)

* ut2004 - Add standard option that removes the foxWSFix for online play.
* [Thanks to sponsors for funds to buy the games] Added doukutsu-rs
* etlegacy - Fix 64-bit launch & Fix x11 library missing
* Added ETe, another option for W:ET
* Added openmw-latest, using latest from development. Includes option to launch with Zesterer's OpenMW Shaders, without having to manually install them.
* openmw-latest - Fix for missing config line & stop using launcher
* doom-retro - libraries & update to latest branch for save fix
* gzdoom - Update to 4.8.0
* scummvm-latest - Update to latest RC
* dhewm3 - Update to 1.5.2
* openmw-latest - Add back support for launcher. This changes the config structure a bit, but it should be usable without having to change anything manually. Config is in ./openmw-latest/local-cfg and soft links are created for existing files.

### 54.0 (2022-05-21)

* openxcom - Add defaults for steam deck
* openxcom-oxce - Add defaults for steam deck
* ut99 - Add defaults for steam deck. If run before on the system, will need to delete the ready file in the game install directory.
* openmw - Add defaults for steam deck
* warzone2100 - Add defaults for steam deck
* ecwolf - Add defaults for steam deck
* good-robot - Add defaults for steam deck
* OpenLoco - Add defaults for steam deck
* dhewm3 - Add defaults for steam deck
* openjk - Add defaults for steam deck
* realrtcw - Add defaults for steam deck
* DOOM Retro - Update to 4.5
* iortcw - Add defaults for steam deck
* RigelEngine - Update to 0.8.5
* doom-retro - Update to 4.5.1

### 53.0 (2022-05-12)

* ironwail - Update to 0.6.0
* gzdoom - Add Project Crypt
* vkQuake - Update to 1.13.1
* OpenLoco - Update to 22.05.1
* Perimeter - Update to 3.0.10

### 52.1 (2022-05-07)

* scummvm - Switch to local config file
* classic-rbdoom-3-bfg - Add support for bethesda.net edition
* OpenLoco - Update to 22.05
* scummvm - Support games that have assets in .iso, will look for an iso and extract it.
* Add scummvm-latest, which has uses the most recent commit at the time. This would only be updated on request, where the normal scummvm will be updated whenever there is a new release.
* [Thanks to sponsors for funds to buy the games] scummvm-latest - Add Wetlands
* Added Spearmint engine, for Quake III: Arena & Quake III: Team Arena. Has nice support for controllers in menu and in-game.
* ET: Legacy - Update to 2.80.2

### 52.0 (2022-04-25)

* metadata - Track support for controllers - See https://github.com/luxtorpeda-dev/packages/issues/529#issuecomment-1104508644 for more information
* vkQuake - Add support for horde maps
* vkQuake - Improve default controller config
* quakespasm-spiked - Improve default controller config
* ironwail - Improve default controller config
* yquake2 - Improve default controller config
* yquake2 - Update to 4db6534, additional controller support
* gzdoom - Additional game controller support
* wigzdoom - Update to f0ffed7, additional controller support
* raze - Add default controller support
* metadata - Add quake horde map names
* openrct2 - Update to v0.4.0
* Added ET: Legacy
* [Thanks to sponsors for funds to buy the games] dosbox-staging - Add support for battlespire and redguard
* Added OpenTESArena, in progress engine
* dosbox-staging - Add for arena as additional option
* Jagged Alliance 2 Stracciatella - Update to 0.19.1
* [Thanks to sponsors for funds to buy the games] Added 7kaa
* openmw-tes3mp - Update to 0.8.1

### 51.1 (2022-04-02)

* fs2open - Update to 22.0.0
* Added ironwail, quakespasm fork for improved performance with large mods
* [Thanks to sponsors for funds to buy the games] Added retroarch launching support, to launch Steam RetroArch and the downloaded cores for any Steam game that has a supported game file.
* RigelEngine - Update to 0.8.4
* Arx Libertatis - Update to 1.2.1
* OpenLoco - Update to 22.04
* doom-runner - Add support for master levels
* qzdl - Add support for master levels
* raze - Add support for classic 1997
* vkquake - Update to 87b2e56, fixed an issue with the recent game patch

### 51.0 (2022-03-14)

* doom-retro - Update to 4.4.10
* Added Doom Runner - This allows for easy launching of doom mods using gzdoom. The initial setup is taken care of, so that the tool should know where the lux client installed gzdoom is and where the WADs are for the particular game. Then, a mod can be selected and used.
* Added qzdl - This is another doom mod launcher. The initial setup of where gzdoom is taken care of and you can browser to which WAD you want to load. 
* perimeter - Update to 3.0.9
* vkquake - Update to 1.13.0

### 50.1 (2022-03-06)

* RBDOOM-3-BFG - Update to 1.4.0
* Added doom-retro
* warzone2100 - Update to 4.2.7
* openloco - Update to 22.03.1
* ut2004 - Switch to sdl12-compat
* prey2006 - Switch to sdl12-compat
* quake4 - Use sdl12-compat
* unreal-gold - Switch to sdl12-compat
* etqw - Switch to sdl12-compat

### 50.0 (2022-02-28)

* openmw - Fix initial launch issues
* warzone2100 - Update to 4.2.6

### 48.3 (2022-02-10)

* Fixed an issue with prboom-plus and fluidsynth
* source-sdk-2013 - Add fast-detect
* prboom-plus - Update to 2.6.2
* openmw-tes3mp - Update to 0.8.0

### 48.2 (2022-01-24)

* raze - Update to 1.4.0
* perimeter - Update to b7be1c7
* raze - Update to 1.4.1

### 48.1 (2022-01-02)

* openrct2 - Fix launch issues
* rigelengine - Update to 0.8.3
* scummvm - Update to 2.5.1
* dosbox-staging - Update to 0.78.1
* Added onelife
* buildgdx - Update to 1.16
* source-sdk-2013 - Add prospekt
* quake3e - Update to 2baea18

### 47.2 (2021-12-13)

* [Thanks to Jpx] Added Godot
* raze - Update to 1.3.1
* [Thanks to Jpx] Added Renpy
* warzone2100 - Update to 4.2.4
* vkquake - Update to 1.12.2

### 47.1 (2021-11-21)

* openrct2 - Update to v0.3.5.1
* rigelengine - Update to 0.8.2
* [Thanks to sponsors for funds to buy the game] dosbox-staging - Add support for MoM
* augustus - Update to 3.1.0
* realrtcw - Support steam assets
* vkquake - Update to 1.12.1
* [Thanks to Jpx] Added blastem
* warzone2100 - Update to 4.2.3
* raze - Update to 1.3.0
* openxray - Update to December 2021 RC1

### 47.0 (2021-11-12)

* openhexagon - Update to 2.1.2
* Added starting point for ruffle support
* Added nwjs with 0.54
* [Thanks to Jpx] ruffle - add The Basement Collection

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
* Added terminal-recall to runtime. Thanks to Jpx for the key
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
