#!/bin/bash

export PATH="$PATH:./jdk-11.0.12+7/bin/"
java -Dorg.jtrfp.trcl.maintSettingsPath=maint.config.trcl.xml -Dorg.jtrfp.trcl.userSettingsPath=user.config.trcl.xml -jar RunMe.jar
