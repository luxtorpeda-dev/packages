#!/bin/bash

while getopts "acdemptw" opt; do
  case $opt in
    a) swf="aether.swf";;
    c) swf="moregames/Clubbe The Seal.swf";;
    d) swf="moregames/Dumpling.swf";;
    e) swf="moregames/Weltling2.swf";;
    m) swf="meatboy.swf";;
    p) swf="meatboymappack.swf";;
    t) swf="Tri-achnid.swf";;
    w) swf="moregames/Weltling.swf";;
  esac
done

echo "launching $swf"
./ruffle_desktop "$swf"
