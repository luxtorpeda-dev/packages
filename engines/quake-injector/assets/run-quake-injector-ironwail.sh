#!/bin/bash

cd ironwail

export PATH="$PATH:./jdk-11.0.12/bin/"

if [ ! -f config.properties ]; then
    cp -rfv config.properties-template-ironwail config.properties
fi

java -jar ./QuakeInjector-alpha05/lib/QuakeInjector-alpha05.jar
