#!/usr/bin/bash
set -euo pipefail

# Show usage and exit
usage() {
  cat <<EOF
Usage: $0 [REMOTE_HOST]
Trigger a rebuild via webhook POST.

  REMOTE_HOST   host[:port] serving your webhook endpoint
                (default: blog.shelpa.me:9001)

Examples:
  $0                 # posts to http://blog.shelpa.me:9001/webhook
  $0 example.com:1234
  $0 -h              # show this help
EOF
  exit 0
}

# If help flag given, show usage
if [[ "${1:-}" == "-h" ]]; then
  usage
fi

# Otherwise take first arg as REMOTE_HOST, or default
REMOTE_HOST="${1:-blog.shelpa.me:9001}"

# Fire the webhook
curl --fail --show-error --silent \
     -X POST "http://${REMOTE_HOST}/webhook" >/dev/null \
     && echo "Webhook POST to ${REMOTE_HOST}/webhook succeeded."
