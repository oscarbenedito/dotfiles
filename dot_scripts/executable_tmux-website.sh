#!/bin/bash
SESSION=$USER

setxkbmap es
tmux -2 new-session -d -s $SESSION

# Setup window
tmux new-window -t $SESSION:1 -n 'hugo'
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "hugo server" C-m
tmux select-window -t $SESSION:0
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "atom . &" C-m
tmux send-keys "firefox http://localhost:1313/ &" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
