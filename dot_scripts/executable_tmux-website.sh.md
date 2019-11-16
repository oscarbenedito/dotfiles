# File `tmux-website.sh`
This file is a script to automatically open the needed programs to work on my website.

## File description
Setting up varibles and keyboard setup.
```bash file executable_tmux-website.sh
#!/bin/bash
SESSION=$USER
setxkbmap es
```

Create a new tmux session.
```bash file executable_tmux-website.sh
tmux -2 new-session -d -s $SESSION
```

Create a new window called `hugo` and run `hugo server` in it.
```bash file executable_tmux-website.sh
tmux new-window -t $SESSION:1 -n 'hugo'
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "hugo server" C-m
```
In the window number 0, open the folder with Atom and open the local server on Firefox.
```bash file executable_tmux-website.sh
tmux select-window -t $SESSION:0
tmux send-keys "cd ~/Git/obenedito.org" C-m
tmux send-keys "atom . &" C-m
tmux send-keys "firefox http://localhost:1313/ &" C-m
```

Finally, we attach to the session.
```bash file executable_tmux-website.sh
tmux -2 attach-session -t $SESSION
```
