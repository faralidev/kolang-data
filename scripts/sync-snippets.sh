#!/usr/bin/env bash
#
# sync-snippets.sh — sync kolang-data/snippets.json into
# kolang-vscode/snippets/kolang.json
#
# The canonical file is kolang-data/snippets.json (source of truth for editor
# snippets). Its "snippets" object already uses the VS Code snippet format
# (prefix / body / description), so this script copies it verbatim.
#
# This is the MANUAL local-sync option. The primary mechanism is fetch-at-build:
# kolang-vscode/scripts/fetch-data.js fetches snippets.json from this repo and
# writes it to kolang-vscode/snippets/kolang.json at build time.
#
# Usage:
#   ./scripts/sync-snippets.sh [DEST]
#   (DEST defaults to ../kolang-vscode/snippets/kolang.json)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
DATA_FILE="$ROOT_DIR/snippets.json"
DEST="${1:-$ROOT_DIR/../kolang-vscode/snippets/kolang.json}"

if [ ! -f "$DATA_FILE" ]; then
  echo "error: canonical data file not found: $DATA_FILE" >&2
  exit 1
fi

node -e '
const fs = require("fs");

const file = process.argv[1];
const dest = process.argv[2];

const data = JSON.parse(fs.readFileSync(file, "utf8"));
const out = data.snippets;

fs.writeFileSync(dest, JSON.stringify(out, null, 2) + "\n");
console.log("✓ wrote " + dest + " (" + Object.keys(out).length + " snippets)");
' "$DATA_FILE" "$DEST"