#!/usr/bin/env zsh

# Configuration example (and default) for vzsh

if [[ -z "$VZSH_HOME" ]]; then
    # this little piece of magic points to the directory of this file.
    VZSH_HOME=${${0:A}:h}
fi
if [[ -z "$VZSH_REMAP_KEYS_P" ]]; then
    # if you are sourcing the full thing, you get the keys!
    VZSH_REMAP_KEYS_P='true'
fi


# defaults is necessary to set up default values for anything you haven't
# customized above
source $VZSH_HOME/defaults.zsh

# the other sourced files are all optional
# TODO - document these

# sets some sane options that are generally agreeable
source $VZSH_HOME/setopt/setopt.zsh

# expand snippets anywhere on the command line
source $VZSH_HOME/snippets/snippets.zsh

###### COMPLETION
# COMPLETER_DEFAULT_SETUP # name of command to run before each completer
# mk-completer -- TODO - explain...
# my completion system that works around some of the complexity of completion
# setup -- at least it works for me
source $VZSH_HOME/completion/completion.zsh

# functions adapted from the grml zsh distribution -- though I've made changes
source $VZSH_HOME/grml-funcs/grml-funcs.zsh

# cdr, because it's cool
source $VZSH_HOME/cdr/cdr.zsh

# my prompt setup -- meh, you can just as well use the built in themes if you
# prefer
source $VZSH_HOME/prompt/prompt.zsh

# source the zaw stuff if it exists, but if you source zaw before cdr is defined,
# you don't get the cdr source set up... bleh.
if functions zaw >/dev/null 2>&1 ; then
    for f in $VZSH_HOME/zaw-sources/*.zsh; do
        source $f
    done
fi

# note that keys.zsh provides useful functions, but won't alter key bindings
# if VZSH_REMAP_KEYS_P is set to 'false'
source $VZSH_HOME/keys/keys.zsh
