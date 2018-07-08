function tabc() {
    if [[ -z $DEFAULT_ITERM_PROFILE ]]; then
        default_profile=$DEFAULT_ITERM_PROFILE
    else
        default_profile='Default'
    fi
    NAME=$1; if [ -z "$NAME" ]; then NAME=$DEFAULT_ITERM_PROFILE; fi
    # if you have trouble with this, change
    # "Default" to the name of your default theme
    echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    if [[ -z $DEFAULT_ITERM_PROFILE ]]; then
        default_profile=$DEFAULT_ITERM_PROFILE
    else
        default_profile='Default'
    fi
    echo -e "\033]50;SetProfile=$NAME\a"
}

function colordocker(){
    if [[ "$*" =~ " -it "]]; then
        trap "tab-reset" INT EXIT
        tabc Docker
    fi
    docker $*
}

function color-docker-compose(){
    if [[ "$1" =~ "exec"]]; then
        trap "tab-reset" INT EXIT
        tabc Docker
    fi
    docker-compose $*
}
compdef _ssh tabc=ssh

alias ssh="colorssh"
alias docker="colordocker"
alias docker-compose="color-docker-compose"
