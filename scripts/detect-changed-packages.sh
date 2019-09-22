# return changed directories as +(DIR1|DIR2|...)

TEST_FILE='index.spec.js'

function join_by { local IFS="$1"; shift; echo "$*"; }

changes=$(git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master) | cut -d"/" -f1 | sort -u)
# changes=$(git --no-pager diff --name-only master $(git merge-base FETCH_HEAD master) | cut -d"/" -f1 | sort -u)
echo "changes=$changes"

# only consider changes if it's directory
result=()
for change in $changes
do
  [[ -d $change ]] && result="${result[@]}\n${change}"
done

# find other packages that depend on the changes
for c in $changes
do
  others=$(find . -type f -not \( -path .git -prune \) -not \( -path node_modules -prune \) -name "$TEST_FILE" | xargs grep -l "$c" | cut -d"/" -f2 | sort -u)
  result=( "${result[@]}\n${others}")
done

# result=( "${result[@]}\npackage1")
result=$(echo "$result" | sort -u)
echo "+($(join_by "|" $result))"