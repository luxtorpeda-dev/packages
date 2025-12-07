#!/bin/bash
URL="${1//\//%2F}" # replace / with %2F
PROTOCOL=${URL:0:3} # it's either rf: or af:
if [ "$PROTOCOL" = "rf:" ]; then
xdg-open "steam://run/20530//-game -url $URL"
elif [ "$PROTOCOL" = "af:" ]; then
xdg-open "steam://run/20530//-aflink $URL"
fi
