---
name: phopo-ticket-work
description: Refine, implement, and verify a single PhoPo GitHub screenshot ticket. One issue per chat. Auto-planning happens in Ticket planner — not here.
---

# PhoPo ticket work

Use **one Agent chat per GitHub issue**. Attach this skill in chats titled `Ticket #NNN …`.

Auto-planning runs in the standing **Ticket planner** chat. This chat is for **refine → implement → verify → close** on **one** issue only.

## Starter message (default — already planned)

```
Work PhoPo ticket #NNN. It should already be ticket/ready.
Refine the plan in .cursor/plans/ready/ if needed, then wait for implement.
Do not plan other tickets. Do not re-run the Ticket planner drain.
```

Replace `NNN` with the issue number. List ready starters with:

```bash
.cursor/scripts/ticket-workflow.sh ready-work
```

## Starter message (manual plan — rare)

Only when automation did **not** produce a plan and the issue is still `ticket/fresh`:

```
Work PhoPo ticket #NNN. Plan this issue only — do not implement until I say implement.
Do not plan other tickets.
```

## Commands

| Command | Action |
|---------|--------|
| `refine` | Edit `.cursor/plans/ready/<N>-<slug>.plan.md` (stay on `ticket/ready`); update the issue plan comment if the summary changed |
| `plan` | Manual only: transition to `ticket/planning`, write plan, transition to `ticket/ready` |
| `approve` / `implement` | Transition to `ticket/doing`, implement plan |
| `park` | Transition to `ticket/parked` (deliberate product deferral) |
| `unpark` | Transition to `ticket/ready` (plan-check must pass, or use `--force`) |
| `needs-info` | Plan integrity gate outcome — insufficient/malformed plan; plan under `.cursor/plans/blocked/`. Fix evidence or plan, then transition to `ready` again. Not the same as `parked`. |
| `implemented` | Transition to `ticket/implemented` after a **clean commit** (or PR) — issue stays open until verified |
| `verified` / `verified iphone` / `verified mac` | **Device QA passed.** Do **not** only acknowledge. Immediately run **Endgame** (commit this ticket’s remaining work + #NNN Cursor artifacts → `ticket/verified` → close). Platform words are optional notes. |
| `close` | Close issue (only when verified, duplicate, or wontfix) — after verify, agent runs this as part of Endgame |
| `related #258` | Add `regression` label and note link in issue comment |

Open the plan from the **issue plan comment** or **`ticket-state` slug** — do **not** glob `**/{N}-*.plan.md` (legacy plan prefixes may reuse digits).

## GitHub attribution (agent)

Agent transitions and issue comments must show as the project bot, not your personal account.

Ensure `.cursor/ticket-bot.env` exists (`TICKET_PROJECT_ROOT=<project> $TICKET_WORKFLOW_HOME/bin/ticket-bot-setup.sh`). `--as-agent` loads it automatically.

```bash
.cursor/scripts/ticket-transition.sh --as-agent NNN doing
```

```bash
source .cursor/ticket-bot.env 2>/dev/null || true
GH_TOKEN="$PHOPO_GH_TOKEN" gh issue comment NNN --body "Plan: .cursor/plans/ready/<N>-<slug>.plan.md"
```

**Do not** use the bot token for shortcut intake or `create`.

## Work-kind branching (before implement)

Read the issue’s `kind/` label (and the plan’s `## Kind`). Branch:

| Kind | On `implement` / `approve` |
|------|----------------------------|
| `kind/bug` | Normal implement path |
| `kind/chore` | Normal implement; keep scoped |
| `kind/deferred` | Prefer `park` unless the owner explicitly overrides |
| `kind/feature` | Prefer `park`; do not implement unless the owner opens a feature slice |
| `kind/spec` | **Stop** — do not implement. Point the owner at clarify / `/sk-adv`. Stay on `ticket/ready` or `park` |

Product-specific `kind/*` labels (from locale `extra_labels`) follow that product’s skill addendum when present; otherwise treat journey-blocker kinds like `kind/bug` and park unknown kinds pending owner input.

If no `kind/` label is present, assign one via the plan skill’s Work-kind triage table (with owner confirmation if ambiguous) before implementing — missing kind is not `needs-info`.

## Turn flow — load → refine → implement → verify

1. Load this issue only (`ticket-workflow.sh issue NNN`) and open the plan from the plan comment or `ticket-state` slug.
2. If the user says **`refine`**: edit that plan file; stay on `ticket/ready`; do not implement until they say `implement`.
3. On **`implement`** / **`approve`**:
   - Branch on work-kind (see above) before coding
   - `.cursor/scripts/ticket-transition.sh --as-agent NNN doing`
   - `.cursor/scripts/ticket-workflow.sh implement-prompt NNN` — resume `screenshot-planner` or implement in chat
   - On success: make a **clean, scoped commit** (or open a PR), then `.cursor/scripts/ticket-transition.sh --as-agent NNN implemented`
4. When the user says **`verified`**, **`verified iphone`**, or **`verified mac`**: run **Endgame** in the same turn — do not wait for a separate `close` message.

## Endgame

Triggered by any user verify command (`verified` / `verified iphone` / `verified mac`). Commit checkpoints: (1) before `ticket/implemented`, (2) product follow-ons after device verify, (3) this ticket’s Cursor artifacts after close. Run all Endgame steps now — do not reply with only “good” / “confirmed”.

1. **Before `ticket/implemented`:** always leave a **clean, scoped commit** (or PR) for this ticket’s product changes under Allowed paths. If this ticket’s live plan was refined and is trackable, you may include it in that commit (or a follow-up). Never stage other issues’ files, unrelated WIP, or secrets.
2. **After the user verifies on device** — in this chat, in order:
   1. **Commit remaining product work for this ticket only** — run `git status`. If there are uncommitted changes that belong to **this** issue’s follow-on fix/refinement (product code under Allowed paths), make a clean scoped commit (same bar as implement). Do **not** stage other tickets’ files, unrelated WIP, or secrets. Other tickets’ dirt may remain; that must not block Endgame.
   2. **Verify** — transition to `ticket/verified`.
   3. **Close** — close the issue. Verified tickets must not stay open. Close relocates the plan (typically to `.cursor/plans/complete/`) and prints JSON with `planPath` when present.
   4. **Commit #NNN Cursor artifacts** — stage and commit (same commit as remaining product work when both are pending, otherwise a small follow-up):
      - Close JSON `planPath` when present (required).
      - Any other path under `.cursor/` whose **basename** starts with `NNN-` for this issue.
      - Use `git add <path>`; if `git check-ignore` still reports ignored (consumer repos that ignore plans), use `git add -f <path>`.
      - **Never** stage: `ticket-bot.env`, `ticket-state.json`, `.cursor/tmp/`, `screenshot-thumbnails/`, `ticket-plan-*.json`, other issues’ plans, or secrets.

```bash
.cursor/scripts/ticket-transition.sh --as-agent NNN verified
.cursor/scripts/ticket-workflow.sh close --as-agent NNN
```

## Verify gate

- Never close unless `ticket/verified` is set or user explicitly rejects (`duplicate` / `wontfix`)
- Bare **`verified`** counts the same as **`verified iphone`** / **`verified mac`**
- After a successful device verify command from the user, the **agent** must run full Endgame in that turn (commit this ticket’s remaining product work → verified → close → commit #NNN Cursor artifacts)
- PR bodies: `Relates to #NNN` during work; `Fixes #NNN` only after verification

## Allowed

- `ticket-transition.sh`, `ticket-workflow.sh` (`plan-prompt` / `implement-prompt` / `issue` / `ready-work`)
- `Task` / `screenshot-planner` for plan (rare) and implement
- Product code under: site/, Branding/
- `.cursor/plans/` paths for **this** issue only, plus other `.cursor/` files whose basename starts with `NNN-` for this issue
- `gh issue comment` with bot token

## Forbidden

- Closing without verification
- Processing **any** other issue number in this chat
- Running Ticket planner drain scripts from a work chat
- Running retired screenshot-inbox conveyor scripts
