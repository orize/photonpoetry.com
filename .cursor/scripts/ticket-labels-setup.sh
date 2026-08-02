#!/usr/bin/env bash
# Alias for ticket-sync-labels.sh (one-time / sync label setup).
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/ticket-sync-labels.sh" "$@"
