# Default settings for necessary vzsh and zsh variables and some needed functions
# user-defined variables are all left alone

VZSH_DEFAULT_SET=true # make the various plugins not try to re-source this

if [[ -z "$VZSH_REMAP_KEYS_P" ]]; then
    VZSH_REMAP_KEYS_P='true'
fi
if [[ -z "$VZSH_CACHE" ]]; then
    VZSH_CACHE=$HOME/.cache/zsh
fi
if [[ ! -d $VZSH_CACHE ]]; then
    mkdir -p $VZSH_CACHE
fi
if [[ -z "$HISTFILE" ]]; then
    HISTFILE=$VZSH_CACHE/history
fi
if [[ -z "$HISTSIZE" ]]; then
    HISTSIZE=1000
fi
if [[ -z "$SAVEHIST" ]]; then
    SAVEHIST=1000
fi
if [[ -z "$PAGER" ]]; then
    PAGER=less
fi
if [[ -z "$COMPINSTALL_FILE" ]]; then
    COMPINSTALL_FILE=$VZSH_CACHE/compinstall
    zstyle :compinstall filename $COMPINSTALL_FILE
fi
# mailchecks
#MAILCHECK=30
# report about cpu-/system-/user-time of command if running longer than this
if [[ -z "$REPORTTIME" ]]; then
    REPORTTIME=5
fi

help-help(){
    echo "TODO - put help here" | $PAGER
}
run-help-help(){
    help-help
}
zle -N run-help-help

autoload -U colors && colors


