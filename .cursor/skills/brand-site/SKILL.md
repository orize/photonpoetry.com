---
name: brand-site
description: Edit the Photon Poetry marketing site under site/. Use when changing pages, CSS, redirects, deploy notes, or product URL trios.
---

# Brand site

## Layout

- Repo: `orize/photonpoetry.com` checked out as PhotonPoetry.
- **`site/`** — published HTML/CSS/assets + `_redirects`
- **`Branding/`** — Affinity sources (not deployed)
- Products: Luminous, Shimmer, Best Units

## Preview

```bash
cd site && python3 -m http.server 8080
```

## Deploy

- Cloudflare Pages root directory: **`site`**
- Production branch: `main`
- **Never merge/push to `main` without explicit user approval**

## Editing tips

- Nested pages use `../assets/` or `../../assets/` for CSS/favicon.
- Per-product privacy/support; legacy `/privacy` → `/luminous/privacy/`.
- Export new marks into `site/assets/`; do not link `.af` files.
