#!/usr/bin/env bash

# shellcheck disable=SC2154  # arguments are handled by argc
set -e

export AICHAT_ROLES_DIR="$HOME/.config/configent/prompts/assistant"

# @cmd Get available roles and their documentation
# @env LLM_OUTPUT=/dev/stdout The output path
get_roles() {
  echo "You have these roles available:" >>"$LLM_OUTPUT"
  AICHAT_ROLES_DIR="$HOME/.config/configent/prompts/developer" \
    aichat --list-roles >>"$LLM_OUTPUT"

  echo "Select the correct role based on its documented use:" >>"$LLM_OUTPUT"
  cat "$HOME/.config/configent/prompts/developer.md" >>"$LLM_OUTPUT"
}

# @cmd Executes the given role
# @option --role! Role to execute
# @option --task Task to execute
execute_role() {
  local context="${PWD##*/}"

  # handle built-in aichat roles
  case "$argc_role" in
  code | create-prompt | explain-shell | shell)
    argc_role="%$argc_role%"
    printf "Matching built-in role %s\n\n" "$argc_role"
    ;;
  esac

  aichat --role "$argc_role" --session "$context" "$argc_task"
}

eval "$(argc --argc-eval "$0" "$@")"
