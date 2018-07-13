autoload -Uz add-zsh-hook
function flash-iterm-profile () {
    # Temporarily changes iTerm profile until the next command line prompt
    #
    # Args:
    # $1 - Name of the profile we're switching to; defaults to the original profile loaded
    PROFILE=${1:-$ITERM_PROFILE}

    if [[ "$PROFILE" == $ITERM_PROFILE ]]; then
        # Add a hook to switch back to the default profile on the next prompt
        add-zsh-hook -d precmd flash-iterm-profile
    else
        # Remove hook to switch back to the default profile on the next prompt
        add-zsh-hook precmd flash-iterm-profile
    fi
    echo -e "\033]50;SetProfile=$PROFILE\a"
}

function color-docker (){
    if [[ "$*" =~ " -it " || ("$*" =~ " -i "  && "$*" =~ " -t ")]]; then
        flash-iterm-profile Docker
    fi

    disable -a docker
    docker $*
}

function color-docker-compose (){
    if [[ "$1" == "exec" || "$1" == "run" ]]; then
        flash-iterm-profile Docker
    fi

    disable -a docker-compose
    docker-compose $*
}

function color-ssh (){
    flash-iterm-profile ssh
    disable -a ssh
    ssh $*
}

alias fip="flash-iterm-profile"
alias ssh="color-ssh"
alias docker="color-docker"
alias docker-compose="color-docker-compose"
