typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent zsh-autosuggestions)
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias zshupdate="source ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tupdate="pkg upgrade -y"
alias evim="vim .vimrc"
alias upvim="source ~/.vimrc"
alias gita="git add ."
alias gitc="git commit -S -m"
alias gitcc="git checkout"
alias gitps="git push -u origin"
alias gitm="git merge"
alias gitp="git pull"
alias tmuxl="tmux new -s master -n tmux"
alias cbackup="rclone sync -P badbox:local_android mega:android"
alias servedlna="rclone serve dlna --name rclone_dlna --fast-list --dir-cache-time 48h --vfs-read-chunk-size 32M --vfs-read-chunk-size-limit 2G --buffer-size 1G --drive-chunk-size 512M --vfs-cache-mode full --log-level INFO --bwlimit 8.5M:off --stats 1m $1"

export API_NTFY=XlainRoot93

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

vit() {
    tstmux=$(tmux ls &> /dev/null)
    if [[ $? -eq 0 ]]; then 
        tmux rename-window "$(basename $PWD):$(basename $1)"
        vim "$1"
    else
        vim $1
    fi
}
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

crypt() {
    fun_name=$0
    arr=($@)
    for i in ${arr[@]}; do
        echo "Executing mgcrypt:${i}..."
        rclone move -P badbox:badbox/${i} dropbox:pics/${i}
        echo -e "\n"
    done
    msg_api
}

busca() {grep -Ehin "$1" ~/git/linux_conf/songs/*.txt}

find1() {find "$1" -type f -regextype egrep -iregex ".*\.(sh|py|txt|md|([a-z|[:punct:]]+(rc|conf)))$" -exec grep --color=always -"$2" "${@:3:10}" {} \;}

gitlsf() {rclone lsf mega:music/${1} | grep -Eiv '.*\.lrc$' | sort > ~/git/linux_conf/songs/${1}\.txt}

gitappend() {
    # this function call a git_lsf
    if [[ -z $1  ]]; then
        echo "¡Is empty!"
    else
        case $1 in
            rock|chidas|romanticas) gitlsf $1;;
            *) echo "¡Invalid option!";;
        esac
    fi
}

msg_api() {
    curl \
    -H "Title: ${fun_name}" \
    -H "Priority: Urgent" \
    -d "Done!" \
    ntfy.sh/${API_NTFY} > /dev/null 2>&1
}

pocox6() {
    fun_name=$0
    for dir in Camera Screenshots ScreenRecorder; do
        rclone copy -P --transfers 1 storage/dcim/${dir} mega:img/pocox6/${dir}
    done
    msg_api
}

termux_back() {
    tar -cvzf /sdcard/termux-backup.tar.gz -C /data/data/com.termux/files ./home ./usr
}

export GPG_TTY=$(tty)
