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

# Enable password-free `git pull`
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

git pull
jekyll build --destination "$DEST"
