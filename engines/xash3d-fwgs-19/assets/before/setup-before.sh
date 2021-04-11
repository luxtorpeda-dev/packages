#!/bin/bash

cp -rfv ./Spirit/cl_dlls/client.so ./before/cl_dlls
cp -rfv ./Spirit/dlls/spirit.so ./before/dlls
sed -i 's/gamedll "dlls\/spirit\.dll"/gamedll "dlls\/spirit\.so"/' before/liblist.gam
mv ./Spirit/liblist.gam ./Spirit/liblist.gam.bak
