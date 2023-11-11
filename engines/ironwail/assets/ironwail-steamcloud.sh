#!/bin/bash

echo "Running steamcloud"

ln -rsf id1/PAK0.PAK id1/pak0.pak
ln -rsf id1/PAK1.PAK id1/pak1.pak

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./ironwail/lib:./lib" ./ironwail/ironwail "$@"
