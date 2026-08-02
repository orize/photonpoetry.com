# Brand ledger

Source of truth for Photon Poetry and product brand growth. Not deployed (lives under `Branding/`).

**You** decide. The **PM agent** (`brand-iterate` skill) owns this ledger, runs experiments, and prompts **one decision at a time**.

## How we work

- **Roles:** Agent = project manager. You = decision maker only (A/B/C, reject, defer, promote?, merge?).
- **Stack priority:** Your instructions, questions, and decisions jump to the top. Agent-queued questions and iterations wait behind your items.
- **One decision per turn:** Never batch prompts. Finish or park the current item before starting the next.
- **Suggestions:** Every prompt includes the agent’s recommended option and one-line why. You may ignore it.
- **Experiments:** Feature branch `brand-<slug>` (hyphens, no `/` — see [`branches.mdc`](../.cursor/rules/branches.mdc)) + PR with 2–3 variants; preview URLs; no merge to `main` without explicit approval.
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

### Q-019 — Logo plate size on home

- **Source:** agent
- **Surface:** studio home
- **Question:** Should the squircle logo plate stay at the current clamp size, go slightly smaller, or slightly larger in the first viewport?
- **Suggestion:** Prefer A — current size already reads as the brand hero beside the H1.
- **Status:** in-experiment

---

## Active experiments

In-flight PR work. Status: `awaiting-you` | `applying`.

### E-019 — Logo plate size

- **Question:** Q-019
- **Branch:** brand-home-logo-size
- **PR:** https://github.com/orize/photonpoetry.com/pull/20
- **Options:** A current clamp (control) / B slightly smaller / C slightly larger
- **Recommendation:** A — plate already carries brand weight with the large H1
- **Status:** awaiting-you

### Template

```markdown
### E-NNN — short title

- **Question:** Q-NNN
- **Branch:** brand-<slug>
- **PR:** <url>
- **Options:** A control / B … / C …
- **Recommendation:** <letter> — <one line>
- **Status:** awaiting-you
```

---

## Provisional decisions

Chosen but not frozen. Bump `iterations` when the choice is reaffirmed; at 2–3 ask to promote.

### P-018 — Footer: rule-only, no elevated fill

- **Decision:** Site footer keeps the thin top rule and muted copyright/email row; background is transparent (no elevated fill bar).
- **Why:** User pick C on E-018 / Q-018.
- **Tried / rejected:** A elevated bar + rule (control); B quieter soft type with no rule.
- **Surface:** studio home / shared footer
- **Date:** 2026-08-02
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/19
- **Resolves:** Q-018

### P-017 — Studio lede: light and delight couplet

- **Decision:** Studio home lede is “Well-considered software to help you make beautiful things. Light and delight, motion and emotion.”
- **Why:** User-authored home lede (Q-017 / E-017).
- **Tried / rejected:** A long craft paragraph (control); B half (drop second sentence); C single short line (“Well-considered software…” alone).
- **Surface:** studio home
- **Date:** 2026-08-02
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/18
- **Resolves:** Q-017
- **Supersedes:** Long craft paragraph portion of P-002

### P-016 — Catalog status: lighter than soft

- **Decision:** Studio home “In development” stays under the product name, lighter than E-016 C — smaller (0.625rem), weight 400, and washed toward the page field via `color-mix` with `--bg` (not accent).
- **Why:** User asked to go lighter than C on E-016 / Q-016.
- **Tried / rejected:** A accent uppercase under name (control); B inline beside name; C muted smaller status.
- **Surface:** studio home
- **Date:** 2026-08-01
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/17
- **Resolves:** Q-016

### P-015 — Hero keeps large H1 with logo plate

- **Decision:** Studio home keeps the large “Photon Poetry” H1 beside the squircle logo plate (control).
- **Why:** User pick A on E-015 / Q-015 — brand wordmark stays hero-level with the plate.
- **Tried / rejected:** B shrink H1; C plate-only with visually hidden H1.
- **Surface:** studio home
- **Date:** 2026-08-01
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/16
- **Resolves:** Q-015

### P-014 — Tagline accent: keep current weight

- **Decision:** Studio home “Make beautiful” keeps current accent color (`--accent`) and size (`clamp(2rem, 6.5vw, 2.85rem)`).
- **Why:** User pick A on E-014 / Q-014 — current weight still reads right on the stone wash.
- **Tried / rejected:** B softer/muted mix; C brighter (`--accent-bright`) + slightly larger.
- **Surface:** studio home
- **Date:** 2026-07-30
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/15
- **Resolves:** Q-014

### P-013 — Studio header: blurred bar, flush inner

- **Decision:** Site header keeps the light blurred bar and bottom rule (control); `.site-header__inner` is full-width with no auto margin (header padding alone insets).
- **Why:** User pick A on E-013 / Q-013, plus strip margin from `site-header__inner`.
- **Tried / rejected:** B quieter no blur/rule; C bare brand link; constrained/centered header inner sharing page margins.
- **Surface:** studio home / shared header
- **Date:** 2026-07-29
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/14
- **Resolves:** Q-013

### P-012 — Page atmosphere: larger neutral stone wash

- **Decision:** Site page field is a larger neutral stone wash (shared `--bg` / body gradients), not cool blue-gray; accent soft radial stays, plus a second corner wash for scale.
- **Why:** User pick C on E-012 / Q-011, with bigger wash and more neutral (less warm/beige) stone.
- **Tried / rejected:** A cool blue-gray wash (control); B quieter flat field; C preview’s warmer beige-leaning stone.
- **Surface:** studio home / shared CSS
- **Date:** 2026-07-29
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/13
- **Resolves:** Q-011

### P-011 — Hero mark plate: iOS squircle

- **Decision:** Studio home quiet dark logo plate keeps the inset stage and reverse mark; corners use `border-radius` plus `corner-shape: squircle` (iOS-like). Unsupported browsers fall back to the prior rounded rect.
- **Why:** User answered Q-010 — emulate iOS squircle via `corner-shape: squircle`.
- **Tried / rejected:** Full-bleed dark band; drop plate for standard mark on light field; circular-arc rounded rect alone.
- **Surface:** studio home
- **Date:** 2026-07-29
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/12
- **Resolves:** Q-010

### P-010 — Best Units home catalog blurb (two-line)

- **Decision:** Studio home Best Units blurb is “Get the conversion you need. One click. / Copy it or replace it? Another click.”; status remains In development.
- **Why:** User-authored home catalog copy (Q-012).
- **Tried / rejected:** “Get the conversion you want. One click.” (P-008); “Convert measurements where you work — more soon.”
- **Surface:** studio home
- **Date:** 2026-07-27
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/11
- **Supersedes:** P-008

### P-009 — Studio home catalog: open stack

- **Decision:** Studio home catalog is an open stack — no column rules or border chrome; gutters ~50% wider than the B preview (mobile `2.625rem`, desktop column `3.75rem`).
- **Why:** User pick B on E-009 / Q-009, with wider gutters for breath.
- **Tried / rejected:** A rule-separated columns (control); C compact strip (name+status inline).
- **Surface:** studio home
- **Date:** 2026-07-27
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/10

### P-008 — Best Units home catalog blurb

- **Decision:** Studio home Best Units blurb is “Get the conversion you want. One click.”; status remains In development.
- **Why:** User-authored home catalog copy (Q-008).
- **Tried / rejected:** “Convert measurements where you work — more soon.”
- **Surface:** studio home
- **Date:** 2026-07-25
- **Iterations:** 1
- **PR:** https://github.com/orize/photonpoetry.com/pull/5
- **Note:** Superseded by P-010.

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

### D-005 — Reverse logo on dark backgrounds

- **Decision:** If a logo sits on a dark background, always use the reverse mark — `site/assets/logo-reverse.svg`, exported from `Branding/PP_logo-01-reverse.svg`. On light backgrounds, use the standard mark `site/assets/logo.svg`. Never mix the two.
- **Why:** User hard lock (“always, always”). The studio home quiet dark panel (P-001) was serving the standard `logo.svg` and was **not** compliant; it now points at `logo-reverse.svg`.
- **Tried / rejected:** Treating `site/assets/logo.svg` as the reverse mark — it is not.
- **Surface:** shared / logo assets
- **Date:** 2026-07-26
- **Rules:** `.cursor/rules/brand.mdc` (also noted in `brand-site` / `brand-iterate`)

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
