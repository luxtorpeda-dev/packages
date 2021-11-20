#!/bin/bash

while getopts "acdemptw" opt; do
  case $opt in
    a) rom="ALEXKIDD_U.68K";;
    b) rom="BEYONDOA_U.68K";;
    c) rom="COMIXZON_U.68K";;
  esac
done

echo "launching $rom"
./emu/blastem "uncompressed ROMs/$rom"
