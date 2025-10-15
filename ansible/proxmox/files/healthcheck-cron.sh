#!/bin/bash -e

## Dir: /etc/cron.weekly/healthcheckio.sh 

## Configuration, run:
# sudo chown root:root /etc/cron.weekly/healthcheck_io.sh
# sudo chmod 755 /etc/cron.weekly/healthcheck_io.sh

HEALTHCHECK_ID="$1"

# Set to the URL of your healthchecks.io check
HEALTHCHECK_URL="https://hc-ping.com/${ID}"

# Set terminal to "dumb" if not set (cron compatibility)
export TERM=${TERM:-dumb}

# always exit on error
set -e

curl -fsS -m 10 --retry 5 -o /dev/null "$HEALTHCHECK_URL"
