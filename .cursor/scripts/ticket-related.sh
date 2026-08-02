#!/usr/bin/env bash
# Find related open/closed GitHub issues for pattern and regression detection.
#
# Usage:
#   ticket-related.sh <issue-number>
#   ticket-related.sh --query "widget polaroid thumbnail"
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI required" >&2
  exit 1
fi

repo="$(gh repo view --json nameWithOwner -q .nameWithOwner)"

if [[ $# -eq 0 ]]; then
  echo "Usage: ticket-related.sh <issue-number>|--query \"search terms\"" >&2
  exit 1
fi

if [[ "$1" == "--query" ]]; then
  query="${2:-}"
  [[ -z "$query" ]] && { echo "Provide search terms after --query" >&2; exit 1; }
else
  num="$1"
  json="$(gh issue view "$num" --json title,body,labels)"
  title="$(printf '%s' "$json" | python3 -c 'import json,sys; print(json.load(sys.stdin)["title"])')"
  body="$(printf '%s' "$json" | python3 -c 'import json,sys; print(json.load(sys.stdin)["body"][:500])')"
  # Strip ticket boilerplate; keep meaningful words
  query="$(printf '%s %s' "$title" "$body" | tr '#[]()' ' ' | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9 ]+/ /g' | awk '{for(i=1;i<=NF;i++) if(length($i)>3) print $i}' | head -12 | tr '\n' ' ')"
fi

echo "Related issues in ${repo}"
echo "Query: ${query}"
echo ""

gh search issues "${query} repo:${repo} label:ticket" --limit 15 --json number,title,state,labels,url \
  | python3 -c '
import json, sys
items = json.load(sys.stdin)
if not items:
    print("No matches.")
    sys.exit(0)
for it in items:
    labels = ", ".join(l["name"] for l in it.get("labels", []))
    flag = "REGRESSION" if any(l["name"] == "regression" for l in it.get("labels", [])) else it["state"]
    num = it["number"]
    title = it["title"]
    url = it["url"]
    print(f"#{num} [{flag}] {title}")
    if labels:
        print(f"    {labels}")
    print(f"    {url}")
    print()
'

echo "---"
echo "Regression candidates (closed ticket label, same area keywords):"
gh search issues "${query} repo:${repo} label:ticket label:regression" --limit 5 --json number,title,state,url \
  | python3 -c '
import json, sys
items = json.load(sys.stdin)
for it in items:
    num = it["number"]
    title = it["title"]
    state = it["state"]
    url = it["url"]
    print(f"#{num} [{state}] {title} — {url}")
' || true
