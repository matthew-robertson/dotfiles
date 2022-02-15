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

journalDIR=~/LabJournal
j_init() {
  
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
  ## Monthly Entry
  if [ ! -f "$journalDIR/monthlies/$(date '+%Y-%m').md" ]
  then
    echo "No monthly entry present, initializing from template"
    if [ -f "$journalDIR/monthly_template.md" ]
    then
      cp "$journalDIR/monthly_template.md" "$journalDIR/monthlies/$(date '+%Y-%m').md"
    else
      echo "No monthly template available, starting a blank entry."
      touch "$journalDIR/dailies/$(date '+%Y-%m').md"
    fi
    echo "----------------------------------------"
  fi

  ## Weekly Entry
  if [ ! -f "$journalDIR/weeklies/$(date '+%Y-week%U').md" ]
  then
    echo "No weekly entry present, initializing from template"
    if [ -f "$journalDIR/weekly_template.md" ]
    then
      cp "$journalDIR/weekly_template.md" "$journalDIR/weeklies/$(date '+%Y-week%U').md"
    else
      echo "No weekly template available, starting a blank entry."
      touch "$journalDIR/dailies/$(date '+%Y-week%U').md"
    fi
    echo "----------------------------------------"
  fi

  ## Daily Entry
  if [ ! -f "$journalDIR/dailies/$(date '+%Y-%m-%d').md" ]
  then
    echo "No daily entry present, initializing from template"
    if [ -f "$journalDIR/daily_template.md" ]
    then
      cp "$journalDIR/daily_template.md" "$journalDIR/dailies/$(date '+%Y-%m-%d').md"
    else
      echo "No daily template available, starting a blank entry."
      touch "$journalDIR/dailies/$(date '+%Y-%m-%d').md"
    fi
    echo "----------------------------------------"
  fi

  # Open the journal entries
  vim -o "$journalDIR/dailies/$(date '+%Y-%m-%d').md" "$journalDIR/weeklies/$(date '+%Y-week%U').md" "$journalDIR/monthlies/$(date '+%Y-%m').md" -c "wincmd H"
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
