#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [[ ! -z "${DEPPATH_1118310}" ]]; then
    echo "Automatic path for retroarch found at $DEPPATH_1118310"
    RETROARCH_PATH="$DEPPATH_1118310"

    CORENAME="$1"
    EXTENSION="$2"
    GIVENFILEPATH="$3"
    echo "Core name $CORENAME with extension $EXTENSION and given file path $GIVENFILEPATH"

    COREPATH="${DEPPATH_1118310}/cores/${CORENAME}_libretro.so"
    echo "Checking for core at $COREPATH"

    if [ -f "$COREPATH" ]
    then
        echo "Core found at ${COREPATH}"

        GAMEDIR="$PWD"
        cd "$RETROARCH_PATH"

        if [[ ! -z "$GIVENFILEPATH" ]]; then
            echo "Using provided relative path $GIVENFILEPATH"
            FILEPATH="$GAMEDIR/$GIVENFILEPATH"
        else
            if [[ ! -z "$EXTENSION" ]]; then
                echo "Using extension $EXTENSION, looking up first file"

                FILE=$(find "$GAMEDIR" -type f -name "*.$EXTENSION")
                if [[ ! -z "$FILE" ]]; then
                    echo "File found at $FILE"
                    FILEPATH="$FILE"
                else
                    error_message="No game file found with extension $EXTENSION"
                    echo "$error_message"
                    echo "$error_message" > last_error.txt
                    exit 10
                fi
            else
                error_message="No extension given"
                echo "$error_message"
                echo "$error_message" > last_error.txt
                exit 10
            fi
        fi

        echo "./retroarch-inner.sh -L ./cores/${CORENAME}_libretro.so $FILEPATH"
        ./retroarch-inner.sh -L "./cores/${CORENAME}_libretro.so" "$FILEPATH"
    else
        error_message="RetroArch core $CORENAME was not found. Ensure that it is installed."
        echo "$error_message"
        echo "$error_message" > last_error.txt
        exit 10
    fi
else
    error_message="RetroArch was not found. Ensure that it is installed."
    echo "$error_message"
    echo "$error_message" > last_error.txt
    exit 10
fi
