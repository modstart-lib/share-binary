#!/bin/bash

set -e
set -x

# Get the latest scrcpy version from GitHub releases
#SCRCPY_BASE="https://github.com/Genymobile/scrcpy"
SCRCPY_BASE="https://github.com/modstart-lib/linkandroid-scrcpy"
SCRCPY_VERSION=$(curl -sL "${SCRCPY_BASE}/releases/latest" | grep -oE 'tag/v[0-9.]+' | head -n1 | sed 's/tag\///')
echo "Latest scrcpy version: $SCRCPY_VERSION"

# download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-macos-aarch64-v3.3.3.tar.gz
rm -rfv scrcpy-macos-aarch64.tar.gz
curl -L -o scrcpy-macos-aarch64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-macos-aarch64-${SCRCPY_VERSION}.tar.gz"
rm -rfv osx-arm64/scrcpy
mkdir -p osx-arm64/scrcpy
tar -xzf scrcpy-macos-aarch64.tar.gz -C osx-arm64/scrcpy --strip-components=1
rm -rfv scrcpy-macos-aarch64.tar.gz

# download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-macos-x86_64-v3.3.3.tar.gz
rm -rfv scrcpy-macos-x86_64.tar.gz
curl -L -o scrcpy-macos-x86_64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-macos-x86_64-${SCRCPY_VERSION}.tar.gz"
rm -rfv osx-x86/scrcpy
mkdir -p osx-x86/scrcpy
tar -xzf scrcpy-macos-x86_64.tar.gz -C osx-x86/scrcpy --strip-components=1
rm -rfv scrcpy-macos-x86_64.tar.gz

# download https://github.com/Genymobile/scrcpy/releases/download/v3.3.3/scrcpy-win64-v3.3.3.zip
rm -rfv scrcpy-win64.zip
curl -L -o scrcpy-win64.zip "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-win64-${SCRCPY_VERSION}.zip"
rm -rfv win-x86/scrcpy
mkdir -p win-x86/scrcpy
unzip -j scrcpy-win64.zip -d win-x86/scrcpy/
rm -rfv scrcpy-win64.zip

# download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-linux-x86_64-v3.3.3.tar.gz
rm -rfv scrcpy-linux-x86_64.tar.gz
curl -L -o scrcpy-linux-x86_64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-linux-x86_64-${SCRCPY_VERSION}.tar.gz"
rm -rfv linux-x86/scrcpy
mkdir -p linux-x86/scrcpy
tar -xzf scrcpy-linux-x86_64.tar.gz -C linux-x86/scrcpy --strip-components=1
rm -rfv scrcpy-linux-x86_64.tar.gz
