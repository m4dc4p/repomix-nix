#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nodejs_18 nodePackages.node2nix
set -euo pipefail

# Ensure we're in the right directory
cd "$(dirname "$0")"

# Update the version in package.json to match the latest available
LATEST_VERSION=$(npm view repomix version)
sed -i.bak "s/\"version\": \".*\"/\"version\": \"$LATEST_VERSION\"/" package.json
rm -f package.json.bak

# Run node2nix to generate the Nix expressions
echo "Generating Nix expressions for repomix version $LATEST_VERSION"
node2nix --nodejs-18 -i package.json

# Update the dependency in package.json to match the version we just found
sed -i.bak "s/\"repomix\": \"latest\"/\"repomix\": \"$LATEST_VERSION\"/" package.json
rm -f package.json.bak

echo "Done! Files have been regenerated for repomix $LATEST_VERSION"
echo "You can now build the package with: nix-build"
