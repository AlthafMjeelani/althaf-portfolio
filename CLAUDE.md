# CLAUDE.md

Guidance for Claude Code and other AI agents working in this repository.

## What this repo is

The personal portfolio of **Althaf M, AI Application Engineer, Flutter and mobile background** (Texol World, Kozhikode).

- **Live site:** https://althafmjeelani.github.io/althaf-portfolio/
- **Current site:** `site/`, a static single page (HTML, CSS, vanilla JS) with no build step.
- **Legacy site:** `lib/`, `web/`, `android/`, `ios/`... is the previous Flutter web version. Keep it, but do not edit it unless asked.

Read `docs/FEATURES.md` for what the site does and `docs/TECHNICAL.md` for how it is built. `docs/PROMPTS.md` has ready-made task prompts.

## Golden rules

1. **Facts only.** Never invent projects, numbers, dates, employers, clients, quotes or skills. Missing facts stay as visible placeholders in square brackets, e.g. `[YEAR]`, `[One line: what X does]`. Facts come from the owner, his repos, his resume, or the old Flutter source in `lib/`.
2. **Private client work stays private.** Organisation repos (Texol World, Vanforces) are private: show product names, scope, stack and contribution figures, never code, internal links or client data. **Do not mention Almawasil anywhere** (owner's decision).
3. **One file.** All markup, styles and scripts for the page live in `site/index.html`. Do not add frameworks, bundlers or build steps.
4. **Both themes.** Every colour is a CSS token on `:root`, redefined for dark mode under `@media (prefers-color-scheme: dark)` with `:root:not([data-theme="light"])` and again under `:root[data-theme="dark"]`. Never hard-code a colour that only works in one theme.
5. **Respect motion settings.** Every animation must stop under `prefers-reduced-motion: reduce`. Heavy effects must also respect lite mode (`.lite` on `<html>`).
6. **Responsive at every width.** No horizontal page scroll from 360px up. Tap targets at least 44px (skill tags 40px). Text at least 12px. Wide diagrams scroll inside their own `overflow-x:auto` box.
7. **Accessible.** Real `<button>` and `<a href>` elements, visible focus, `aria-label` on icon-only buttons, `aria-hidden` on decoration, alt text on images.
8. **Complete at rest.** Content must be readable without scrolling triggers or JS finishing. Scroll reveals start from a visible state.

## Before every commit

```bash
./tools/check.sh                      # JS parses, JSON-LD valid, files present, lists placeholders
cd site && python3 -m http.server 8000 # look at it: desktop, 390px phone, light and dark
```

If you changed the resume content, rebuild it and confirm it is still 2 pages:

```bash
python3 tools/resume/build_resume.py site/assets/files/Althaf_M_Resume.pdf
pdfinfo site/assets/files/Althaf_M_Resume.pdf | grep Pages
```

## Deploy

`main` holds the source. The live site is the `gh-pages` branch, which is a copy of `site/`.

```bash
./deploy.sh            # publishes site/ to gh-pages
```

Without the script: copy `site/.` into a `gh-pages` checkout, commit, push. Never push the Flutter build to gh-pages unless asked (`./deploy.sh --flutter`).

## Where things are in `site/index.html`

| What | Where |
| --- | --- |
| Design tokens (colours, fonts) | first `:root` block in `<style>` |
| Hero (photo, orbit, name, role rotator) | `<section class="hero">` |
| Workspace (terminal, dashboard, code tabs) | `#desk` |
| AI agent pipeline | `#agent` |
| Multi-agent architecture | `#multi` (data in the `MA` object in JS) |
| Coding style (rings, diff, principles, CI) | `#craft` (diff data in `DIFF`) |
| Skills | `#skills` (each tag has `data-s="<key>"`) |
| Projects | `#projects` (data in the `P` array in JS, screens in `UI`) |
| GitHub, about, education, achievements, timeline | `#more` |
| Contact form (EmailJS) | `#contact` (keys in `EJ`) |
| SEO and analytics | `<head>`: JSON-LD, Open Graph, `SITE_ANALYTICS_ID` |

## Common edits

- **Add or update a project:** edit the `P` array. Fields: `n` name, `file` window title, `org` (`Texol World`, `Independent`, `BigWelt`), `when`, `hue` (0–360), `ui` (screen key from `UI`), `count` (optional badge), `sum`, `detail`, `feat` (array), `role`, `stack` (array), `play`/`ios` (store links), `s` (skill keys). Keep the list newest first. Update the product count (hero text, dashboard chip, ticker, projects heading) if the total changes.
- **Link a skill to a project:** add the skill's `data-s` key to that project's `s` array. Only link when the project really uses it.
- **Add a skill:** add a `<button class="tag" type="button" data-s="key">Label</button>` in the right module, then link it to projects.
- **New project screen:** add a function to `UI` that returns markup using the `.ui` classes; animate with existing keyframes.

## Commits

Conventional commits: `feat(site): ...`, `fix(site): ...`, `docs: ...`, `chore: ...`. Push to `main`, then deploy.
