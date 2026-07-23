# Photon Poetry website

Static studio site for [photonpoetry.com](https://photonpoetry.com). No build step.

**Local checkout:** this repository lives at `~/dev/PhotonPoetry` (not inside the Luminous / Photonectar app repo).

## Layout

| Path | Purpose |
|------|---------|
| `site/` | **Published** site — Cloudflare Pages root directory |
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

## Deploy to Cloudflare Pages

1. Cloudflare Dashboard → **Workers & Pages** → project for `orize/photonpoetry.com`.
2. Build settings:
   - **Production branch:** `main`
   - **Framework preset:** None
   - **Build command:** *(empty)*
   - **Root directory:** `site` ← **required** after this layout change
   - **Build output directory:** `/` (or leave default for static)
3. Production deploys from pushes to `main`. **Do not merge to `main` without review.**

DNS and custom domains (`photonpoetry.com`, `www`) stay as configured.

## App Store URL trios

- Luminous: `https://photonpoetry.com/luminous/`, `…/luminous/privacy/`, `…/luminous/support/`
- Shimmer: `https://photonpoetry.com/shimmer/`, …
- Best Units: `https://photonpoetry.com/best-units/`, …
