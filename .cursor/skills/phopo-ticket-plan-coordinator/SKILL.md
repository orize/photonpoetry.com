---
name: phopo-ticket-plan-coordinator
description: Local poll coordinator for PhoPo ticket planning — one standing chat, timer-driven, no cloud agent.
---

# PhoPo ticket planner (local coordinator)

Use in a **standing Agent chat** titled **Ticket planner**, on **Auto**. Poll-only — no webhook, no intake wake.

Attach `@phopo-ticket-plan-coordinator` and `@phopo-ticket-plan`.

## Turn 1

Run **only** (request full permissions — startup writes session markers):

```bash
.cursor/scripts/ticket-planner-startup.sh
```

Post stdout **verbatim**. Summarise: ready count, deferred count, whether the poll watcher is armed, whether a plan kick is pending, whether context is paused.

**Do not** spawn screenshot-planner on turn 1 when this is a fresh startup. The stop hook submits the first plan kick after this turn completes (when issues are ready).

## Fallback drain (hook silent)

If this message is **not** a `Plan kick (drain): …` follow-up, and a prior startup left `kickPending: true` / ready issues remain (user re-ran “run the ticket planner”, said continue/drain, or no Plan kick arrived): **drain now** using the loop below. Do **not** re-run startup-only and wait for the stop hook again.

## On each plan kick (auto follow-up)

Stop hook message: `Plan kick (drain): plan all ready tickets starting with #N …`

Loop until `ready` is empty or `contextPaused` is true:

1. Run `.cursor/scripts/ticket-workflow.sh scan-plan`
2. Plan issue `ready[0]` (poll prioritises `ticket/plan-now`, then oldest)
3. Before each issue:
   - Remove `ticket/plan-now` if present: `GH_TOKEN="$PHOPO_GH_TOKEN" gh issue edit N --remove-label ticket/plan-now`
   - `.cursor/scripts/ticket-transition.sh --as-agent N planning`
4. `.cursor/scripts/ticket-workflow.sh plan-prompt N` → pass stdout verbatim to **screenshot-planner** Task — do **not** set Task `model` (Auto)
5. On success: `.cursor/scripts/ticket-transition.sh --as-agent N ready` — read the JSON stdout. If `"gated": true`, the issue is now `ticket/needs-info` (plan under `blocked/`); report that and continue the drain — do **not** comment a ready plan path. If `"planPath"` is present, use that path in the comment.
6. When not gated: `GH_TOKEN="$PHOPO_GH_TOKEN" gh issue comment N --body "Plan: <planPath from transition JSON>"`
7. Repeat from step 1

Stop when the queue is empty, when `contextPaused` is true, or when a transition/planner step fails. A gated needs-info result is **not** a drain stop — continue with the next ready issue.

Startup / poll JSON may include `planAudit`. If `quarantined` or `problems` is non-zero, add a short **footnote** after the ready/deferred/kick summary — paste `suggestedFixes` (cap at a few lines if long). Do **not** frame the turn as failed. Audit isolation is **not** a drain stop; continue planning. **Do not** remediate audit in Ticket planner (no Read/edit of plan files, no kind assignment). Trust the JSON; fix audit in a separate chat. Details: `ticket-workflow.sh plan-audit`.

**Handoff (required when the drain finishes or pauses):**

```bash
.cursor/scripts/ticket-workflow.sh ready-work
```

Refine / implement / verify happen in **Ticket #N** chats with `@phopo-ticket-work` — **not** in Ticket planner. Issues in `ticket/needs-info` are omitted from ready-work until fixed and re-promoted.

## Lean parent

- Scripts + Task only — do **not** Read plan files, ticket-state, or full issue bodies
- Do not set Task `model`
- One Task per issue; drain ready issues in the parent turn

## Context pause (≥ 66%)

When startup or kicks report `contextPaused`, stop planning. Run:

```bash
.cursor/scripts/ticket-planner-rollover.sh
```

Archive this chat, open a fresh **Ticket planner** chat on Auto, paste `starterMessage`, run turn 1.

## Eligibility (poll rules)

| Condition | Plan? |
|-----------|-------|
| `ticket/fresh` + age ≥ 1h | Yes |
| `ticket/fresh` + `ticket/plan-now` | Yes (skip wait) |
| `ticket/fresh` + age < 1h, no `ticket/plan-now` | Deferred |

## Bump an issue

Add label on GitHub: `ticket/plan-now`. Force queue:

```bash
.cursor/scripts/ticket-planner-kick-queue.sh
```

## Allowed

- `ticket-planner-startup.sh`, `ticket-planner-rollover.sh`, `ticket-planner-kick-queue.sh`, `watch-plan.sh`, `ticket-workflow.sh scan-plan|plan-prompt|kick-queue|ready-work`, `ticket-transition.sh --as-agent`
- `Task` / screenshot-planner (no `model`)
- `gh` with bot token

## Forbidden

- Implementing product code
- Closing issues
- Reading plan / state files in the parent
- Remediating `planAudit` / assigning `kind/*` in this chat
- Setting Task `model`

## Hooks

`.cursor/hooks/ticket-plan-stop-kick.sh` — queue-draining plan kicks when kick-pending exists and session is active. Canonical copy: `$TICKET_WORKFLOW_HOME/hooks/ticket-plan-stop-kick.sh`.
