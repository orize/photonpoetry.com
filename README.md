# Luminous brochure site

Static marketing pages for [photonpoetry.com](https://photonpoetry.com). No build step.

Published from this repository. In the [photonectar](https://github.com/orize/photonectar) app repo, this folder is a **git submodule** at `website/`.

## Pages

| File | Purpose |
|------|---------|
| `index.html` | Landing page with hero and App Store placeholder |
| `privacy.html` | Privacy policy stub (review before App Store submission) |
| `support.html` | Support contact and FAQ (App Store support URL) |

## Deploy to Cloudflare Pages (Git)

1. Cloudflare Dashboard → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**.
2. Select **`orize/photonpoetry.com`** and authorise GitHub if prompted.
3. Configure the build:
   - **Production branch:** `main`
   - **Framework preset:** None
   - **Build command:** *(leave empty)*
   - **Root directory:** *(leave empty — files are at repo root)*
   - **Build output directory:** `/`
4. Deploy and open the `*.pages.dev` preview URL. Confirm `/`, `/privacy.html`, and `/support.html`.
5. **Custom domains:** add `photonpoetry.com` and `www.photonpoetry.com` under the Pages project → **Custom domains**.

Each push to `main` triggers a new deploy.

DNS and nameserver changes at your registrar remain manual.

## Deploy fallback (Direct Upload)

1. **Workers & Pages** → **Upload assets**.
2. Upload **all files from this repo root** (`index.html`, `privacy.html`, `support.html`, `assets/`).
3. Add custom domains as above.

## Submodule workflow (photonectar developers)

Edit files here in Cursor under `Photonectar/website/`, then:

```bash
cd website
git add .
git commit -m "Update site copy"
git push
```

In the photonectar repo root, commit the updated submodule pointer when you want `main` to reference the new site revision:

```bash
git add website
git commit -m "Bump website submodule"
git push
```

Fresh clone of photonectar:

```bash
git clone --recurse-submodules https://github.com/orize/photonectar.git
```

## App Store link

When the App Store listing exists, edit `index.html`:

1. Uncomment the real App Store `<a>` in the CTA block.
2. Remove or hide the disabled “Coming soon” button.
3. Set the `href` to your official App Store URL — do not guess the ID.

## Local preview

```bash
python3 -m http.server 8080
```

Open `http://localhost:8080/` and verify links, mailto addresses, and the favicon.
