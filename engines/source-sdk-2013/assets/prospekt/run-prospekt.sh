#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f "sdkpath.txt" ]; then
    if [[ ! -z "${DEPPATH_243730}" ]]; then
        echo "Automatic path for sdk found at $DEPPATH_243730"
        HL_PATH="$DEPPATH_243730"
    else
        error_message="Path to Source SDK 2013 not given."
        echo "$error_message" > last_error.txt
        exit 10
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "prospekt"
        LD_PRELOAD="" find ./ | LD_PRELOAD="" sort -r | LD_PRELOAD="" sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' |LD_PRELOAD="" sh
    popd
fi

if [ ! -f "runtimepath.txt" ]; then
    if [[ ! -z "${DEPPATH_1070560}" ]]; then
        echo "Automatic path for runtime found at $DEPPATH_1070560"
        RUNTIME_PATH="$DEPPATH_1070560"
    else
        error_message="Path to Steam Linux Runtime not given."
        echo "$error_message" > last_error.txt
        exit 10
    fi

    echo "$RUNTIME_PATH" >> runtimepath.txt
fi

if [[ ! -z "${DEPPATH_243730}" ]]; then
    sdkpath="$DEPPATH_243730"
    echo "Automatically detected sdkpath at $sdkpath"
else
    sdkpath=$(cat sdkpath.txt)
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=$(cat runtimepath.txt)
fi

pushd "prospekt"
    LD_PRELOAD="" mkdir bin
    LD_PRELOAD="" ln -rsf "$sdkpath/sourcetest/bin/client.so" bin/client.so
    LD_PRELOAD="" ln -rsf "$sdkpath/sourcetest/bin/server.so" bin/server.so
popd

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/prospekt" -steam
