---
name: phopo-ticket-plan
description: Plan-only phase for PhoPo GitHub screenshot tickets — local poll coordinator or manual replay. Never implement or close issues.
---

# PhoPo ticket plan

Use for **Phase 1 planning only**.

**Default:** local poll via **Ticket planner** chat + `@phopo-ticket-plan-coordinator`.

Attach `@phopo-ticket-plan` when planning ready issues (coordinator chat or manual).

## Eligibility (local poll)

Open `ticket/fresh` issue where **age ≥ 1 hour** OR label **`ticket/plan-now`**.

Do not use `ticket/planning` as a queue signal — that means planning is already in progress.

## GitHub attribution (agent)

Use `--as-agent` on transitions; `GH_TOKEN="$PHOPO_GH_TOKEN"` for direct `gh`. Bot setup: `$TICKET_WORKFLOW_HOME/bin/ticket-bot-setup.sh`.

## Turn flow — plan only

For a plan kick, repeat this loop until `scan-plan` shows no ready issues or context is paused:

1. Confirm issue `ready[0]` is eligible (`scan-plan` or manual check).
2. Remove `ticket/plan-now` if present; `.cursor/scripts/ticket-transition.sh --as-agent N planning`
3. `.cursor/scripts/ticket-workflow.sh plan-prompt N` — pass stdout verbatim to **screenshot-planner** Task (`readonly: false`). Do **not** set Task `model` (Auto).
4. On planner success: ensure the plan has `## Kind`, apply exactly one `kind/*` label on the issue (`gh issue edit N --add-label kind/…`), then `.cursor/scripts/ticket-transition.sh --as-agent N ready` — use JSON `planPath` in the comment. If `"refused": true` with kind failures (`missing_kind` / `missing_kind_label` / `multiple_kind_labels`): run **Work-kind triage** below, then retry ready in the same turn — do **not** treat as needs-info. If `"gated": true`, report `ticket/needs-info` / `blocked/` and continue the drain (do not comment a ready path).
5. When not gated: `GH_TOKEN="$PHOPO_GH_TOKEN" gh issue comment N --body "Plan: <planPath>"` (never invent a path by globbing `**/{N}-*.plan.md`)
6. Run `scan-plan` again and continue with the next `ready[0]`.

Stop when the ready queue is empty, when context is paused, or when a step fails. A gated needs-info result is not a drain stop. Do not implement or close issues.

If the planner returns `BLOCKED: …`, the ready transition will gate automatically via plan-check — still run the transition so labels and `blocked/` stay consistent.

When the drain finishes or pauses, run `.cursor/scripts/ticket-workflow.sh ready-work` and post the handoff list. Refine / execute / verify each issue in a separate `Ticket #N` chat (`@phopo-ticket-work`).

## Unplannable tickets

Insufficient evidence → plan with `status: blocked` + `blockedReason`. Gate moves the issue to `ticket/needs-info` and the plan to `.cursor/plans/blocked/`. Do **not** use `ticket/parked` for this (parked is a deliberate product park).

## Work-kind triage (required before ready)

Exactly **one** `kind/` label must be on the issue before transitioning to `ticket/ready`. Plan integrity also requires a `## Kind` section in the plan. Refuse ready without both (unless `--force`).

Missing kind is **not** a `needs-info` / quarantine reason — assign via this table (ensure `## Kind` + label), then retry ready. Soft-refuse JSON (`refused: true`) stays on the current stage so you can fix kind in place.

| Label | Meaning | Typical next move |
|-------|---------|-------------------|
| `kind/bug` | Broken vs already-decided expected behavior | Fix in Ticket #N work chat |
| `kind/deferred` | Non-blocking polish | Park or low priority |
| `kind/spec` | Product decision missing — specify/clarify first | Hand to `/sk-adv` / clarify; no invented defaults |
| `kind/feature` | New capability / roadmap | Park unless owner scopes it |
| `kind/chore` | Tooling, docs/tooltips-only, hygiene | Small work chat or batch |

Products may add extra `kind/*` labels via locale `extra_labels` (e.g. journey-blocker kinds). Keep meta labels (`regression`, `duplicate`, `wontfix`) orthogonal — they may stack with a kind.

After the screenshot-planner Task succeeds and **before** `ticket/ready`:

1. Ensure the plan markdown includes `## Kind` naming exactly one label.
2. Apply that label: `gh issue edit N --add-label "kind/…"`.
3. Only then run the ready transition.

## Thumbnail vs text-only

| Mode | When | Plan section |
|------|------|--------------|
| Screenshot | Local asset in `Tickets/assets/` | `## Problem (from screenshot)` |
| Text-only | No local screenshot (`planMode: text`) | `## Problem (from issue)` |

## Compact plans

Planner Phase 1 plans must stay short: body ~60 lines max, one recommended approach, Problem as one paragraph + bullets, plus `## Kind`.

## Allowed

- `ticket-transition.sh --as-agent`, `ticket-workflow.sh plan-prompt|scan-plan|kick-queue|ready-work|issue`
- `ticket-planner-kick-queue.sh`
- `Task` / screenshot-planner for plan phase only (no `model` override)

## Forbidden

- Implementing product code
- Closing issues
- Reading plan files or full issue bodies in the parent (scripts + Task only)
- `implement-prompt`, transitions to `doing|implemented|verified|close`
- Running screenshot-inbox conveyor scripts
