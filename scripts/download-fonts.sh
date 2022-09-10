#!/bin/bash

# script which downloads some needed fonts from google-fonts and put them in the src directory.
# used only when needed for helping in the download process (i.e. a new font is added)

# /!\ google-font-download must be available in the path
# see: https://github.com/neverpanic/google-font-download

# Absolute path to this script
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in.
SCRIPTPATH=$(dirname "$SCRIPT")
# Absolute path the downloaded fonts are in.
PATH_FONT="$SCRIPTPATH/../src/resources/fonts"

echo "Cleaning path $PATH_FONT"
rm -f "$PATH_FONT"/*.*

pushd .

cd "$PATH_FONT" || exit

echo "Downloading fonts..."
google-font-download "Bad Script:400" "Orbitron:500" "Oxygen Mono:400" "Roboto Mono:500" "Share Tech Mono:400"

echo "Done."

popd || exit