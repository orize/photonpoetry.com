#!/usr/bin/env bash
# Mac Share Sheet batch intake → one GitHub issue.
# Accepts positional manifest (Shortcuts convention) and maps to --manifest.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="${1:-}"
shift || true
if [[ -z "$MANIFEST" ]]; then
  echo "Usage: intake-share-batch.sh <manifest-path> [--description-file PATH]" >&2
  exit 1
fi
exec "$DIR/ticket-workflow.sh" intake-share-batch --manifest "$MANIFEST" "$@"
