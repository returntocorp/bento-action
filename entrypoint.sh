#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

bento_path=$(which bento)

bento() {
  bento_result=0
  $bento_path --agree --email "test@returntocorp.com" "$@" || bento_result=$?

  # https://github.com/returntocorp/bento/tree/cfcd3ef#exit-codes
  # exit codes other than 0/1/2 indicate a malfunction 
  if [[ $bento_result -ge 3 ]]
  then
    cat ~/.bento/last.log
    echo
    echo "== [ERROR] \`bento $*\` failed with exit code ${bento_result}"
    echo
    echo "This is an internal error, please file an issue at https://github.com/returntocorp/bento/issues/new/choose"
    echo "and include the log output from above."
    exit $bento_result
  fi

  return $bento_result
}


main() {
  echo "== environment: $($bento_path --version), $(python --version), $(docker --version)"

  bento init &> /dev/null
  sed -i "s@returntocorp/sgrep:0\.4\.6@returntocorp/sgrep:latest@" /usr/local/lib/python3.8/site-packages/bento/extra/r2c_check_registry.py
  sed -i "s@https://r2c.dev/default-r2c-checks@https://sgrep.live/c/$1@" /usr/local/lib/python3.8/site-packages/bento/extra/r2c_check_registry.py
  bento check --all --tool r2c.registry.latest
}

main $1
