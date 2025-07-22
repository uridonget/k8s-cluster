#!/bin/bash

DEFAULT_NODES=3
MAX_NODES=5
N=${1:-$DEFAULT_NODES}

if ! [[ "$N" =~ ^[0-9]+$ ]] || [ "$N" -lt 3 ] || [ "$N" -gt "$MAX_NODES" ]; then
  echo "Error: Invalid number of nodes."
  echo "Please provide a number between 3 and $MAX_NODES."
  exit 1
fi

export VAGRANT_VM_COUNT=$N

rm -f ~/.ssh/known_hosts

vagrant up
