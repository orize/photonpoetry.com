#!/usr/bin/env bash
# Poll GitHub for ticket/fresh issues eligible for local planning.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export TICKET_PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
export TICKET_WORKFLOW_HOME="${TICKET_WORKFLOW_HOME:-$HOME/dev/ticket-workflow}"
export PYTHONPATH="$TICKET_WORKFLOW_HOME/src${PYTHONPATH:+:$PYTHONPATH}"
cd "$TICKET_PROJECT_ROOT"
PY="$TICKET_WORKFLOW_HOME/.venv/bin/python"
[[ -x "$PY" ]] || PY=python3

case "${1:-}" in
  --loop)
    while true; do
      "$PY" -m ticket_workflow schedule-plan-kick || true
      sleep 600
    done
    ;;
  --arm)
    if pgrep -fl "best_units/.cursor/scripts/watch-plan.sh --loop" >/dev/null 2>&1; then
      echo "best_units plan watcher already running"
      exit 0
    fi
    nohup bash "$SCRIPT_DIR/watch-plan.sh" --loop >/dev/null 2>&1 &
    echo "best_units plan watcher armed"
    ;;
  *)
    exec "$PY" -m ticket_workflow scan-plan
    ;;
esac
