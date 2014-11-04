# Prompt setup.  TODO - look at zsh's built in prompt theme framework

if [[ -z "$VZSH_DEFAULT_SET" ]]; then
    source ${${0:A}:h}/../defaults.zsh
fi

setopt prompt_subst

typeset -Ag VZSH_PROMPT_STYLES
VZSH_PROMPT_STYLES[time]="%b%F{cyan}"
VZSH_PROMPT_STYLES[host]="%B%F{yellow}"
VZSH_PROMPT_STYLES[userhost_brackets]="%b%F{green}"
VZSH_PROMPT_STYLES[username]="%B%F{green}"
VZSH_PROMPT_STYLES[at]="%b%F{green}"
VZSH_PROMPT_STYLES[dir]="%B%F{blue}"
VZSH_PROMPT_STYLES[histnum]="%b%F{yellow}"
VZSH_PROMPT_STYLES[dollar]="%b%F{default}"
VZSH_PROMPT_STYLES[git_master]="%b%F{white}"
VZSH_PROMPT_STYLES[git_other]="%b%F{red}"
typeset -Ag VZSH_KEYMAP_INDICATOR
VZSH_KEYMAP_INDICATOR[main]="%K{magenta}%F{black}I%k"
VZSH_KEYMAP_INDICATOR[viins]="%K{magenta}%F{black}I%k"
VZSH_KEYMAP_INDICATOR[emacs]="%K{magenta}%F{black}I%k"
VZSH_KEYMAP_INDICATOR[vicmd]="%K{blue}%F{black}N%k"
VZSH_KEYMAP_INDICATOR[opp]="%K{yellow}%F{black}O%k"
VZSH_KEYMAP_INDICATOR[vivis]="%K{green}%F{black}V%k"
VZSH_KEYMAP_INDICATOR[vivli]="%K{green}%F{black}V%k"
VZSH_KEYMAP_INDICATOR[keymap_unlisted]="%K{white}%F{black}?%k"
PS1_cmd_stat='%b%F{cyan}<%(?,%F{green}%?,%F{red}%?)%F{cyan}>'

getGitBranchForPrompt() {
    branch=$(git branch 2>/dev/null | fgrep '*')
    if [ "$branch" = "* master" ]
    then
        branch="%F{grey}[${VZSH_PROMPT_STYLES[git_master]}${branch:2}%F{grey}] "
    elif [ -n "$branch" ]
    then
        branch="%F{grey}[${VZSH_PROMPT_STYLES[git_other]}${branch:2}%F{grey}] "
    fi
    echo $branch
}

update-prompt() {
    local -A s
    set -A s ${(kv)VZSH_PROMPT_STYLES}
    local k=$VZSH_KEYMAP_INDICATOR[$ZSH_CUR_KEYMAP]
    if [[ -z "$k" ]]; then
        k=$VZSH_KEYMAP_INDICATOR[keymap_unlisted]
    fi

    PS1="$s[time]%T ${s[userhost_brackets]}[${s[username]}%n${s[at]}@${s[host]}%m${s[userhost_brackets]}] \$(getGitBranchForPrompt)${s[dir]}%~ ${PS1_cmd_stat}
${k} ${s[histnum]}%h ${s[dollar]}%# "

    zle reset-prompt
}

vzsh-add-hook zle_line_init_hook update-prompt
vzsh-add-hook zle_keymap_select_hook update-prompt

