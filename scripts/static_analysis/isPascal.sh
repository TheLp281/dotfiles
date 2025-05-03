#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <filename or pattern>"
    exit 1
fi

grep -n -E '\b[A-Z][a-zA-Z]*\b' "$@"
