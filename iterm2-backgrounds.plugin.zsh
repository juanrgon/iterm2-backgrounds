function tabc() {
    if [[ -z $DEFAULT_ITERM_PROFILE ]]; then
        default_profile='Default'
    else
        default_profile=$DEFAULT_ITERM_PROFILE
    fi
    NAME=$1; if [ -z "$NAME" ]; then NAME=$default_profile; fi
    # if you have trouble with this, change
    # "Default" to the name of your default theme
    echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    if [[ -z $DEFAULT_ITERM_PROFILE ]]; then
        default_profile='Default'
    else
        default_profile=$DEFAULT_ITERM_PROFILE
    fi
    echo -e "\033]50;SetProfile=$default_profile\a"
}

function colordocker(){
    if [[ "$*" =~ " -it " ]]; then
        trap "tab-reset" INT EXIT
        tabc Docker
    fi
    docker $*
}

function color-docker-compose(){
    if [[ "$1" =~ "exec" ]]; then
        trap "tab-reset" INT EXIT
        tabc Docker
    fi
    docker-compose $*
}
alias docker="colordocker"
alias docker-compose="color-docker-compose"
