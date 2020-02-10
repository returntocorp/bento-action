#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

# go back in time to before the PR
git revert HEAD --mainline 1 --no-commit
git restore --staged .

# set up bento on old state
pipenv run bento init --agree --email "bence+actions@underyx.me"  # FIXME
pipenv run bento archive --all
git add .bento*

# go back to new state
git checkout .

# run bento checks
pipenv run bento check --all
