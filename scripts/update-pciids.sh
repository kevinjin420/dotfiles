#!/bin/bash

# this script updates the hardware database so things like your gpu is recognized properly

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "update-pciids is not applicable on macOS" >&2
    exit 0
fi

sudo update-pciids
