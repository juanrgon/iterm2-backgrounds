autoload -Uz add-zsh-hook
function tabc() {
    PROFILE="${1:-$ITERM_PROFILE}"  # Name of the profile we're switching to

    if [[ "$PROFILE" == $ITERM_PROFILE ]]; then
        # Add a hook to switch back to the default profile on the next prompt
        add-zsh-hook -d preexec tabc
    else
        # Remove hook to switch back to the default profile on the next prompt
        add-zsh-hook precmd tabc
    fi
    echo -e "\033]50;SetProfile=$PROFILE\a"
}

function colordocker(){
    if [[ "$*" =~ " -it " || ("$*" =~ " -i "  && "$*" =~ " -t ")]]; then
        tabc Docker
    fi

    disable -a docker
    docker $*
}

function color-docker-compose(){
    if [[ "$1" == "exec" || "$1" == "run" ]]; then
        tabc Docker
    fi

    disable -a docker-compose
    docker-compose $*
}

function colorssh(){
    tabc ssh

    disable -a ssh
    ssh $*
}

alias ssh="colorssh"
alias docker="colordocker"
alias docker-compose="color-docker-compose"
