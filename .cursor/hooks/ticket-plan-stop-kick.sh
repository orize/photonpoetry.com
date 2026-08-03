#!/usr/bin/env bash
# After ticket planner turns complete, auto-submit plan kick when kick-pending is set.
# Requires ticket-plan-session-active marker (written on turn-1 startup).
# Copy into each consumer’s `.cursor/hooks/` and point `.cursor/hooks.json` at it.
set -euo pipefail
export TICKET_PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
export TICKET_WORKFLOW_HOME="${TICKET_WORKFLOW_HOME:-$HOME/dev/ticket-workflow}"
export PYTHONPATH="$TICKET_WORKFLOW_HOME/src${PYTHONPATH:+:$PYTHONPATH}"
PY="$TICKET_WORKFLOW_HOME/.venv/bin/python"
[[ -x "$PY" ]] || PY=python3
HOOK_INPUT="$(cat)"
export HOOK_INPUT
exec "$PY" -c '
import json, os
from ticket_workflow.plan.plan_pipeline import process_ticket_plan_stop_kick
raw = (os.environ.get("HOOK_INPUT") or "").strip()
try:
    hook_input = json.loads(raw) if raw else {}
except json.JSONDecodeError:
    print("{}")
    raise SystemExit(0)
status = hook_input.get("status", "") if isinstance(hook_input, dict) else ""
result = process_ticket_plan_stop_kick(status, hook_input if isinstance(hook_input, dict) else {})
print(json.dumps(result) if result else "{}")
'
