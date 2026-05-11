#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "datetime_fix.sh is not applicable on macOS" >&2
    exit 0
fi

sudo apt install qml6-module-qtlocation qt6-location-plugins
