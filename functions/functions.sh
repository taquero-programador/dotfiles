# constructor
tmx_call() {
    tmux new -d -s debian -n vim
    tmux new-window -n "git&comamnds" \; split-window -v
    tmux new-window -n ncmpcpp
    tmux send-keys -t debian:ncmpcpp.0 "ncmpcpp" ENTER
    tmux a -t debian:ncmpcpp
}

tmx() {
    # save name of session if exists
    session_name=$(tmux ls &> /dev/null | grep -io "debian")
    # save if session is now attached
    session_att=$(tmux ls &> /dev/null | grep -io "attached")
    # var saved in $? (code exit)
    test_tmx=$(tmux ls &> /dev/null) # is a same to tmux ls &> /dev/null without $()

    # if $? is not equal to 0, create session
    if [[ ! $? -eq 0 ]]; then
        echo "Creating session..."
        sleep 1
        tmx_call
    # $session_name is not empty
    elif [[ -n $session_name ]]; then
        # two vars compare
        if [[ $session_name = "debian" && $session_att = "attached" ]]; then
            # show info
            echo -e "$(tmux ls)\nSession in use! Try: tmux a -t $session_name"
        # session exists, but no attached
        elif [[ $session_name = "debian" && -z $session_att ]]; then
            echo "Attach to $session_name..."
            sleep 1
            tmux a -t $session_name
        fi
    fi
}
