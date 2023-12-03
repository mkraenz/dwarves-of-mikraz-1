#!/usr/bin/env bash
set -euxo pipefail

## Assumption: you have godot and itchio-butler set up via PATH or as alias.

source ./scripts/shell-setup.sh

# dev or prod
ENVIRONMENT="${1:-dev}"

# test
gut

# build
rm -r .build && mkdir .build
godot --export-release Web .build/index.html

# deploy
if [ ENVIRONMENT = "prod" ]; then
    echo "Env: prod"
    butler push .build mkraenz/mikraz-blacksmith:web --userversion $(jq .version package.json)
    echo 'Deployed successfully. Check itch.io at https://mkraenz.itch.io/mikraz-blacksmith'
else
    echo "Env: dev"
    butler push .build mkraenz/dwarves-of-mikraz:web --userversion $(jq .version package.json)
    echo 'Deployed successfully. Check itch.io at https://mkraenz.itch.io/dwarves-of-mikraz'
fi
