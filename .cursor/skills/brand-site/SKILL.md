---
name: brand-site
description: Edit the Photon Poetry marketing site under site/. Use when changing pages, CSS, redirects, deploy notes, or product URL trios.
---

# Brand site

## Layout

- Repo: `orize/photonpoetry.com` checked out as PhotonPoetry.
- **`site/`** — published HTML/CSS/assets + `_redirects`
- **`Branding/`** — Affinity sources (not deployed) + [`DECISIONS.md`](../../../Branding/DECISIONS.md) brand ledger
- Products: Luminous, Shimmer, Best Units

## Taste forks vs mechanical edits

- **Taste / brand question** (copy tone, atmosphere, mark treatment, catalog framing): do **not** pick a single answer yourself. Follow the [`brand-iterate`](../brand-iterate/SKILL.md) skill — ledger, one decision prompt, PR experiment when needed.
- **Mechanical** (broken links, path typos, redirects, ASC URL wiring, export assets): fix directly here; no experiment unless it changes brand voice/look.

## Brand growth

- Ledger: `Branding/DECISIONS.md` (Open questions / Active experiments / Provisional / Permanent).
- PM agent: `brand-iterate`. User only decides.
- Promote Provisional → Permanent / `.cursor/rules` only after 2–3 iterations (or user freezes) via `brand-iterate`.
- Do not init Spec Kit in this repo for brand work.

## Preview

```bash
cd site && python3 -m http.server 8080
```

## Deploy

- Cloudflare Workers static assets: root `wrangler.jsonc`, `assets.directory` = **`./site`**
- Production branch: `main` (`npx wrangler deploy`); other branches upload preview versions only
- **Never merge/push to `main` without explicit user approval**

## Editing tips

- Nested pages use `../assets/` or `../../assets/` for CSS/favicon.
- Per-product privacy/support; legacy `/privacy` → `/luminous/privacy/`.
- Export new marks into `site/assets/`; do not link `.af` files.
