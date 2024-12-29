#!/usr/bin/env bash

# shellcheck disable=SC2154  # arguments are handled by argc
set -e

export AICHAT_ROLES_DIR="$HOME/.config/configent/prompts/assistant"

# @cmd Lists available roles
# @env LLM_OUTPUT=/dev/stdout List of available roles
get_roles() {
  echo "List of all roles available:" >>"$LLM_OUTPUT"
  aichat --list-roles >>"$LLM_OUTPUT"
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
