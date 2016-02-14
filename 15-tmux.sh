# tmux auto attach
function tmux-auto-attach(){
  if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
    if ( tmux has-session ); then
      session=`tmux -2 list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]\+\).*$/\1/'`
      if [ -n "$session" ]; then
        echo "Attache tmux session $session."
        tmux -2 attach-session -t $session
      else
        echo "Session has been already attached."
        tmux -2 list-sessions
      fi
    else
      echo "Create new tmux session."
      tmux -2
    fi
  fi
}

# create tmux config from screen user
screen2tmuxconf(){

cat << EOF
# Unbind existing tmux key bindings (except 0-9).
set -s escape-time 0
set -g status-left-length 20
setw -g aggressive-resize on

# There is a bug in tmux, it's supposed
# to be spelled "color" but you need
# an extra u for some reason here.
setw -g mode-bg colour153

# Set the prefix to ^A.
unbind C-b
set -g prefix ^A
bind a send-prefix

# Change the copy mode keybinding.
#unbind [
#bind Escape copy-mode

# Bind appropriate commands similar to screen.
# lockscreen ^X x
unbind ^X
bind ^X lock-server
unbind x
bind x lock-server

# screen ^C c
unbind ^C
bind ^C new-window
#bind c
bind c new-window

# detach ^D d
unbind ^D
bind ^D detach

# displays *
unbind *
bind * list-clients

# next ^@ ^N sp n
unbind ^@
bind ^@ next-window
unbind ^N
bind ^N next-window
unbind " "
bind " " next-window
unbind n
bind n next-window

# title A
unbind A
bind A command-prompt "rename-window %%"

# other ^A
unbind ^A
bind ^A last-window

# prev ^H ^P p ^?
unbind ^H
bind ^H previous-window
unbind ^P
bind ^P previous-window
unbind p
bind p previous-window
unbind BSpace
bind BSpace previous-window

# windows ^W w
unbind ^W
bind ^W list-windows
unbind w
bind w list-windows

# quit \
unbind \
bind \ confirm-before "kill-server"

# kill K k
unbind K
bind K confirm-before "kill-window"
unbind k
bind k confirm-before "kill-window"

# redisplay ^L l
unbind ^L
bind ^L refresh-client
unbind l
bind l refresh-client

# More straight forward key bindings for splitting
unbind %
bind | split-window -h
bind v split-window -h
unbind '"'
bind - split-window -v
bind h split-window -v

# History
set -g history-limit 1000

# Pane
#unbind o
#bind C-s down-pane

# Terminal emulator window title
set -g set-titles off
#set -g set-titles-string '#S:#I.#P #W'

# Status Bar
set -g status-bg black
set -g status-fg white
set -g status-interval 1
# There is a bug in tmux, it's supposed
# to be spelled "color" but you need
# an extra u for some reason here.
set -g status-left '#[fg=colour153][#[fg=white]#H#[fg=colour153]]'
set -g status-right '#[default]#[fg=colour153][#[fg=white] %Y-%m-%d %H:%M #[fg=colour153]]#[default]'

# Notifying if other windows has activities
setw -g monitor-activity off
set -g visual-activity off

# Highlighting the active window in status bar
#setw -g window-status-current-bg white
setw -g window-status-current-fg colour153

# Clock
setw -g clock-mode-colour red
setw -g clock-mode-style 24

# :kB: focus up
#unbind Tab
#bind Tab down-pane
#unbind BTab
#bind BTab up-pane

# " windowlist -b
unbind '"'
bind '"' choose-window
# spawn windows
#neww -n rt
#neww -n irc
EOF

echo
echo "cp ~/.tmux.{conf,conf.old}"
echo
}
