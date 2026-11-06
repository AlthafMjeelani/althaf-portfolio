#!/usr/bin/env python3
"""Write site/assets/data/github-stats.json from the GitHub GraphQL API.

Runs in GitHub Actions with a read-only token (secret STATS_TOKEN), because a
browser can only see public repos and a token must never be shipped to visitors.

Privacy: the output holds totals only. No repository names, descriptions, code
or organisation data. Private work is counted, never named.

Usage:  STATS_TOKEN=... python3 tools/github_stats.py [output.json]
"""
import json, os, sys, urllib.request, urllib.error
from collections import Counter
from datetime import datetime, timezone

OUT = sys.argv[1] if len(sys.argv) > 1 else 'site/assets/data/github-stats.json'
TOKEN = os.environ.get('STATS_TOKEN', '').strip()
if not TOKEN:
    print('STATS_TOKEN is not set: skipping (the site falls back to public data).')
    sys.exit(0)

QUERY = '''
query($after:String){
  viewer{
    organizations{totalCount}
    contributionsCollection{
      totalCommitContributions totalPullRequestContributions
      totalIssueContributions totalPullRequestReviewContributions
      contributionCalendar{ totalContributions weeks{ contributionDays{ contributionCount } } }
    }
    repositories(first:100, after:$after, ownerAffiliations:[OWNER,ORGANIZATION_MEMBER,COLLABORATOR]){
      pageInfo{hasNextPage endCursor}
      nodes{ isPrivate isFork isArchived primaryLanguage{name} }
    }
  }
}'''


def call(after):
    req = urllib.request.Request(
        'https://api.github.com/graphql',
        data=json.dumps({'query': QUERY, 'variables': {'after': after}}).encode(),
        headers={'Authorization': 'bearer ' + TOKEN, 'Content-Type': 'application/json',
                 'User-Agent': 'portfolio-stats'})
    try:
        with urllib.request.urlopen(req, timeout=60) as r:
            data = json.load(r)
    except urllib.error.HTTPError as e:
        sys.exit('GitHub API error %s: %s' % (e.code, e.read()[:200]))
    if data.get('errors'):
        sys.exit('GitHub API errors: %s' % json.dumps(data['errors'])[:300])
    return data['data']['viewer']


first = call(None)
nodes, page = list(first['repositories']['nodes']), first['repositories']['pageInfo']
while page['hasNextPage']:
    nxt = call(page['endCursor'])
    nodes += nxt['repositories']['nodes']
    page = nxt['repositories']['pageInfo']

own = [n for n in nodes if not n['isFork']]
langs = Counter(n['primaryLanguage']['name'] for n in own
                if n['primaryLanguage'] and not n['isArchived'])
total_l = sum(langs.values()) or 1
cc = first['contributionsCollection']
cal = cc['contributionCalendar']

out = {
    'generated': datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ'),
    'year': {
        'contributions': cal['totalContributions'],
        'commits': cc['totalCommitContributions'],
        'pullRequests': cc['totalPullRequestContributions'],
        'issues': cc['totalIssueContributions'],
        'reviews': cc['totalPullRequestReviewContributions'],
    },
    'repos': {
        'public': sum(1 for n in own if not n['isPrivate']),
        'private': sum(1 for n in own if n['isPrivate']),
        'orgs': first['organizations']['totalCount'],
    },
    'languages': [{'name': k, 'pct': round(100 * v / total_l)} for k, v in langs.most_common(6)],
    'weeks': [[d['contributionCount'] for d in w['contributionDays']] for w in cal['weeks']],
}
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, 'w') as f:
    json.dump(out, f, separators=(',', ':'))
print('wrote %s: %d contributions, %d public + %d private repos' % (
    OUT, out['year']['contributions'], out['repos']['public'], out['repos']['private']))
