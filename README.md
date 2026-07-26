# Photon Poetry website

Static studio site for [photonpoetry.com](https://photonpoetry.com). No build step.

**Local checkout:** this repository lives at `~/dev/PhotonPoetry` (not inside the Luminous / Photonectar app repo).

## Layout

| Path | Purpose |
|------|---------|
| `site/` | **Published** site — `assets.directory` in `wrangler.jsonc` |
| `Branding/` | Affinity sources and brand exports — committed to GitHub, **not** deployed |
| `.cursor/` | Project rules and skills for agents |

## Pages

| URL | Purpose |
|-----|---------|
| `/` | Studio home — Photon Poetry + product catalog |
| `/luminous/` | Luminous marketing |
| `/luminous/privacy/` | Luminous privacy (App Store) |
| `/luminous/support/` | Luminous support (App Store) |
| `/shimmer/` … | Shimmer marketing / privacy / support |
| `/best-units/` … | Best Units marketing / privacy / support |

Legacy `/privacy` and `/support` redirect to Luminous (see `site/_redirects`).

## Local preview

```bash
cd site
python3 -m http.server 8080
```

Open `http://127.0.0.1:8080/`.

## Deploy to Cloudflare Workers

The site deploys as a Worker serving static assets — not Cloudflare Pages. Config lives in
[`wrangler.jsonc`](wrangler.jsonc) at the repo root, which publishes `./site` and nothing else.

1. Cloudflare Dashboard → **Workers & Pages** → `photonpoetry-com`.
2. Build settings:
   - **Production branch:** `main`
   - **Build command:** *(empty — no build step)*
   - **Non-production deploy command:** `npx wrangler versions upload`
   - **Production deploy command:** `npx wrangler deploy`
3. `versions upload` publishes a preview version and does **not** promote it, so feature-branch
   builds can never change the live site. Only `wrangler deploy` on `main` does.
4. Production deploys from pushes to `main`. **Do not merge to `main` without review.**

DNS and custom domains (`photonpoetry.com`, `www`) stay as configured.

## App Store URL trios

- Luminous: `https://photonpoetry.com/luminous/`, `…/luminous/privacy/`, `…/luminous/support/`
- Shimmer: `https://photonpoetry.com/shimmer/`, …
- Best Units: `https://photonpoetry.com/best-units/`, …
