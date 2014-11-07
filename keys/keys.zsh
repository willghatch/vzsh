# provides useful key mapping functions, and a better keymap

if [[ -z "$VZSH_DEFAULT_SET" ]]; then
    source ${${0:A}:h}/../defaults.zsh
fi

if [[ -z "$VZSH_ADD_HELP_KEY" ]]; then
    VZSH_ADD_HELP_KEY=true
fi

if [[ -z "$HELP_KEY" ]]; then
    HELP_KEY=''
fi

bindToMaps(){
    # bindToMaps key cmd map1 map2 ...
    local key=$1
    shift
    local cmd=$1
    shift
    for m in $@
    do
        bindkey -M $m $key $cmd 2>/dev/null
    done
}

bindkey-to-prefix-map(){
    # bindkey-to-prefix <prefix> <key> <cmd>
    # TODO - make this work for string '^H' instead of literal ^H
    local name="prefix_command_${1}_map"
    eval "${name}+=( $2 $3 )"
}
define-prefix-command(){
    local mapname=$1
    eval "
    typeset -Ag prefix_command_${mapname}_map
    $mapname(){
        local key
        read -sk 1 key
        local cmd=\$prefix_command_${mapname}_map[\$key]
        zle \$cmd
    }
    zle -N $mapname
    run-help-keys-${mapname}(){
        print -a -C 2 \${(kv)prefix_command_${mapname}_map} | \$PAGER
    }
    zle -N run-help-keys-${mapname}
    bindkey-to-prefix-map '$mapname' $HELP_KEY 'run-help-keys-${mapname}'
    "
}

help-keys() {
    local keys="$(bindkey -LM $ZSH_CUR_KEYMAP)"
    echo "keys for $ZSH_CUR_KEYMAP:\n$keys" | $PAGER
}
run-help-keys(){
    help-keys
}
zle -N run-help-keys


if [ "$VZSH_REMAP_KEYS_P" = "true" ]; then
    VZSH_ADD_HELP_KEY=true

    # nuke viins map, replacing it with the contents of the emacs map
    bindkey -A emacs viins

    # escapes for command mode
    bindkey -M viins '\e' vi-cmd-mode
    # though these are so much better...
    #bindkey -M viins 'jk' vi-cmd-mode
    #bindkey -M viins 'kj' vi-cmd-mode

    # use viins, which is now emacs-y, but has an out to vicmd mode
    bindkey -v

    # completion
    define-prefix-command completionkey
    bindkey-to-prefix-map completionkey g vzsh-complete-gnu
    bindkey-to-prefix-map completionkey e vzsh-complete-expand
    bindkey-to-prefix-map completionkey n vzsh-complete-history
    bindkey-to-prefix-map completionkey N vzsh-complete-history-anywhere
    bindkey-to-prefix-map completionkey m vzsh-complete-maximal
    bindkey-to-prefix-map completionkey M vzsh-complete-maximal-anywhere
    bindkey-to-prefix-map completionkey t vzsh-complete-tmux
    bindkey-to-prefix-map completionkey T vzsh-complete-tmux-anywhere
    bindkey-to-prefix-map completionkey s snippet-expand
    bindkey-to-prefix-map completionkey p copy-prev-word
    bindkey-to-prefix-map completionkey P copy-prev-shell-word
    bindkey-to-prefix-map completionkey d insert-datestamp
    bindkey -r viins '^[h'
    #bindkey -M viins '^[h' completionkey
    # TODO - for some reason the completers won't run properly now if they're in
    # a sub-map...
    if [[ -n "$VZSH_COMPLETION_LOADED" ]]; then
        # ^i is tab
        # ^[[Z is backtab...
        bindkey -M viins '^[[Z' vzsh-complete-std-anywhere
    fi
    bindkey '^[hg' vzsh-complete-gnu
    bindkey '^[he' vzsh-complete-expand
    bindkey '^[hn' vzsh-complete-history
    bindkey '^[hN' vzsh-complete-history-anywhere
    bindkey '^[hm' vzsh-complete-maximal
    bindkey '^[hM' vzsh-complete-maximal-anywhere
    bindkey '^[ht' vzsh-complete-tmux
    bindkey '^[hs' snippet-expand
    bindkey '^[hp' insert-last-typed-word
    bindkey '^[hd' insert-datestamp

    # funcs from grml-funcs
    bindkey -M vicmd 'md' inPlaceMkDirs
    bindkey -M vicmd 'g2' jump_after_first_word

    if [[ -n "$VZSH_GRML_LOADED" ]]; then
        bindkey -M viins . rationalise-dot
        # without this, typing a . aborts incremental history search
        bindkey -M isearch . self-insert
    fi
fi

if [[ "$VZSH_ADD_HELP_KEY" = "true" ]]; then
    # Help
    for m in $(bindkey -l)
    do
        bindkey -r $m '$HELP_KEY' 2>/dev/null
    done
    define-prefix-command helpkey
    bindkey-to-prefix-map helpkey g run-help-glob
    bindkey-to-prefix-map helpkey b run-help-keys
    bindkey-to-prefix-map helpkey s run-help-list-snippets
    bindkey-to-prefix-map helpkey c run-help # this pulls up man pages
    bindkey-to-prefix-map helpkey h run-help-help
    bindToMaps "$HELP_KEY" helpkey $(bindkey -l)

fi


