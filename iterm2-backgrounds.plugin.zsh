function tabc() {
    NAME=$1; if [ -z "$NAME" ]; then NAME=$ITERM_PROFILE; fi
    # if you have trouble with this, change
    # "Default" to the name of your default theme
    echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    tabc $ITERM_PROFILE
}

function colordocker(){
    if [[ "$*" =~ " -it " ]] || if [[ "$*" =~ " -i "  && "$*" =~ " -t "]]; then
        trap "tab-reset" INT TERM
        tabc Docker
    fi
    docker $*
    tab-reset
}

function color-docker-compose(){
    if [[ "$1" == "exec" ]] || [[ "$1" == "run" ]] || if [["$*" =~ " -i "  && "$*" =~ " -t "]]; then
        trap "tab-reset" INT TERM
        tabc Docker
    fi
    docker-compose $*
    tab-reset
}

function colorssh(){
    trap "tab-reset" INT TERM
    tabc ssh
    ssh $*
    tab-reset
}

alias ssh="colorssh"
alias docker="colordocker"
alias docker-compose="color-docker-compose"
