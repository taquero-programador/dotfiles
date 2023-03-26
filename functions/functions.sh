#!/bin/bash

# tmux function to create session
tmx_call() {
    tmux new -d -s debian -n vim
    tmux new-window -n "git&comamnds" \; split-window -v
    tmux new-window -n ncmpcpp
    tmux send-keys -t debian:ncmpcpp.0 "ncmpcpp" ENTER
    tmux a -t debian:ncmpcpp
}

# function eval to create tmux session
tmx() {
    tmux ls &> /dev/null
    if [[ $? -ne 0 ]]; then
        tmx_call
    elif tmux ls | grep -i "debian" &> /dev/null; then
        tmux a -t debian
    fi
}
