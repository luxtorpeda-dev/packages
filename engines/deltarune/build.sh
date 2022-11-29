#!/bin/bash

# CLONE PHASE
wget -O "DELTARUNE Chapter 1&2 (Linux x86_64 1.10).zip" https://www.dropbox.com/s/i3ixf99lhlo5uyy/DELTARUNE%20Chapter%201%262%20%28Linux%20x86_64%201.10%29.zip?dl=1
unzip "DELTARUNE Chapter 1&2 (Linux x86_64 1.10).zip" -d "deltarune"

# COPY PHASE
cp -rfv "deltarune/assets" "$diststart/1690940/dist/"

cp -rfv "deltarune/DELTARUNE" "$diststart/1690940/dist/"
