#!/bin/bash

# CLONE PHASE
wget https://raw.githubusercontent.com/hrehfeld/QuakeInjector/refs/heads/master/COPYING

# COPY PHASE
cp -rfv assets/* "$diststart/2310/dist/"
