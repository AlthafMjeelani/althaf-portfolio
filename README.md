# Althaf M — Portfolio

Personal portfolio of **Althaf M**, Senior Full-Stack Engineer at Texol World, Kozhikode.

**Live:** https://althafmjeelani.github.io/althaf-portfolio/

## What's inside

The current site lives in `site/`. It's plain HTML, CSS and JavaScript in a single page, with no build step.

- Animated wire-mesh background and a "workspace" of connected windows: a live terminal, a dashboard and tabbed code views (Python RAG, Go, Dart, SQL)
- An AI agent pipeline that runs a sample query step by step
- Nine skill modules; tapping a skill highlights the projects that use it
- Ten project windows with app screenshots, details, and App Store / Play Store links
- About, education, achievements and career history
- Contact form (EmailJS, with a mail-app fallback), resume download, light and dark themes

```
site/
├── index.html              # the whole site
├── assets/images/          # profile photo, app screenshots, share image
├── assets/files/           # resume PDF
├── favicon.png / .svg
└── .nojekyll
```

The previous Flutter web version is kept in `lib/` and `web/`.

## Run locally

```bash
cd site
python3 -m http.server 8000
# open http://localhost:8000
```

## Deploy

```bash
./deploy.sh            # publishes site/ to the gh-pages branch
./deploy.sh --flutter  # builds and publishes the old Flutter version instead
```

## SEO, analytics and domain

- `index.html` has structured data (schema.org Person + WebSite), canonical URL, Open Graph and Twitter tags.
- `robots.txt` and `sitemap.xml` are in `site/`. Submit the sitemap in [Google Search Console](https://search.google.com/search-console) so your name search finds the site.
- `manifest.webmanifest` lets phones install the site; `404.html` is a styled not-found page.
- **Analytics:** set `window.SITE_ANALYTICS_ID = 'G-XXXXXXX'` near the top of `index.html` (Google Analytics 4). Empty means no tracking.
- **Custom domain:** buy a domain (for example `althaf.dev`), add a `CNAME` file in `site/` containing the domain, point a DNS CNAME record to `althafmjeelani.github.io`, then update the canonical and Open Graph URLs plus `sitemap.xml`.

## Performance

A lite mode turns on automatically for Data Saver or low-end phones (fewer background particles, slower frame rate, no blobs). All motion stops for visitors who prefer reduced motion.

## Editing content

All project data is in the `P` array near the bottom of `site/index.html`. Each project has a name, dates, summary, details, features, role, stack, screenshot, store links and the skill keys (`s`) used for skill highlighting.

### Details still to fill in

Search `site/index.html` for `[` to find every placeholder:

- **Enteura, Stock Taking, Project Tracker, Invoice Extract**: one-line summary, year, features, role and stack (and the names of Enteura's 3 apps)
- **print_bluetooth_thermal**: what you changed in the fork (the git log window and the achievements window)
- **Lead the team**: how you review code and mentor developers
- **Skill → project links**: add skill keys to each project's `s` list for skills like `rag`, `aws`, `python`, `snowflake`
- **Screenshots**: add images for Enteura, Project Tracker and Invoice Extract to `site/assets/images/` and set `img` in the project data
