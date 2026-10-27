# Prompts for updating the portfolio

Copy a prompt, fill in the brackets and send it to Claude (or any coding agent) in this repo. Each prompt already tells the agent which rules to follow, so the results stay consistent.

Every prompt assumes the agent reads `CLAUDE.md` first.

---

## Add a new project

```
Read CLAUDE.md. Add a project to the P array in site/index.html, newest first:
- Name: [name]
- Company: [Texol World | Independent | BigWelt | other]
- Dates: [Mon YYYY – Mon YYYY or "now"]
- One-line summary: [...]
- Longer description: [...]
- Key features (3–5): [...]
- My role: [...]
- Stack: [...]
- App Store / Google Play links: [links or "none"]
Pick a fitting animated screen from UI (or add a new one in the same style),
link the matching skill keys in `s`, update the product count everywhere it
appears, run ./tools/check.sh, check 390px and desktop in both themes,
then commit to main and run ./deploy.sh.
```

## Fill in a placeholder project

```
Read CLAUDE.md. Replace the placeholders for [Enteura | Stock Taking | Project Tracker]
in the P array with these facts: [summary, year, features, role, stack, app names].
Remove every [bracket] for that project, link real skill keys only,
run ./tools/check.sh, commit and deploy.
```

## Pull details from a repo

```
Read CLAUDE.md. I have shared the repo [owner/repo]. Read its README, docs and
package manifests and its commit history (my commits only). Update the matching
project in site/index.html with facts you can verify: what it does, features,
stack, dates, my commit count. Do not guess. List anything you could not verify.
Keep client code and internal details private. Commit and deploy.
```

## Update the resume

```
Read CLAUDE.md. Update tools/resume/build_resume.py with: [changes].
Keep it ATS-friendly (single column, standard headings, no tables or images),
rebuild site/assets/files/Althaf_M_Resume.pdf, confirm it is still 2 pages,
and keep the site and resume consistent (titles, dates, counts). Commit and deploy.
```

## Change job title or experience

```
Read CLAUDE.md. My title is now [title] at [company] since [date].
Update the hero badge, the "System:" line, the timeline, the JSON-LD jobTitle,
the meta descriptions, and the resume. Commit and deploy.
```

## Add or remove skills

```
Read CLAUDE.md. Add these skills to the [module] module: [skills], and link them
to [projects]. Remove these skills everywhere (tags, terminal text, dashboard
stack, JSON-LD knowsAbout, resume): [skills]. Commit and deploy.
```

## Add a testimonial section

```
Read CLAUDE.md. Add a testimonials section before #contact with these real quotes:
1. "[quote]" — [name], [role], [company]
2. ...
Use the window style of the site, both themes, responsive, reduced-motion safe.
Commit and deploy.
```

## Add a case study page

```
Read CLAUDE.md. Create a case study for [project] as a section or a page in site/
with: problem, constraints, architecture (draw it as an inline SVG diagram),
2–3 key decisions with trade-offs, what went wrong, results with these numbers:
[numbers]. Link it from the project's detail sheet. Commit and deploy.
```

## Turn on analytics

```
Read CLAUDE.md. Set SITE_ANALYTICS_ID to [G-XXXXXXX] in site/index.html.
Commit and deploy.
```

## Connect a custom domain

```
Read CLAUDE.md. Connect the domain [domain]: add site/CNAME, update the canonical
URL, Open Graph and Twitter URLs, JSON-LD urls, sitemap.xml, robots.txt and the
404 page links. Tell me the DNS records to add. Commit and deploy.
```

## Visual or motion change

```
Read CLAUDE.md. Change [section] so that [what you want]. Keep the existing
tokens and fonts, both themes, 44px tap targets, no sideways scroll at 360px,
and stop all motion under prefers-reduced-motion. Take a screenshot at 1280px
and 390px to check, then commit and deploy.
```

## Health check

```
Read CLAUDE.md. Audit the site: run ./tools/check.sh, check every width from
360px to 1440px for overflow, small tap targets and tiny text, both themes,
broken links, console errors, and whether anything on the page is not backed
by a real fact. Fix what you can, list the rest.
```
