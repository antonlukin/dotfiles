umask 2

# Files to ignore during completion
fignore=(DS_Store $fignore)

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

export EDITOR=vim
alias v="vim"

alias ll="ls -la --color=yes"
alias l="ls --color=yes"
alias ll="ls -FHal --color=yes"


bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

HISTFILE=~/.history
HISTSIZE=10500
SAVEHIST=10000
SHARE_HISTORY=1
EXTENDED_HISTORY=1
HIST_EXPIRE_DUPS_FIRST=1

zstyle ':completion:*' completer _expand _complete

autoload -Uz compinit
compinit


autoload -Uz colors
colors

setopt prompt_subst

local current_dir='${PWD/#$HOME/~}'

GIT_PROMPT_CLEAN="%{$fg_bold[green]%}-"
GIT_PROMPT_AHEAD="%{$fg_bold[yellow]%}> NUM"
GIT_PROMPT_BEHIND="%{$fg_bold[yellow]%}< NUM"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}Y"
GIT_PROMPT_UNTRACKED="${fg_alert}!"
GIT_PROMPT_MODIFIED="${fg_alert}+"
GIT_PROMPT_STAGED="%{$fg_bold[blue]%}="


PROMPT="%B%T%b %{$fg[magenta]%}%n%{$fg[white]%}@%{$fg[cyan]%}$HOST \
%{$fg[white]%}[%{$fg[yellow]%}${current_dir}%{$fg[white]%}] \
%(?.%F{white}.%F{red})› %f"

RPS1='$(git_prompt_string)'


function parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function parse_git_state() {
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"

    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi

    if [ -z "$(git status --porcelain)" ]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_CLEAN
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_STATE"
    fi
}

function git_prompt_string() {
    local git_where="$(parse_git_branch)"

    if [ -n "$git_where" ]; then
		echo "[%{$fg[yellow]%}${git_where#(refs/heads/|tags/)} $(parse_git_state)%{$reset_color%}] ";
	fi
}

