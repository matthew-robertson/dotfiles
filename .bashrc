# Set up Git Branch completion in case we don't have the file
if [ ! -f ~/.git-completion.bash ]; then
  echo "Downlaoding Git autocomplete script"
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
. ~/.git-completion.bash

# Quickly update dotfiles
alias bu="source ~/.bashrc"
alias bedit="vim ~/.bashrc"
alias vedit="vim ~/.vimrc"

# Dev shortcuts
alias gits="git status"
alias gitb="git branch"
alias gitde="gitb -d"
alias gitd="git diff"
__git_complete gitb _git_branch
__git_complete gitde _git_branch
__git_complete checkout _git_branch
alias gitm="git co main; git pull"
alias gitr="git rebase -i main"
alias gitur="gitm; git co -; gitr"
alias capy="bundle exec cucumber -p mac-rc -p chrome"

alias v="vim"
alias vi="vim"
alias g="grep -ri"

# Easier backtracking
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## create+use journals
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

# actually launch the daily+weekly+monthly journal for the day
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
