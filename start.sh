#!/bin/bash
set -e

# When docker restarts, this file is still there,s
# so we need to kill it just in case
[ -f /tmp/.X99-lock ] && rm -f /tmp/.X99-lock

_kill_procs() {
  kill -TERM $node
}

# Relay quit commands to processes
trap _kill_procs SIGTERM SIGINT


export DISPLAY=:10

dumb-init -- node ./build/index.js $@ &
node=$!

wait $node
