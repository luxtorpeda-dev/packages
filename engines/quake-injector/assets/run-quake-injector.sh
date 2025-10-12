#!/bin/bash

export PATH="$PATH:./jdk-11.0.12/bin/"

if [ ! -f config.properties ]; then
    cp -rfv config.properties-template config.properties
fi

java -jar ./QuakeInjector-alpha08/lib/QuakeInjector-alpha08.jar
