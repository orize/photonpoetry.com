---
name: release-checklist
description: Pre-release checklist for photonpoetry.com before merging to main or asking for production deploy.
---

# Release checklist

Before asking to merge to `main` or deploy production:

1. [ ] Studio home and all three product marketing pages load locally
2. [ ] Each product has `/privacy/` and `/support/`
3. [ ] Legacy `/privacy` and `/support` still redirect to Luminous (`site/_redirects`)
4. [ ] Luminous keeps `<link rel="redirect_uri" href="luminous://ha-auth">` for HA OAuth
5. [ ] Cloudflare Pages root is documented as `site` (README)
6. [ ] No Affinity `.af` files under `site/`
7. [ ] Shared emails still `hello@` / `support@photonpoetry.com` unless intentionally changed
8. [ ] ASC URL trios documented if marketing/privacy/support paths changed
9. [ ] User has reviewed the PR — **do not merge without approval**

## ASC URL trios

- Luminous: `/luminous/`, `/luminous/privacy/`, `/luminous/support/`
- Shimmer: `/shimmer/`, `/shimmer/privacy/`, `/shimmer/support/`
- Best Units: `/best-units/`, `/best-units/privacy/`, `/best-units/support/`
