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

templatesDir="$HOME/.git-templates"

currentTemplateDirConfig=$(git config --global init.templatedir)

if [ -n "$currentTemplateDirConfig" ] && [ "$currentTemplateDirConfig" != "$templatesDir" ] && ((force != 1)); then
  >&2 echo "error: not overwriting git's current init.templatedir: $currentTemplateDirConfig"
  >&2 echo "use the -f flag to overwrite git's current init.templatedir."
  exit 1
fi

hookDir="$templatesDir/hooks"

mkdir -p "$hookDir"

git config --global init.templatedir "$templatesDir"

cp "$(dirname "$0")/commit-msg" "$hookDir"

exit 0
