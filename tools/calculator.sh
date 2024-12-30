#!/usr/bin/env bash
set -e

# @describe Use calculator
# @option --expression! Expression
# @env LLM_OUTPUT=/dev/stdout The output path
main() {
    echo "$argc_expression" | bc >> "$LLM_OUTPUT"
}

eval "$(argc --argc-eval "$0" "$@")"
