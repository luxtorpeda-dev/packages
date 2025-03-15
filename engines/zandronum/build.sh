#!/bin/bash

# CLONE PHASE
wget https://raw.githubusercontent.com/TorrSamaho/zandronum/refs/heads/master/LICENSE.txt

wget https://zandronum.com/essentials/fmod/fmodapi42416linux64.tar.gz
tar -xvf fmodapi42416linux64.tar.gz

# COPY PHASE
cp -rfv assets/* "$diststart/common/dist/"
