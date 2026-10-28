# Portfolio technical design

## Overview

| | |
| --- | --- |
| Type | Static single-page site |
| Source | `site/index.html` (about 1,500 lines: markup, CSS and JS in one file) |
| Dependencies at runtime | Google Fonts; EmailJS browser SDK (contact form); GitHub REST API (public, unauthenticated); ghchart.rshah.org (contribution graph image) |
| Build step | None |
| Hosting | GitHub Pages from the `gh-pages` branch |
| Legacy | Flutter web version in `lib/` and `web/` (deployable with `./deploy.sh --flutter`) |

## Repository layout

```
site/
├── index.html              # the whole site
├── 404.html                # styled not-found page
├── manifest.webmanifest    # installable app
├── robots.txt, sitemap.xml
├── favicon.ico, favicon.svg, favicon-32.png, favicon.png, apple-touch-icon.png
└── assets/
    ├── images/             # profile.jpg, portrait.jpg, og.jpg (share image), icon-192/512.png, legacy screenshots
    └── files/Althaf_M_Resume.pdf
tools/
├── check.sh                # pre-commit checks
└── resume/build_resume.py  # generates the ATS resume PDF (reportlab)
docs/                       # FEATURES.md, TECHNICAL.md, PROMPTS.md
deploy.sh                   # publishes site/ to gh-pages
CLAUDE.md, AGENTS.md        # instructions for AI agents
```

## Design system

Layout concept: a "cyber-natural" workspace, one 1180px column on a living wire mesh, every block shown as an app window.

**Colour tokens** (light values on `:root`, redefined twice for dark):

| Token | Role |
| --- | --- |
| `--bg`, `--surface`, `--paper`, `--sunk` | page, cards, window body, recessed areas |
| `--ink`, `--muted`, `--line` | text, secondary text, borders |
| `--forest`, `--forest-2`, `--term-ink`, `--term-dim` | dark terminal windows |
| `--accent`, `--accent-soft`, `--accent-ink`, `--leaf`, `--ts` | green accent, tints, gold highlight |
| `--k`, `--s`, `--f`, `--c`, `--t` | syntax colours: keyword, string, function, comment, type |
| `--mesh` | canvas mesh colour |
| `--tl`, `--tch`, `--tc2l`, `--tch2` | lightness and chroma used with a per-card `--hue` in `oklch()` for project art |

**Type:** Martian Mono (display, headings), Instrument Sans (body), JetBrains Mono (labels, code, terminals), each with system fallbacks.

**Theme switching:** `data-theme` on `<html>` overrides the OS setting; the choice is stored in `localStorage` (wrapped in try/catch).

## Page structure

| Id | Section |
| --- | --- |
| `#top` | hero |
| `#desk` | workspace (terminal `#wTerm`, dashboard `#wDash`, code `#wCode`, wires `#wires`) |
| `#agent` | single-agent pipeline (`#graph`, log `#alog`) |
| `#multi` | multi-agent diagram (`#maSvg`, inspector `#insp`, log `#malog`) |
| `#craft` | clean architecture, refactor diff, principles, CI pipeline |
| `#skills` | eight skill modules |
| `#projects` | gallery `#gallery`, detail dialog `#sheet` |
| `#more` | open source, practice, `#github`, `#about`, `#timeline` |
| `#contact` | contact card and form `#cform` |

## JavaScript modules (all inside one IIFE)

| Module | What it does |
| --- | --- |
| Theme | toggles `data-theme`, persists it |
| Mesh + code particles | `<canvas id="mesh">`: distorted grid in two corners plus drifting code tokens (`TOK`), repelled by the pointer; about 30 fps, 15 fps in lite mode |
| Title | splits the name into letters for reveal and glint |
| Wires | draws SVG curves between workspace windows from their live positions; redraws on resize and tab change |
| Terminal | types a scripted session (`script`), loops |
| Code views | `CODE` array of highlighted snippets, tabbed, auto-rotates every 9 s |
| Agent | animates packets along SVG paths (`getPointAtLength`) and logs steps |
| Multi-agent | `MA` node descriptions for the inspector; `maRun()` scenario with parallel packets |
| Refactor diff | `DIFF` before/after lines |
| CI pipeline | loops six stages with progress bars |
| Motion extras | spotlight, scroll progress, rotating role, magnetic buttons, count-up |
| Menu | full-screen mobile menu with focus handling and Escape to close |
| Ripple, heading decode, tag pop, mesh parallax | IntersectionObserver-driven extras |
| GitHub | fetches `/users/AlthafMjeelani` and recent repos; keeps the static list on failure |
| Projects | renders `P` into `#gallery` using `UI` screen templates; detail sheet; skill filter; company filter; 3D tilt |
| Contact form | validates, sends with `emailjs.send(service, template, params)`; falls back to `mailto:` |

## Project data model (`P`)

```js
{
  n: 'PayNest',                 // name
  file: 'paynest.saas',         // window title
  org: 'Independent',           // 'Texol World' | 'Independent' | 'BigWelt' (drives the filter)
  when: 'Mar – Aug 2026',
  hue: 200,                     // card tint, 0–360
  ui: 'dues',                   // key in UI: list booking voice pay clock stock board scan team erp qr feed dues ledger ask apps
  count: '3 apps',              // optional badge
  sum: 'One-line summary',
  detail: 'Longer description for the sheet',
  feat: ['Feature', '…'],
  role: 'Full-stack: backend, admin apps, DevOps',
  stack: ['Go', 'PostgreSQL', '…'],
  play: 'https://play.google.com/…', ios: 'https://apps.apple.com/…',   // optional
  s: ['go', 'postgres', '…']    // skill keys this project proves
}
```

**Skill keys** (`data-s` on tags): `python go dart ts js kotlin sql flutter state arch native react web ios android multiapp maps figma rest graphql node fastapi php realtime offline postgres mongo redis sqlite firebase llm rag vector agents prompt finetune ocr voice openai claude gemini openrouter llamaindex hf ollama mcp qdrant pinecone pgvector pytorch tf etl clickhouse bigquery redshift dbt airflow spark kafka bi aws gcp azure hosting docker k8s terraform cicd linux testing auth bio apisec iam push pay upi`.

## Performance

- No framework; one HTML document.
- Canvas throttled and paused while the tab is hidden.
- Lite mode (`navigator.connection.saveData`, `deviceMemory <= 2` or `hardwareConcurrency <= 2`) lowers particle count and frame rate and hides blurred glows.
- Images: profile preloaded, others lazy.
- `overflow-x: clip` on the page wrapper prevents sideways scroll without breaking the sticky header.

## Accessibility

Semantic landmarks, skip link, real buttons and links, `aria-pressed` on toggles, `aria-live` on logs and the skill note, labelled form fields with inline errors, focus-visible outlines, 44px targets, reduced-motion support, text alternatives for the diagrams.

## SEO

JSON-LD `Person` (job title, employer, location, skills, languages, profiles) and `WebSite`; canonical URL; keywords; Open Graph and Twitter cards (`og.jpg`, 1200×630); `robots.txt`; `sitemap.xml`; installable manifest.

## Configuration

| Setting | Where |
| --- | --- |
| Analytics | `window.SITE_ANALYTICS_ID = 'G-…'` in `<head>` (empty = off) |
| EmailJS | `EJ` object in the contact form script (service, template, public key) |
| GitHub user | `U` in the live GitHub module |
| Custom domain | add `site/CNAME`, point DNS to `althafmjeelani.github.io`, update canonical, Open Graph URLs and `sitemap.xml` |

## Quality checks

```bash
./tools/check.sh
```

Checks that every inline script parses, the JSON-LD is valid, required files exist, and lists remaining placeholders. Then preview locally and look at 390px and desktop widths in both themes.

## Deployment

```bash
./deploy.sh
```

Copies `site/` into the `gh-pages` branch (with `.nojekyll`) and pushes. GitHub Pages serves it within a few minutes; browsers may cache the favicon and CSS, so hard-refresh after a deploy.
