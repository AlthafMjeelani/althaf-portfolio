# Portfolio features

What visitors see and can do on https://althafmjeelani.github.io/althaf-portfolio/, section by section in page order.

## Global

| Feature | Behaviour |
| --- | --- |
| Themes | Light and dark. Follows the device by default; the moon button toggles and remembers the choice. |
| Living background | Animated wire mesh, floating code tokens (`</>`, `async`, `git push`, `SELECT *`…) that drift up and move away from the cursor, and two slow colour glows. |
| Cursor spotlight | Soft glow follows the pointer on desktop. |
| Scroll progress | Thin gradient bar under the header. |
| Sticky header | Section links on desktop; on phones a hamburger opens a full-screen menu with all nine sections. |
| Skip link | `Tab` on load shows "Skip to content". |
| Motion | Word and letter reveals, heading decode with underline, staggered tag pop-in, floating windows, magnetic buttons, ripple on press, 3D card tilt, tech tickers. |
| Reduced motion | All animation stops when the device asks for reduced motion. |
| Lite mode | On Data Saver or low-end phones: fewer particles, lower frame rate, no glows. |
| Installable | Can be added to the home screen (web app manifest, monogram icon). |
| 404 page | Terminal-style "cd: no such file or directory" with a link home. |

## 1. Hero

- Profile photo inside two orbiting rings of skill chips.
- Floating code cards beside the photo on desktop (`new Engineer({...})`, a `git commit` / deploy terminal).
- "SYSTEM: SENIOR FULL-STACK ENGINEER" with a drawn underline.
- Name revealed letter by letter, then a looping green glint.
- "I build …" line that types and deletes: mobile apps, web platforms, REST & Go APIs, data pipelines, RAG search, AI agents, cloud infrastructure.
- Buttons: open projects, view skills, download resume. Scroll cue.

## 2. Workspace

Three windows joined by animated wires:

- **Terminal** that types commands in a loop: `ls skills/`, `cat stack.txt`, a deploy to AWS, an agent query.
- **Dashboard** with count-up figures (13 products, 4+ years, 15+ apps, Employee of the Month) and the active stack.
- **Code views** with tabs, auto-rotating, with a moving highlighted line: Python RAG, Go API handler, Dart offline-first repository, SQL dbt model.

## 3. AI agents

Single-agent pipeline (Query → Planner → Retriever / Tools / Memory → Response). **Run agent** animates each step and writes a log.

## 4. Multi-agent architecture

- Diagram: user, orchestrator, four specialist agents (research, code, data, ops), each with its own tools over MCP, a reviewer guardrail and shared memory.
- Hover or tap any node to see its role and tools in the inspector.
- **Run scenario** plays a parallel task ("why did van sales drop, fix the sync bug") with a live log.
- Four-layer legend and a note on where this was built for real (AI Frontier).

## 5. How I write code

- Clean-architecture rings (presentation → application → data → domain).
- Before/after refactor of a Dart sync service.
- Six principles: typed and tested, small units, errors as values, reviews, conventional commits, observability.
- CI pipeline animation: lint → test → build → scan → review → deploy, looping.

## 6. Skills

Nine modules: languages, apps and interfaces, backend and databases, AI and ML, AI tools and frameworks, data science, data engineering and warehousing, cloud and DevOps, security and payments.

Tapping a skill dims the projects that do not use it and names the ones that do, with a jump link.

## 7. Projects

Thirteen products, newest first, each in an app window with its own animated drawn screen (a van driving its route, cycling wash packages, voice chat, ERP charts, QR check-in, AI release feed, dues collected, a ledger, invoice scanning…).

- Filters: all, Texol World, independent, BigWelt.
- Open any card for a detail sheet: what it does, key features, company, dates, role, stack, App Store and Google Play links.

## 8. More

- **GitHub:** workspaces (Texol World, Vanforces, independent builds) with product chips and contribution figures; contribution graph; personal repos and public repo count pulled live from the GitHub API (static fallback).
- **Open source in production:** how the Bluetooth thermal printing plugin is used in Vanforces.
- **Practice:** how the owner runs projects (lifecycle, release automation, team lead).
- **About:** portrait, short bio, languages spoken.
- **Education and achievements.**
- **Career history** as a terminal `history` window.

## 9. Contact

Terminal-style contact card, a form that sends through EmailJS (falls back to the visitor's mail app), copy-email button, LinkedIn and GitHub links.

## SEO and sharing

Structured data (Person and WebSite), canonical URL, Open Graph and Twitter cards with a share image, sitemap, robots.txt, optional Google Analytics.
