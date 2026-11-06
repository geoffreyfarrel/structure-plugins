#!/usr/bin/env bash
# code-mentor context hook (SessionStart and UserPromptSubmit).
# When mentor mode is on, prints a short reminder that Claude adds to its context.
# Prints nothing when the session file is missing or inactive.

set -u

session_file="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/code-mentor.local.md"
[ -f "$session_file" ] || exit 0

# Read one key from the YAML frontmatter (between the first two --- lines).
field() {
  awk -v key="$1" '
    /^---[[:space:]]*$/ { fences++; next }
    fences == 1 && index($0, key ":") == 1 {
      sub("^" key ":[[:space:]]*", "")
      gsub(/^"|"$/, "")
      print
      exit
    }
    fences >= 2 { exit }
  ' "$session_file"
}

[ "$(field active)" = "true" ] || exit 0

goal="$(field goal)"
step="$(field current_step)"

echo "code-mentor: mentor mode is ON. Use the guided-coding skill: guide the user, do not write their project code."
echo "  Goal: ${goal:-not set}. Current step: ${step:-1}. Plan and notes: .claude/code-mentor.local.md"
