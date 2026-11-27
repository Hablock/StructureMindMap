#!/usr/bin/env bash
# Prepare a release: sets the version in index.html and the plugin manifest,
# and copies index.html into the plugin's skill folder.
# Usage: ./scripts/release.sh 2.8.1
set -euo pipefail

if [ $# -ne 1 ] || ! [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Usage: $0 X.Y.Z" >&2
  exit 1
fi
VERSION="$1"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP="$ROOT/index.html"
PLUGIN_JSON="$ROOT/plugins/structuremindmap/.claude-plugin/plugin.json"
BUNDLED="$ROOT/plugins/structuremindmap/skills/structuremindmap/app/index.html"

# Version in the app
perl -0pi -e 's/(<meta name="structuremindmap-version" content=")[^"]*(")/${1}'"$VERSION"'${2}/' "$APP"
grep -q "structuremindmap-version\" content=\"$VERSION\"" "$APP" || { echo "Version meta tag not found in index.html" >&2; exit 1; }

# Version in the plugin manifest (users only get an update when this changes)
perl -0pi -e 's/("version":\s*")[^"]*(")/${1}'"$VERSION"'${2}/' "$PLUGIN_JSON"

# Bundled copy for the plugin
cp "$APP" "$BUNDLED"

echo "Release $VERSION prepared. Commit and push:"
echo "  git add -A && git commit -m \"StructureMindMap v$VERSION\" && git push"
