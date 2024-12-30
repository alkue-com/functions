#!/usr/bin/env bash
set -e

# @describe Perform computation
# @option --expression! Expression
# @env LLM_OUTPUT=/dev/stdout The output path
main() {
    numbat --expression "$argc_expression" >> "$LLM_OUTPUT"
}

eval "$(argc --argc-eval "$0" "$@")"
