#!/bin/bash
set -e

GODOT_VERSION=$1
IMPORT_SCENE="$2"
IMPORT_TIME=$3
TEST_TIMEOUT=$4


# Download Godot
wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip

# Unzip it
unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
mv Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot

#
# Import assets
#

echo "Importing assets for $IMPORT_TIME seconds..."
timeout $IMPORT_TIME /usr/local/bin/godot --editor "$IMPORT_SCENE" || true

#
# Launch the tests
#

echo "Running tests (timeout at $TEST_TIMEOUT seconds)..."
rm -f test-out.xml
yes q | timeout $TEST_TIMEOUT /usr/local/bin/godot -s res://addons/gut/gut_cmdln.gd -d -gjunit_xml_file=test-out.xml
