#!/usr/bin/env bash

scriptPath="$(dirname "$0")/../commit-msg"

runTest() {
  testName="$1"
  commitMessage="$2"
  expectExitCode="$3"

  commitMessageFile=$(mktemp)
  outputFile=$(mktemp)

  echo -n "RUN  $testName "

  "$scriptPath" "$commitMessageFile" >"$outputFile"
  exitCode="$?"

  if ((expectExitCode == exitCode)); then
    echo -e "\rPASS $testName "
    rm "$commitMessageFile" "$outputFile"
  else
    echo -e "\rFAIL $testName $?"
    echo "  Commit Message: $commitMessage"
    echo "  Script Output: $(cat $outputFile)"
    echo "  Expected Exit Code: $expectExitCode"
    echo "  Actual Exit Code:   $?"
    rm "$commitMessageFile" "$outputFile"
  fi
}

runTest 'no args' "" 1
runTest 'missing colon' "feet 12345" 1
runTest 'missing colon with scope' "feet(red) 12345" 1
runTest 'invalid type' "feet: 12345" 1
runTest 'message too short' "feat: 1234" 1
runTest 'scope too short' "feat(hi): 12345" 1
runTest 'invalid scope' "feat(hi there): 12345" 1
runTest 'space after colon' "feat(clippy): this is fine" 1
runTest 'no space after colon' "feat(clippy):this is fine too" 1
