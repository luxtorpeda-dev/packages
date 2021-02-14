#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    ./blood -usecwd -nosetup
elif [ "$gamearg" = "-addon" ]; then
    ./blood -usecwd -nosetup -ini CRYPTIC.ini
