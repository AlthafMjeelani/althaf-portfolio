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

## Editing content

All project data is in the `P` array near the bottom of `site/index.html`. Each project has a name, dates, summary, details, features, role, stack, screenshot, store links and the skill keys (`s`) used for skill highlighting.

### Details still to fill in

Search `site/index.html` for `[` to find every placeholder:

- **Enteura, Stock Taking, Project Tracker, Invoice Extract**: one-line summary, year, features, role and stack (and the names of Enteura's 3 apps)
- **print_bluetooth_thermal**: what you changed in the fork (the git log window and the achievements window)
- **Lead the team**: how you review code and mentor developers
- **Skill → project links**: add skill keys to each project's `s` list for skills like `rag`, `aws`, `python`, `snowflake`
- **Screenshots**: add images for Enteura, Project Tracker and Invoice Extract to `site/assets/images/` and set `img` in the project data
