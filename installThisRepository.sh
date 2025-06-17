#!/usr/bin/env bash

set -eou pipefail

force=0

while getopts "f" opt; do
  case "$opt" in
  f)
    force=1
    ;;
  \?)
    echo "Invalid option"
    exit 1
    ;;
  esac
done

shift $((OPTIND - 1))

if [[ ! -d '.git' ]]; then
  >&2 echo 'This command can only be run inside the root of a git repository.'
  exit 1
fi

scriptDir="$(dirname "$0")"
commitMsgHookFile="$scriptDir/commit-msg"
repoCommitMsgHookFile="./.git/hooks/commit-msg"

if [[ -r "$repoCommitMsgHookFile" ]] && ((force != 1)); then
  >&2 echo "error: not overwriting $repoCommitMsgHookFile."
  >&2 echo "use the -f flag to overwrite this repository's commit-msg script."
  exit 1
fi

cp "$commitMsgHookFile" "$repoCommitMsgHookFile"

exit 0
