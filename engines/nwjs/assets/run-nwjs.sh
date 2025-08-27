#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
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

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=$(cat runtimepath.txt)
fi

FILE="package.json"
DIRNAME=$(basename "$PWD")

if [ -f "$FILE" ]; then
  # Case 1: name exists but is empty -> replace with folder name
  if grep -q '"name"[[:space:]]*:[[:space:]]*""' "$FILE"; then
    sed -i "s/\"name\"[[:space:]]*:[[:space:]]*\"\"/\"name\": \"$DIRNAME\"/" "$FILE"

  # Case 2: name key missing entirely -> insert at top
  elif ! grep -q '"name"[[:space:]]*:' "$FILE"; then
    sed -i "0,/{/s//{\n  \"name\": \"$DIRNAME\",/" "$FILE"
  fi
else
  echo "package.json not found; skipping."
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./nwjs/nw .
