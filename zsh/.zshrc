umask 2

fignore=(DS_Store $fignore)

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

export EDITOR=vim

alias v="vim"
alias l="ls --color=yes"
alias ll="ls -FHal --color=yes"

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

GIT_PROMPT_AHEAD="> NUM"
GIT_PROMPT_BEHIND="< NUM"
GIT_PROMPT_UNTRACKED="×"
GIT_PROMPT_MODIFIED="•"
GIT_PROMPT_STAGED="+"

PROMPT="%B%T%b %{$fg[magenta]%}%n%{$fg[white]%}@%{$fg[cyan]%}$HOST%{$fg[white]%}:${current_dir} %(?.%F{cyan}.%F{red})› %f"

RPS1='$(git_prompt_string)'


function parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function git_prompt_string() {
    local git_where="$(parse_git_branch)"

    if [ -n "$git_where" ]; then
		echo "%{$reset_color%}[%{$fg[cyan]%}$(parse_git_state)%{$reset_color%}] ";
	fi
}

function parse_git_state() {
    local GIT_STATE="${git_where#(refs/heads/|tags/)}%{$fg[magenta]%}"

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"

    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE="$GIT_STATE ${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}"
    fi

    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE="$GIT_STATE ${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}"
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE="$GIT_STATE $GIT_PROMPT_UNTRACKED"
    fi

    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE="$GIT_STATE $GIT_PROMPT_MODIFIED"
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE="$GIT_STATE $GIT_PROMPT_STAGED"
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_STATE"
    fi
}
