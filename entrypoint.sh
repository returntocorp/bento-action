#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

bento_path=$(which bento)

bento() {
    $bento_path --agree --email "$INPUT_ACCEPTTERMSWITHEMAIL" "$@"
}

echo "action's environment: $(bento --version), $(python --version), $(docker --version)"

echo
echo "== [1/4] going to go back to the commit you based your pull request on…"
echo
git revert HEAD --mainline 1 --no-commit
git reset .

echo
echo "== [2/4] …checking for issues present in the codebase before your pull request…"
echo
bento init &> /dev/null
bento archive --all
git add -f .bento*

echo
echo "== [3/4] …now adding your pull request's changes back…"
echo
git checkout .
echo "pull request changes restored via git checkout"

echo
echo "== [4/4] …and see if there are any new findings!"
echo
bento check --all
