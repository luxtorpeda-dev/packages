#!/bin/bash
SCRIPTPATH="$(readlink -f "$0")"
SCRIPTDIR="$(dirname "$SCRIPTPATH")"
read -r -n 1 -p 'This script will install URI handlers for af: and rf: URLs for Red Faction, are you ok with this? [y/N] ' _are_we_ok
printf "\n"

case "$_are_we_ok" in
[yY][eE][sS]|[yY])
    echo User said yes.
;;
*)
    echo Exiting...
    exit 1
;;
esac

cd "$HOME/.local/share/applications/" || exit 1
cat > rf-uri.desktop << EOF
[Desktop Entry]
Name=Red Faction URI Handler
Exec=$SCRIPTDIR/rf-uri-handler.sh %u
Terminal=false
Type=Application
MimeType=x-scheme-handler/rf;x-scheme-handler/af;
EOF

xdg-mime default rf-uri.desktop x-scheme-handler/rf
xdg-mime default rf-uri.desktop x-scheme-handler/af

echo ""
echo "Done! rf: and af: should be registered"
echo "Make sure to try opening a rf:// link at the FactionFiles' RFSB page"
echo "If opening any rf:// or af:// links doesn\'t work, make sure to make an issue in the luxtorpeda-dev/packages repository"
