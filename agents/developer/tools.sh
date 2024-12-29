#!/usr/bin/env bash

# shellcheck disable=SC2154  # arguments are handled by argc
set -e

# @cmd Get available roles and their documentation
# @env LLM_OUTPUT=/dev/stdout The output path
get_roles() {
  echo "You have these roles available:" >>"$LLM_OUTPUT"
  AICHAT_ROLES_DIR="$HOME/.config/configent/prompts/developer" \
    aichat --list-roles >>"$LLM_OUTPUT"

  echo "Select the correct role based on its documented use:" >>"$LLM_OUTPUT"
  cat "$HOME/.config/configent/prompts/developer.md" >>"$LLM_OUTPUT"
}

# @cmd Execute role
# @option --role! Role
execute_role() {
  AICHAT_ROLES_DIR="$HOME/.config/configent/prompts/developer" \
    aichat --role="$argc_role"
}

eval "$(argc --argc-eval "$0" "$@")"
