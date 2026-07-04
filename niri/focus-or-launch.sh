#!/bin/bash
# Focus an existing window by app-id, or launch it if not found.
# If the target window is already focused, return to the previous window.
# Usage: focus-or-launch.sh <app-id> <launch-command...>
APP_ID="$1"
shift

WINDOWS=$(niri msg -j windows)
FOCUSED_ID=$(echo "$WINDOWS" | jq -r '.[] | select(.is_focused == true) | .id')
TARGET_ID=$(echo "$WINDOWS" | jq -r --arg app "$APP_ID" '.[] | select(.app_id == $app) | .id' | head -1)

PREV_FILE="/tmp/niri-focus-prev-${APP_ID}"

if [ "$FOCUSED_ID" = "$TARGET_ID" ]; then
    if [ -f "$PREV_FILE" ]; then
        niri msg action focus-window --id "$(cat "$PREV_FILE")" 2>/dev/null || true
    fi
else
    echo "$FOCUSED_ID" > "$PREV_FILE"
    if [ -n "$TARGET_ID" ]; then
        niri msg action focus-window --id "$TARGET_ID"
    else
        exec "$@"
    fi
fi
