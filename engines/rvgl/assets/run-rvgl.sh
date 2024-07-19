#!/bin/bash

create_relative_symlink () {
	LD_PRELOAD="" local -r target=$1
	LD_PRELOAD="" local -r symlink="$(echo "$target" | tr '[:upper:]' '[:lower:]')"
	LD_PRELOAD="" ln -rsf "$target" "$symlink"
}

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f profiles/deck/profile.ini ]; then
        echo "Creating profile"
        if [ ! -d profiles/deck ]; then
            mkdir -p profiles/deck
        fi

        echo -e "[Misc]" >> profiles/rvgl.ini
        echo -e "UseProfiles = 1" >> profiles/rvgl.ini
        echo -e "DefaultProfile = \"deck\"" >> profiles/rvgl.ini
        echo -e "[Controller1]" >> profiles/deck/profile.ini
        echo -e "Joystick = 0" >> profiles/deck/profile.ini
        echo -e "NonLinearSteering = 1" >> profiles/deck/profile.ini
        echo -e "SteeringDeadzone = 10" >> profiles/deck/profile.ini
        echo -e "SteeringRange = 90" >> profiles/deck/profile.ini
        echo -e "ButtonOpacity = 50" >> profiles/deck/profile.ini
        echo -e "KeyLeft = 0x02000000" >> profiles/deck/profile.ini
        echo -e "KeyRight = 0x03000000" >> profiles/deck/profile.ini
        echo -e "KeyFwd = 0x02000001" >> profiles/deck/profile.ini
        echo -e "KeyBack = 0x03000001" >> profiles/deck/profile.ini
        echo -e "KeyFire = 0x01000000" >> profiles/deck/profile.ini
        echo -e "KeyReset = 0x01000001" >> profiles/deck/profile.ini
        echo -e "KeyReposition = 0x01000002" >> profiles/deck/profile.ini
        echo -e "KeyHonka = 0x01000005" >> profiles/deck/profile.ini
        echo -e "KeyChangeCamera = 0x0000003a" >> profiles/deck/profile.ini
        echo -e "KeyRearView = 0x01000004" >> profiles/deck/profile.ini
        echo -e "KeyPause = 0x01000003" >> profiles/deck/profile.ini
    fi
fi

LD_PRELOAD="" ln -rsf ./music ./redbook

pushd music
for file in *.ogg ; do
	create_relative_symlink "$file"
done
popd

chmod +x rvgl.64
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:lib/lib64:lib" ./rvgl.64
