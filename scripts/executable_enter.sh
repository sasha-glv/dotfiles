#!/bin/zsh

TMUX=$(command -v tmux)
SESSION_NAME="main"
if [[ -n $TMUX ]]; then
	$TMUX -CC new -A -s $SESSION_NAME
fi

