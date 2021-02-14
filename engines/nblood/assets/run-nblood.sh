#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    ./nblood -usecwd -nosetup
elif [ "$gamearg" = "-addon" ]; then
    ./nblood -usecwd -nosetup -ini CRYPTIC.ini
