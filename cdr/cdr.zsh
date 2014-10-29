# This sets up the cdr command -- the instructions are up in the docs... maybe
# just as an example?  Anyway, here is the setup as a sourceable file.

if [[ -z "$VZSH_DEFAULT_SET" ]]; then
    source ${${0:A}:h}/../defaults.zsh
fi

if [[ -z "$VZSH_RECENT_DIRS_DIR" ]]; then
    VZSH_RECENT_DIRS_DIR=$VZSH_CACHE/recent-dirs
fi
if [[ ! -d $VZSH_RECENT_DIRS_DIR ]]; then
    mkdir -p $VZSH_RECENT_DIRS_DIR
fi

# recent directory list
# use with cdr command
autoload -Uz chpwd_recent_dirs cdr
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-file $VZSH_RECENT_DIRS_DIR/rd-${TTY##*/} +

