#!/bin/bash
set -e

GODOT_VERSION=$1

# Unit test path
if [ -z "$2" ]
then
  UNIT_TEST_PATH="res://tests/unit"
else
  UNIT_TEST_PATH=$2
fi

# Integration test path
if [ -z "$3" ]
then
  INTEGRATION_TEST_PATH=""
else
  INTEGRATION_TEST_PATH="-gdir=$3"
fi

# Download Godot
wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip

# Unzip it
unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
mv Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot

#
# Launch the tests
#

rm -f test-out.xml
yes q | /usr/local/bin/godot -s res://addons/gut/gut_cmdln.gd -d -gjunit_xml_file=test-out.xml
