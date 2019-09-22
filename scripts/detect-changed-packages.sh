#!/bin/bash

# return changed directories as +(DIR1|DIR2|...)

TEST_FILE='index.spec.js'

function join_by { local IFS="$1"; shift; echo "$*"; }

# for branch build
# COMMIT_RANGE='5ba6ddb9a476...7caa65411ea1'
changes=$(git --no-pager diff --name-only $TRAVIS_COMMIT_RANGE)

# for merge build
# changes=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | cut -d"/" -f1 | sort -u)
# changes=$(git --no-pager diff --name-only master $(git merge-base FETCH_HEAD master) | cut -d"/" -f1 | sort -u)
# echo "changes=$changes"

# only consider changes if it's directory
result=()
for change in $changes
do
  [[ -d $change ]] && result="${result[@]} ${change}"
done

# find other packages that depend on the changes
for c in $changes
do
  others=$(find . -type f -not \( -path .git -prune \) -not \( -path node_modules -prune \) -name "$TEST_FILE" | xargs grep -l "$c" | cut -d"/" -f2 | sort -u)
  result=("${result[@]} ${others}")
done

# result=( "${result[@]} package1")
result=$(echo "$result" | tr [:space:] '\n' | sort -u)
[[ -z "${result// }" ]] && result="spec"
echo "+($(join_by "|" $result))"