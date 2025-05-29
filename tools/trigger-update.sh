#!/usr/bin/bash

REMOTE_HOST=${REMOTE_HOST:-$1}

if [ $# -lt 1 ]; then
    echo "Usage: $0 REMOTE_HOST"
    echo For instance, $0 blog.shelpa.me:9001
fi

curl -X POST "${REMOTE_HOST}/webhook"
