#!/usr/bin/env bash
# Single-file Share Sheet intake.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/ticket-workflow.sh" intake-share "$@"
