#!/bin/bash
# Merges commits on a release branch back to the next release branch or master
next_release_branch() {
  YEAR=$(sed -E 's/rel_([0-9]{4})[0-9]{2}/\1/' <<< "$1")
  MONTH=$(sed -E 's/rel_[0-9]{4}([0-9]{2})/\1/' <<< "$1")
  NEXT=$(date -d "$YEAR-$MONTH-01+1month" "+%Y%m")
  echo "rel_$NEXT"
}

branch_exists() {
  git show-ref --verify --quiet refs/heads/$1 || git fetch --dry-run origin $1
}

fetch_next_release_or_master() {
  NEXT_RELEASE=$(next_release_branch $1)
  for try in 1 2; do
    if branch_exists $NEXT_RELEASE; then
      break
    else
      NEXT_RELEASE=$(next_release_branch $NEXT_RELEASE)
    fi
  done
  if branch_exists $NEXT_RELEASE; then
    echo $NEXT_RELEASE
  else
    echo 'master'
  fi
}

cd $HOME/$CIRCLE_PROJECT_REPONAME
git config --global user.email "circleci@roqua.nl"
git config --global user.name "CircleCi"
git config --global push.default simple
git checkout .
git fetch
BASE=$(fetch_next_release_or_master $CIRCLE_BRANCH)
git checkout $BASE
git pull --quiet --no-edit
# make sure to return git exit code
git merge --no-edit $CIRCLE_BRANCH && git push && git checkout $CIRCLE_BRANCH
