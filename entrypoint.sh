#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

# go back in time to before the PR
git revert HEAD --mainline 1 --no-commit
git reset .

# set up bento on old state
bento init --agree --email "bence+actions@underyx.me"  # FIXME
bento archive --all
git add .bento*

# go back to new state
git checkout .

# run bento checks
bento check --all
