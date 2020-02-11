#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

echo
echo "== [1/4] we're going to go back to the commit you based your pull request on…"
echo
git revert HEAD --mainline 1 --no-commit
git reset .

echo
echo "== [2/4] …checking what issues the codebase had before your pull request…"
echo
bento --agree --email "bence+actions@underyx.me" init  # FIXME
bento archive --all
git add .bento*

echo
echo "== [3/4] …now let's add your pull request's changes back…"
echo
git checkout .

echo
echo "== [4/4] …and see if there's any new findings!"
echo
bento check --all
