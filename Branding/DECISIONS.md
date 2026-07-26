# Brand ledger

Source of truth for Photon Poetry and product brand growth. Not deployed (lives under `Branding/`).

**You** decide. The **PM agent** (`brand-iterate` skill) owns this ledger, runs experiments, and prompts **one decision at a time**.

## How we work

- **Roles:** Agent = project manager. You = decision maker only (A/B/C, reject, defer, promote?, merge?).
- **Stack priority:** Your instructions, questions, and decisions jump to the top. Agent-queued questions and iterations wait behind your items.
- **One decision per turn:** Never batch prompts. Finish or park the current item before starting the next.
- **Suggestions:** Every prompt includes the agent’s recommended option and one-line why. You may ignore it.
- **Experiments:** Feature branch `brand/<slug>` + PR with 2–3 variants; preview URLs; no merge to `main` without explicit approval.
- **Promote to rules:** After a provisional decision survives **2–3** iterations (or you say freeze earlier), agent asks once to promote → Permanent + propose `.cursor/rules` diff; wait for yes.
- **Spec Kit:** Not used in this marketing repo. Init in product *app* repos when feature behavior needs clarify gates.

### IDs

| Prefix | Meaning |
|--------|---------|
| `Q-NNN` | Open question |
| `E-NNN` | Active experiment |
| `P-NNN` | Provisional decision |
| `D-NNN` | Permanent decision |

---

## Open questions

Queued taste forks. List `Source: user` items first (newest first), then `Source: agent` items.

_(None.)_

---

## Active experiments

In-flight PR work. Status: `awaiting-you` | `applying`.

_(None.)_

### Template

```markdown
### E-NNN — short title

- **Question:** Q-NNN
- **Branch:** brand/<slug>
- **PR:** <url>
- **Options:** A control / B … / C …
- **Recommendation:** <letter> — <one line>
- **Status:** awaiting-you
```

---

## Provisional decisions

Chosen but not frozen. Bump `iterations` when the choice is reaffirmed; at 2–3 ask to promote.

### P-008 — Best Units home catalog blurb

- **Decision:** Studio home Best Units blurb is “Get the conversion you want. One click.”; status remains In development.
- **Why:** User-authored home catalog copy (Q-008).
- **Tried / rejected:** “Convert measurements where you work — more soon.”
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/5

### P-007 — Unlink product pages from home (temporary)

- **Decision:** Studio home does not link to `/luminous/`, `/shimmer/`, or `/best-units/` (header nav removed; catalog cards are non-interactive). Product pages and privacy/support stay published for App Store.
- **Why:** User asked to unlink product pages for now while stubs are not ready as destinations.
- **Tried / rejected:** Linked catalog cards and primary product nav on home.
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/5
- **Note:** Temporary — relink when product pages have real marketing content.

### P-006 — Shimmer home catalog blurb

- **Decision:** Studio home Shimmer blurb is the living-photo-stories paragraph; status remains In development.
- **Why:** User-authored home catalog copy (Q-006).
- **Tried / rejected:** “An iOS app from Photon Poetry — details coming as it takes form.”
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/5

### P-005 — Luminous home catalog blurb

- **Decision:** Studio home Luminous blurb is the atmosphere/lighting paragraph; status remains In development.
- **Why:** User-authored home catalog copy (Q-005).
- **Tried / rejected:** “Turn photos into animated lighting scenes with in-app preview.”
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/5

### P-004 — Display face: Montserrat Light

- **Decision:** Headings use Montserrat Light (`--font-display` / weight 300); Syne retired.
- **Why:** User pick B on E-003 / Q-002 — quieter beside accent “Make beautiful.”
- **Tried / rejected:** A Syne 700 (control); C Montserrat Regular 400.
- **Surface:** shared CSS
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/4

### P-003 — Body face: Figtree

- **Decision:** Site body type is Figtree (`--font-body`); Manrope retired.
- **Why:** User pick B on E-002 / Q-003 — warmer and less default-UI than Manrope.
- **Tried / rejected:** A Manrope (control); C Source Sans 3.
- **Surface:** shared CSS
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/3

### P-002 — Studio voice: Make beautiful

- **Decision:** Studio hero uses accent-colored tagline “Make beautiful” (no full stop) plus a wider craft paragraph (user-authored).
- **Why:** User pick on E-001 / Q-001, then layout tweaks (larger accent tagline; ~50% wider lede).
- **Tried / rejected:** A control two-sentence lede; B shorter single sentence; C studio-framed unfinished products; period after tagline; narrow lede.
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/3
- **Note:** Fixed typo “aesy” → “easy” when applying. Longer than the old “one short supporting line” content rule — revisit that rule if this survives.

### P-001 — Quiet mark stage, no pulsing glow

- **Decision:** Studio-home logo sits on a quiet dark panel; no looping orange glow (entrance rise motion stays).
- **Why:** Glow-heavy AI-landing tropes; the pulse competed with the mark and felt too polished for a provisional studio.
- **Tried / rejected:** Softening glow keyframes further.
- **Surface:** studio home / shared CSS
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** none (shipped before PR-experiment process)

---

## Permanent decisions

Survived the promotion gate and/or already locked in `.cursor/rules`.

### D-001 — Middle way, not Spec Kit for brand

- **Decision:** Grow studio and product brands via this ledger plus thin `site/` slices / PR experiments; do not bootstrap Spec Kit here for brand work.
- **Why:** Spec Kit fits behavioral app features; brand learning is taste and small public experiments.
- **Tried / rejected:** Full specify → clarify → plan → tasks for copy/visual tweaks.
- **Surface:** process
- **Date:** 2026-07-25
- **Rules:** process (this file + `brand-iterate` skill)

### D-002 — Promote rules only when stable

- **Decision:** Cursor rules stay the living locks; new taste decisions stay Provisional until they survive 2–3 iterations (or you freeze earlier), then promote.
- **Why:** Brand is fresh and unformed — freezing every experiment into always-on rules invents a heavy identity too early.
- **Tried / rejected:** Promoting the first slice into `brand.mdc` immediately.
- **Surface:** process
- **Date:** 2026-07-25
- **Rules:** process

### D-003 — Spec Kit deferred to app repos

- **Decision:** Defer Spec Kit to Luminous (or other product) app repositories when real feature behavior needs clarify gates; keep PhotonPoetry as static marketing + Affinity sources.
- **Why:** This repo has no app code, contracts, or testable behavior.
- **Tried / rejected:** `specify init` in PhotonPoetry.
- **Surface:** process
- **Date:** 2026-07-25
- **Rules:** process

### D-004 — Seeded hard locks

- **Decision:** Studio name Photon Poetry; products Luminous, Shimmer, Best Units only; provisional tone; accent `#ffa400`; no fake stats, ship dates, or App Store inventiveness; per-product privacy/support.
- **Why:** Already encoded in `.cursor/rules/brand.mdc` and `content.mdc`.
- **Tried / rejected:** Inventing a brand book or overconfident taglines.
- **Surface:** process / shared
- **Date:** 2026-07-25
- **Rules:** `.cursor/rules/brand.mdc`, `.cursor/rules/content.mdc`

---

## Section templates

### Open question

```markdown
### Q-NNN — short title

- **Source:** user | agent
- **Surface:** studio home / Luminous / …
- **Question:** One sentence.
- **Suggestion:** Optional agent lean.
- **Status:** queued
```

### Provisional

```markdown
### P-NNN — short title

- **Decision:** One sentence.
- **Why:** …
- **Tried / rejected:** …
- **Surface:** …
- **Date:** YYYY-MM-DD
- **Iterations:** N
- **PR:** <url or none>
```

### Permanent

```markdown
### D-NNN — short title

- **Decision:** One sentence.
- **Why:** …
- **Tried / rejected:** …
- **Surface:** …
- **Date:** YYYY-MM-DD
- **Rules:** path or process
```
