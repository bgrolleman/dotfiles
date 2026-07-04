#!/bin/bash
# Claude Code status line
# Shows: model display name, a progress bar for context-window tokens
# remaining in this session, current git branch, active subagent (if any),
# and enabled plugins (read from ~/.claude/settings.json).

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')

# --- Colors (kept modest; Claude Code renders the status line dimmed) ---
c_model='\033[36m'   # cyan
c_bar='\033[32m'     # green
c_branch='\033[33m'  # yellow
c_agent='\033[35m'   # magenta
c_plugin='\033[34m'  # blue
c_reset='\033[0m'

# --- Git branch (skip optional locks; silent if not a repo) ---
branch=""
if [ -n "$cwd" ]; then
  branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)
fi

# --- Enabled plugins, read from settings.json (not present on stdin) ---
settings_file="$HOME/.claude/settings.json"
plugins=""
if [ -f "$settings_file" ]; then
  plugins=$(jq -r '.enabledPlugins // {} | to_entries[] | select(.value == true) | .key | split("@")[0]' "$settings_file" 2>/dev/null | paste -sd, -)
fi

# --- Context-window remaining-tokens progress bar ---
bar=""
if [ -n "$remaining" ]; then
  pct=${remaining%.*}
  [ -z "$pct" ] && pct=0
  [ "$pct" -lt 0 ] 2>/dev/null && pct=0
  [ "$pct" -gt 100 ] 2>/dev/null && pct=100
  total_blocks=10
  filled=$(( pct * total_blocks / 100 ))
  [ "$filled" -gt "$total_blocks" ] && filled=$total_blocks
  [ "$filled" -lt 0 ] && filled=0
  empty=$(( total_blocks - filled ))
  bar="["
  i=0
  while [ "$i" -lt "$filled" ]; do bar="${bar}█"; i=$((i + 1)); done
  i=0
  while [ "$i" -lt "$empty" ]; do bar="${bar}░"; i=$((i + 1)); done
  bar="${bar}] ${pct}% left"
fi

# --- Assemble the status line ---
printf "${c_model}%s${c_reset}" "$model"

if [ -n "$bar" ]; then
  printf "  ${c_bar}%s${c_reset}" "$bar"
fi

if [ -n "$branch" ]; then
  printf "  ${c_branch}git:%s${c_reset}" "$branch"
fi

if [ -n "$agent_name" ]; then
  printf "  ${c_agent}agent:%s${c_reset}" "$agent_name"
fi

if [ -n "$plugins" ]; then
  printf "  ${c_plugin}plugins:%s${c_reset}" "$plugins"
fi

printf '\n'
