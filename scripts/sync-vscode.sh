#!/usr/bin/env bash
#
# sync-vscode.sh — sync kolang-docs.json into kolang-vscode/data/kolang-docs.json
#
# The canonical file is organized as keywords / builtins / types / modules /
# exceptions / verbs / literals. kolang-vscode's extension.js reads
# keywords / functions / types / modules / exceptions / literals / snippets,
# so this script transforms the canonical shape into the vscode shape:
#   functions = builtins + verbs
# Snippets stay out of the canonical file (they are code templates, not
# identifier docs); any snippets already present in the destination file are
# preserved across syncs.
#
# Usage:
#   ./scripts/sync-vscode.sh [DEST]
#   (DEST defaults to ../kolang-vscode/data/kolang-docs.json)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
DATA_FILE="$ROOT_DIR/kolang-docs.json"
DEST="${1:-$ROOT_DIR/../kolang-vscode/data/kolang-docs.json}"

if [ ! -f "$DATA_FILE" ]; then
  echo "error: canonical data file not found: $DATA_FILE" >&2
  exit 1
fi

node -e '
const fs = require("fs");

const file = process.argv[1];
const dest = process.argv[2];

const data = JSON.parse(fs.readFileSync(file, "utf8"));

let existing = {};
try {
  existing = JSON.parse(fs.readFileSync(dest, "utf8"));
} catch (_) {
  // destination does not exist yet — start with empty snippets
}

const out = {
  _comment: "Kolang language data for the VS Code extension — synced from kolang-data/kolang-docs.json (canonical source of truth) by scripts/sync-vscode.sh.",
  _version: data._version || "0.0.1",
  keywords: data.keywords || [],
  functions: (data.builtins || []).concat(data.verbs || []),
  types: data.types || [],
  modules: data.modules || [],
  exceptions: data.exceptions || [],
  literals: data.literals || [],
  snippets: existing.snippets || [],
};

fs.writeFileSync(dest, JSON.stringify(out, null, 2) + "\n");
console.log("✓ wrote " + dest);
' "$DATA_FILE" "$DEST"