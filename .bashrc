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

# If it doesn't already exist, create a file ($2) of type ($3) from its template ($1)
file_from_template() {
  if [ ! -f "$2" ]
  then
    echo "No $3 entry present, initializing from template"
    if [ -f "$1" ]
    then
      cp "$1" "$2"
    else
      echo "No $3 template available, starting a blank entry."
      touch "$2"
    fi
    echo "----------------------------------------"
  fi
}

j_init() {
  journalDIR=~/LabJournal
  dailyFile="$journalDIR/dailies/$(date '+%Y-%m-%d').md" 
  weeklyFile="$journalDIR/weeklies/$(date '+%Y-week%U').md" 
  monthlyFile="$journalDIR/monthlies/$(date '+%Y-%m').md" 
    
  # Initialize journalling folder if not present
  if [ ! -d "$journalDIR" ];
  then
    echo "No journal present, starting one."
    mkdir "$journalDIR"
    mkdir "$journalDIR/monthlies"
    mkdir "$journalDIR/weeklies"
    mkdir "$journalDIR/dailies"
    echo "----------------------------------------"
  fi

  # Start a new journal entries if necessary
  file_from_template "$journalDIR/monthly_template.md" "$monthlyFile" "monthly"
  file_from_template "$journalDIR/weekly_template.md" "$weeklyFile" "weekly"
  file_from_template "$journalDIR/daily_template.md" "$dailyFile" "daily"

  # Open the journal entries
  vim -o "$dailyFile" "$weeklyFile" "$monthlyFile" -c "wincmd H"
}
alias journal='j_init'

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
