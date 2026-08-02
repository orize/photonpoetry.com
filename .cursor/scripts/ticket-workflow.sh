#!/usr/bin/env bash
set -euo pipefail
export TICKET_PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
export TICKET_WORKFLOW_HOME="${TICKET_WORKFLOW_HOME:-$HOME/dev/ticket-workflow}"
if [[ -x "$TICKET_WORKFLOW_HOME/.venv/bin/python" ]]; then
  PY="$TICKET_WORKFLOW_HOME/.venv/bin/python"
else
  PY=python3
fi
export PYTHONPATH="$TICKET_WORKFLOW_HOME/src${PYTHONPATH:+:$PYTHONPATH}"
exec "$PY" -m ticket_workflow "$@"
