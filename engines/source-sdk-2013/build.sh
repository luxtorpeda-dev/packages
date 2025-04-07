#!/bin/bash

# CLONE PHASE
wget https://raw.githubusercontent.com/ValveSoftware/source-sdk-2013/refs/heads/master/LICENSE

# COPY PHASE
cp -rfv assets/entropy-zero/* "$diststart/714070/dist/"

cp -rfv assets/metastasis/* "$diststart/235780/dist/"

cp -rfv assets/year-long-alarm/* "$diststart/747250/dist/"

cp -rfv assets/resistance-element/* "$diststart/1054600/dist/"

cp -rfv assets/downfall/* "$diststart/587650/dist/"

cp -rfv assets/prospekt/* "$diststart/399120/dist/"

cp -rfv assets/fast-detect/* "$diststart/353220/dist/"
