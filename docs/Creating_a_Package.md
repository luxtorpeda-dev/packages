# Creating A Package

Please note that reverse-engineering projects are not supported for this project, where the original executable is used to create the engine, instead of creating it in a more open source manner. If you have any questions on this, please feel free to create an issue or talk on discord.

## Structure

Each package has a folder with the build scripts and any static assets, such as a launcher script or custom configuration files for the game. These are located in the `engines` folder, so if you wanted to create a package for the dhewm3 engine, the path would be `engines/dhewm3`.

The structure of an engine folder is as follows:

* `env.sh` - Contains the steam app id list for the games that this engine applies to, as well as the path to the license file from the engine repository, if exists. If there are multiple app ids, then each one should be separated by a space.
* `build.sh` - Script that will pull down the source repository, run any necessary configuration, and then build the engine.
* `assets/*` - If needed, an assets folder can be created for any static assets needed for the engine. If any scripts need to be run as part of setup or run, ensure that zenity is used with "$STEAM_ZENITY".

## Build Script Explanation

In the build script, there are three main phases, that are denoted by the comments separating them.

### `CLONE PHASE`
Phase where any necessary repositories are cloned and the correct branch or hash is checked out.

A simple clone phase can look like the following. The engine should always be cloned into the `source` directory

        # CLONE PHASE
        git clone https://github.com/dhewm/dhewm3.git source
        pushd source
        git checkout 3a763fc6
        popd
        
For engines with submodules, it can look like the following:

        # CLONE PHASE
        git clone https://github.com/Try/OpenGothic source
        pushd source
        git checkout -f b6a1260
        git submodule update --init --recursive
        popd
        
### `BUILD PHASE`
Phase where the building of the engine occurs. This would be where the engine's make scripts could be run.

        # BUILD PHASE
        pushd source/neo
        mkdir build
        cd build
        cmake -DCMAKE_INSTALL_PREFIX=../../../tmp ..
        make -j "$(nproc)"
        make install
        popd

### `COPY PHASE`
Phase where the copying of the binaries and libraries occur, to create the final package. 

The path to copy into should follow this template: `$diststart/<appid>/dist/`, replacing `<appid>` with the app id necessary. If an engine supports multiple games, then the files would need to be copied into each app id, as shown below.

        # COPY PHASE
        cp -rfv tmp/bin/* "$diststart/9050/dist/"
        cp -rfv tmp/lib/dhewm3/* "$diststart/9050/dist/"
        cp -rfv tmp/bin/* "$diststart/9070/dist/"
        cp -rfv tmp/lib/dhewm3/* "$diststart/9070/dist/"

## How-To

1. Fork the packages repo and create a branch, named after the engine that should be built.

2. In the engines folder, create a new folder named after the engine use this folder for the following steps.

3. Create env.sh file, using the following template.

        #!/bin/bash

        export STEAM_APP_ID_LIST="9050 9070"
        export LICENSE_PATH="./source/COPYING.txt"
        export ADDITIONAL_LICENSES="./source/LICENSE.DejaVu ./boost/LICENSE_1_0.txt ./glm/copying.txt ./data/LICENSE"
        

4. Create build.sh, using the following template. 

        #!/bin/bash

        # CLONE PHASE
        git clone https://github.com/dhewm/dhewm3.git source
        pushd source
        git checkout 3a763fc6
        popd

        # BUILD PHASE
        pushd source/neo
        mkdir build
        cd build
        cmake -DCMAKE_INSTALL_PREFIX=../../../tmp ..
        make -j "$(nproc)"
        make install
        popd

        # COPY PHASE
        cp -rfv tmp/bin/* "$diststart/9050/dist/"
        cp -rfv tmp/lib/dhewm3/* "$diststart/9050/dist/"
        cp -rfv tmp/bin/* "$diststart/9070/dist/"
        cp -rfv tmp/lib/dhewm3/* "$diststart/9070/dist/"


5. Set the appropriate permisions on the scripts.

        chmod +x env.sh
        chmod +x build.sh
        
6. Test building the new package, using the instructions on the [Testing a Package](Testing.md) document.

7. Update `metadata/packages.json` to reflect the new package, using the following template. The information object will be used to display any necessary metadata on the packages list webpage. The download array will be created once the package has been built for the first time.

        "9050": {
            "game_name": "DOOM 3",
            "download": [],
            "command": "./dhewm3",
            "engine_name": "dhewm3"
        }
        
    Engines that need further setup can use the following template:

        "13230": {
            "game_name": "Unreal Tournament 2004: Editor's Choice Edition",
            "download": [
                {
                    "name": "ut2004",
                    "url": "https://bintray.com/luxtorpeda-dev/assets/download_file?file_path=",
                    "file": "ut2004-13230-3.tar.xz"
                },
                {
                    "name": "binaries",
                    "url": "https://treefort.icculus.org/ut2004/",
                    "file": "ut2004-lnxpatch3369-2.tar.bz2"
                }
            ],
            "download_config": {
                "binaries": {
                    "extract_location": "../linuxdata",
                    "strip_prefix": "UT2004-Patch/",
                    "setup": true,
                    "copy_only": false
                }
            },
            "setup": {
                "complete_path": "../ready",
                "command": "./setup-ut2004.sh",
                "uninstall_command": "./uninstall-ut2004.sh",
                "license_path": "../System/License.int"
            },
            "command": "./run-ut2004.sh",
            "use_original_command_directory": true
        }
        
   Engines that need choices can look like the following:
   
        "7650": {
            "game_name": "X-COM: Terror from the Deep",
            "download": [
                {
                    "name": "openxcom",
                    "url": "https://github.com/luxtorpeda-dev/packages/releases/download/openxcom-1/",
                    "file": "openxcom-common-1.tar.xz",
                    "cache_by_name": true
                }
            ],
            "download_config": {
                "openxcom": {
                    "extract_location": "./openxcom"
                },
                "openxcom-oxce": {
                    "extract_location": "./openxcom-oxce"
                }
            },
            "choices": [
                {
                    "name": "openxcom",
                    "command": "./openxcom/run-tftd.sh",
                    "download": ["openxcom"]
                },
                {
                    "name": "openxcom-oxce",
                    "command": "./openxcom-oxce/run-tftd.sh",
                    "download": ["openxcom-oxce"]
                }
            ]
        }

8. At the root level of packages.json, there is an engines key. Inside here is all of the engine information. A new engine should contain a new key inside engines, following the format of the others. For your app_id information, engine_name can be used to associate a game with a particular engine.

9. Once done with the new package, create a new pull request. Each pull request should only have one engine.
