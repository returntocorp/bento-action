#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

bento_path=$(which bento)

bento() {
  bento_result=0
  $bento_path --agree --email "${INPUT_ACCEPTTERMSWITHEMAIL}" "$@" || bento_result=$?

  if [[ "$1" == "check" ]]
  then
    ./bento-monitor "$bento_result" --slack-url "${INPUT_SLACKWEBHOOKURL}" || true
  fi

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

handle_pull_request() {
  # the github ref would be `refs/pull/<pr #>/merge` which isn't known by name here
  # the github sha seems to refer to the base on re-runs
  # so we keep our own head ref around
  real_head_sha=$(git rev-parse HEAD)

  echo
  echo "== [1/3] going to go back to the commit you based your pull request on…"
  echo
  git checkout "${GITHUB_BASE_REF}"
  git status --branch --short

  echo
  echo "== [2/3] …now adding your pull request's changes back…"
  echo

  git checkout "${real_head_sha}" -- .
  git status --branch --short

  echo
  echo "== [3/3] …and seeing if there are any new findings!"
  echo
  bento init &> /dev/null
  bento check
}

handle_push() {
  echo
  echo "== seeing if there are any findings"
  echo
  bento init &> /dev/null
  bento check --all
}

handle_unknown() {
  echo "== [ERROR] the Bento Check action was triggered by an unsupported GitHub event."
  echo
  echo "This error is often caused by an unsupported value for `on:` in the action's configuration."
  echo "To resolve this issue, please confirm that the `on:` key only contains values from the following list: [pull_request, push]."
  echo "If the problem persists, please file an issue at https://github.com/returntocorp/bento/issues/new/choose"
  exit 2
}

check_prerequisites() {
  if ! [[ -v GITHUB_ACTIONS ]]
  then
    echo "== [WARNING] this script is designed to run via GitHub Actions"
  fi

  if ! [[ -v INPUT_ACCEPTTERMSWITHEMAIL ]]
  then
    echo "== [ERROR] you must accept the Bento Terms of Service in the workflow configuration, like so:"
    echo
    echo ".github/workflows/bento.yml"
    echo "---------------------------"
    echo
    echo "      [...]"
    echo "      uses: returntocorp/bento-action@v1"
    echo "      with:"
    echo "        acceptTermsWithEmail: <add your email here>"
    exit 2
  fi
}

main() {
  echo "== action's environment: $($bento_path --version), $(python --version), $(docker --version)"

  check_prerequisites
  echo "== triggered by a ${GITHUB_EVENT_NAME}"

  case ${GITHUB_EVENT_NAME} in
    pull_request)
      handle_pull_request
      ;;

    push)
      handle_push
      ;;

    *)
      handle_unknown
      ;;
  esac
}

main
