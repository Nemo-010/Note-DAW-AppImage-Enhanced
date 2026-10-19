#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DEPLOY_PIPEWIRE=1
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Nota refuses to start when it cannot open an audio device, which the CI
# has none of, so only the simple test (missing libs/symbols) is possible
quick-sharun --simple-test ./dist/*.AppImage
