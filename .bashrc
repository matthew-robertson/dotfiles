lint() {
    local OPTIND lntr
    local OPTIND fltr
    fltr=$({ git diff --name-only '*.py' ; git diff --name-only --staged '*.py'; } | sort | uniq )

    while getopts ":fbus" option; do
        case $option in
            f) lntr=flake8 ;;
            b) lntr=black ;;
            u) fltr=$(git diff --name-only '*.py') ;;
            s) fltr=$(git diff --name-only --staged '*.py') ;;
            ?) echo "invalid option: $OPTARG"; return 1 ;;
        esac
    done
    $lntr $fltr
}

alias flint="lint -f"
alias blint="lint -b"
alias gits="git status"
alias gitb="git branch"
