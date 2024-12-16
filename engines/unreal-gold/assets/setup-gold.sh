#!/bin/bash

cd ../

# Define the directories
DIRS=("System" "System64")

# Loop through each directory
for DIR in "${DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    echo "Deleting *.int files in $DIR..."
    find "$DIR" -type f -name "*.int" -exec rm -f {} \;
  else
    echo "Directory $DIR does not exist. Skipping..."
  fi
done

echo "Operation completed."
