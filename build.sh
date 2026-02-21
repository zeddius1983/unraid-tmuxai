#!/bin/bash

# Build script for tmuxai Unraid Plugin
PLUGIN="tmuxai"
VERSION=$(date +"%Y.%m.%d")
SOURCE_DIR="source/$PLUGIN"
OUTPUT_PKG="$PLUGIN.txz"

TMUXAI_VERSION="v2.1.0"
TMUXAI_ARCH="Linux_amd64"
DOWNLOAD_URL="https://github.com/alvinunreal/tmuxai/releases/download/${TMUXAI_VERSION}/tmuxai_${TMUXAI_ARCH}.tar.gz"

echo "Downloading tmuxai binary ${TMUXAI_VERSION}..."
mkdir -p "$SOURCE_DIR/usr/local/bin"
curl -L -f -o tmuxai.tar.gz "${DOWNLOAD_URL}"
tar -xzf tmuxai.tar.gz
mv tmuxai "$SOURCE_DIR/usr/local/bin/tmuxai"
rm tmuxai.tar.gz

# Ensure all files have correct permissions before archiving
chmod -R 755 "$SOURCE_DIR/usr"
chmod +x "$SOURCE_DIR/usr/local/bin/tmuxai"

echo "Creating plugin archive $OUTPUT_PKG..."
cd "$SOURCE_DIR" || exit 1
# Unraid typically uses tar with xz compression
tar -cJf "../../$OUTPUT_PKG" *
cd ../../

# Output MD5 for the .plg file
MD5=$(md5sum "$OUTPUT_PKG" | awk '{print $1}')
echo "Build complete. Output: $OUTPUT_PKG"
echo "MD5: $MD5"
echo "Update tmuxai.plg with this date version and MD5 sum."
