#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm sdl2_mixer

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

# Comment this out if you need an AUR package
#make-aur-package sdlpop

# If the application needs to be manually built that has to be done down here
echo "Building SDLPoP..."
echo "---------------------------------------------------------------"
REPO="https://github.com/NagyD/SDLPoP"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./SDLPoP
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./SDLPoP/src
make -j$(nproc)
mv -v prince ../data ../SDLPoP.ini ../../AppDir/bin
