#!/bin/bash

# echo ""
# echo "Setting up NPM and Dockerfile_lint..."
# echo ""
#
# apt-get update &>/dev/null
# apt-get install nodejs -y
# apt-get install npm -y
# ln -s "$(which nodejs)" /usr/bin/node
# npm install -g dockerfile_lint

echo ""

echo "Running Dockerfile lints..."
echo ""

find -name "Dockerfile" > out.tmp

failed="false"

while read lints; do
  echo ""
  echo ">>> Testing Dockerfile in $lints."

  dockerfile_lint -f $lints -r ./specs/extended_env.yaml

  if [[ $? -eq 0 ]] ; then
    echo ""
    echo ">>> Test passed for $lints."
  else
    echo ""
    echo ">>> Test FAILED for $lints."
    failed="true"
  fi

done <$(pwd)/out.tmp

if echo "$failed" | grep true &>/dev/null; then
  echo ">>> Some Dockerfile lints failed - address issues in tests."
  exit 1
else
  echo ">>> Dockerfile lints passed - releasing for build."
fi
