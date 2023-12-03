#!/usr/bin/env bash

## Assumption: you have godot and itchio-butler set up via PATH or as alias.

set -euxo pipefail

rm -r .build && mkdir .build
godot --export-release Web .build/index.html
butler push .build mkraenz/dwarves-of-mikraz:web

echo 'Deployed successfully. Check itch.io at https://mkraenz.itch.io/dwarves-of-mikraz'
