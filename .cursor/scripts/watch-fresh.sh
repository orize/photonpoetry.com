#!/usr/bin/env bash
# Watch the project Fresh directory (and iCloud Fresh if configured) for new tickets.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export TICKET_PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
export TICKET_WORKFLOW_HOME="${TICKET_WORKFLOW_HOME:-$HOME/dev/ticket-workflow}"
export PYTHONPATH="$TICKET_WORKFLOW_HOME/src${PYTHONPATH:+:$PYTHONPATH}"
cd "$TICKET_PROJECT_ROOT"
PY="$TICKET_WORKFLOW_HOME/.venv/bin/python"
[[ -x "$PY" ]] || PY=python3
CLI=("$PY" -m ticket_workflow)

scan() { "${CLI[@]}" scan-fresh; }

fresh_dirs() {
  "$PY" -c "
from ticket_workflow.intake.config import fresh_intake_dirs
for _label, path in fresh_intake_dirs(ensure=True):
    print(path)
"
}

case "${1:-}" in
  --loop)
    while true; do
      while IFS= read -r dir; do
        [[ -n "$dir" ]] || continue
        mkdir -p "$dir"
        fswatch -1 -r -e ".*" -i "\\.png$" -i "\\.heic$" -i "\\.jpe?g$" "$dir" 2>/dev/null || true
      done < <(fresh_dirs)
      scan || true
      sleep 1
    done
    ;;
  --arm)
    if pgrep -fl "Photonectar/.cursor/scripts/watch-fresh.sh --loop" >/dev/null 2>&1; then
      echo "Photonectar fresh watcher already running"
      exit 0
    fi
    nohup bash "$SCRIPT_DIR/watch-fresh.sh" --loop >/dev/null 2>&1 &
    echo "Photonectar fresh watcher armed"
    ;;
  *)
    scan
    ;;
esac
