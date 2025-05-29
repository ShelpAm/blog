#!/usr/bin/bash

usage() {
  echo 'usage:  deploy.sh <destination>'
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

DEST="${1}"

echo "Deploying to $DEST"

git pull
jekyll build --destination "$DEST"
