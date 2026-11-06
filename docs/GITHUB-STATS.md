# GitHub stats from private repos

The GitHub window on the site shows contribution totals that include private and organisation work. A browser can only read public repos, and a token must never be shipped to visitors, so a scheduled GitHub Action does it instead.

**How it works**

1. `.github/workflows/github-stats.yml` runs once a day (and on demand) with a read-only token stored as the repository secret `STATS_TOKEN`.
2. `tools/github_stats.py` asks the GitHub GraphQL API for totals and writes `site/assets/data/github-stats.json`.
3. The workflow commits that file to `main` and copies it to `gh-pages`, so the live site updates without a full deploy.
4. `site/index.html` reads the file. If it is missing, the window falls back to public data from the GitHub API.

**Privacy.** The file holds totals only: contributions, commits, pull requests, issues, reviews, public and private repo counts, organisation count, top languages (by repo count) and the daily contribution calendar. It never contains repo names, descriptions, code or client data.

## One-time setup (you do this)

1. GitHub, Settings, Developer settings, Personal access tokens, **Fine-grained tokens**, Generate new token.
2. Resource owner: your account. Repository access: **All repositories** (or select the ones to count). Permissions: **Metadata: Read-only** (add **Contents: Read-only** if a repo is missing).
3. For organisation repos (Texol World, Vanforces) create the token with the organisation as resource owner too, or ask an organisation owner to approve it. Organisations can block tokens, in which case only your own repos are counted.
4. Repository `althaf-portfolio`, Settings, Secrets and variables, Actions, **New repository secret**: name `STATS_TOKEN`, value the token.
5. Actions tab, **GitHub stats**, **Run workflow**. A minute later `site/assets/data/github-stats.json` appears on `main` and the live site shows the totals.
6. Profile settings, Contributions and activity: turn on **Include private contributions on my profile** so the calendar counts private work.

Tokens expire. When the daily run starts failing, create a new token and update the secret.

## Run it locally

```bash
STATS_TOKEN=... python3 tools/github_stats.py
```

Without `STATS_TOKEN` the script prints a notice and exits without writing anything.
