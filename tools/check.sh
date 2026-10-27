#!/usr/bin/env bash
# Quick checks for site/index.html. Run before every commit:  ./tools/check.sh
set -euo pipefail
cd "$(dirname "$0")/.."
F=site/index.html

echo "1/4 JavaScript parses"
node -e "const s=require('fs').readFileSync('$F','utf8');[...s.matchAll(/<script>([\s\S]*?)<\/script>/g)].forEach(m=>new Function(m[1]));"

echo "2/4 Structured data is valid JSON"
node -e "const s=require('fs').readFileSync('$F','utf8');const m=s.match(/<script type=\"application\/ld\+json\">([\s\S]*?)<\/script>/);if(!m)throw new Error('no JSON-LD');JSON.parse(m[1]);"

echo "3/4 Required files exist"
for f in site/404.html site/robots.txt site/sitemap.xml site/manifest.webmanifest site/favicon.ico site/favicon.svg \
         site/assets/images/profile.jpg site/assets/images/portrait.jpg site/assets/images/og.jpg site/assets/files/Althaf_M_Resume.pdf; do
  [ -f "$f" ] || { echo "missing: $f"; exit 1; }
done

echo "4/4 Placeholders still to fill"
grep -oE "\[(One line|YEAR|Feature|Your role|Stack|How you)[^]]*\]" "$F" | sort | uniq -c || echo "   none"

echo "OK"
