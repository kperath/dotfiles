#!/usr/bin/env bash
#
# fzf session picker — used by tmux (display-popup) and zsh (Ctrl+G).
# Preview shows the live screen of the highlighted session.
# Usage: tmux-session-picker.sh [switch|attach|print]
#   switch — switch-client (inside tmux)
#   attach — attach-session (outside tmux)
#   print  — just print the chosen session name (zsh widget attaches itself)
mode="${1:-switch}"

# Only hide the current session when switching from inside tmux.
if [[ "$mode" == "switch" && -n "$TMUX" ]]; then
  current=$(tmux display-message -p '#{session_name}' 2>/dev/null)
else
  current=""
fi

session=$(tmux ls -F '#{session_last_attached} #{session_name}' 2>/dev/null | sort -rn | awk '{print $2}' | grep -vFx "$current" | fzf \
  --reverse \
  --prompt='session> ' \
  --preview='echo "── windows ──"; tmux list-windows -t {} -F "  #{window_index}: #{window_name}#{?window_active, *,}"; echo; echo "── screen ──"; tmux capture-pane -ep -t {}' \
  --preview-window=right:65%)

[[ -z "$session" ]] && exit 0

case "$mode" in
  attach) tmux attach-session -t "$session" ;;
  print)  printf '%s' "$session" ;;
  *)      tmux switch-client -t "$session" ;;
esac

