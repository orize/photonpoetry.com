---
name: phopo-ticket-triage
description: Read-only weekly triage for PhoPo GitHub screenshot tickets — open stages, work kinds, stale fixes, regression clusters, similar titles.
---

# PhoPo ticket triage

Use for **queue review and regression pattern detection** — not for implementing fixes.

## Starter message

```
Triage PhoPo tickets. Run ticket-triage.sh and discuss clusters and regressions.
```

## Turn 1

Run **only**:

```bash
.cursor/scripts/ticket-triage.sh
```

Post stdout verbatim, then summarise:

- Open count by stage
- Open count **by kind** (`kind/bug`, `kind/deferred`, `kind/spec`, `kind/feature`, `kind/chore`, product-specific kinds, and unlabeled)
- Stale `ticket/implemented` awaiting verification
- Open `regression` issues
- Similar title clusters (possible duplicates or patterns)

## Allowed

- `.cursor/scripts/ticket-triage.sh` (optional `--days 30`)
- `gh issue list`, `gh issue view` for follow-up
- Suggest `related #NNN` links and `regression` / `kind/*` labels
- Read `.cursor/ticket-state.json` for intake history

## Forbidden

- Implementing product code
- Closing issues without explicit user approval
- Running `ticket-transition.sh` (work chat only)
- Auto-creating issues from `{slug} Screenshots/{slug} Fresh/` (intake is separate)

## Weekly rhythm

~15 minutes: run triage, discuss clusters, park or link regressions, nudge stale `implemented` items toward device verification.
