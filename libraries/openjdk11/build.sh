#!/bin/bash

wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.12_7.tar.gz
tar xvf OpenJDK11U-jdk_x64_linux_hotspot_11.0.12_7.tar.gz
export PATH="$PATH:$PWD/jdk-11.0.12+7/bin"

wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar xvf apache-maven-3.9.6-bin.tar.gz
export PATH="$PATH:$PWD/apache-maven-3.9.6/bin"
