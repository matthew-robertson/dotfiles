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


alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias journal='vim ~/LabJournal/$(date "+%Y-%m-%d").md'

# Set up prompt
gb() {
        echo -n '(' && git symbolic-ref HEAD --short 2>/dev/null | tr -d '\n' && echo  -n ')'
}
git_branch() {
        gb | sed 's/()//'
}

gitcolor() {
  [[ -n $(git status --porcelain=v2 2>/dev/null) ]] && echo 31 || echo 32
}

export PS1="\u@\[\033[37m\]\w\[\033[\$(gitcolor)m\] \$(git_branch)\[\033[00m\]\$ "
