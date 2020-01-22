#!/bin/bash

SESSION=$USER

# New tmux session
tmux -2 new-session -d -s $SESSION

# New window called Hugo running 'hugo server' in website folder
tmux new-window -t $SESSION:1 -n 'hugo'
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "hugo server" C-m

# Back to window #0, open file with atom, run local server and open it on firefox
tmux select-window -t $SESSION:0
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "atom . &" C-m
tmux send-keys "firefox http://localhost:1313/ &" C-m

# Attach session
tmux -2 attach-session -t $SESSION
