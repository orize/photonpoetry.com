#!/usr/bin/env bash
set -euo pipefail
export TICKET_PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
export TICKET_WORKFLOW_HOME="${TICKET_WORKFLOW_HOME:-$HOME/dev/ticket-workflow}"
exec "$TICKET_WORKFLOW_HOME/bin/ticket-bot-setup.sh" "$@"
