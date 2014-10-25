VZSH
====

vzsh is a project that has grown out of my constant configuration of dotfiles.  I realized that my configuration was huge enough, and that others might benefit if I extracted the more generic parts.  So here it is:  a collection of some useful plugins that can also be used as a simple batteries-included zsh starting point (like grml or oh-my-zsh)

Stand alone Install
-------------------

Clone the repo and source it

    git clone https://github.com/willghatch/vzsh.git
    echo "source vzsh/vzsh.zsh" >> ~/.zshrc

done!

Antigen install
---------------

Seriously, [antigen](https://github.com/zsh-users/antigen) is a better way to go about managing zsh plugins.

    antigen bundle https://github.com/willghatch/vzsh.git
or
    antigen bundle https://github.com/willghatch/vzsh.git snippets
    antigen bundle https://github.com/willghatch/vzsh.git keys
to get just the parts you want.

Configuration
-------------

Configuration for each sub-plugin is discussed in its section.  Some global configuration that is pulled in by some of the plugins includes variables that you can customize (including some general zsh variables that I just set to some defaults if they're empty):
-VZSH_CACHE - this defaults to $HOME/.cache/vzsh, and is automatically created if it doesn't exist.
-HISTFILE - if you haven't already set it up, this defaults to $VZSH_CACHE/history
-HISTSIZE - if you haven't already set it up, this defaults to 1000
-SAVEHIST - if you haven't already set it up, this defaults to 1000
-REPORTTIME - if you haven't already set it up, this defaults to 5 -- it's the number of seconds for a program to run for it to automatically report time stats.
-PAGER - if you haven't already set it up, this defaults to "less"
-COMPINSTALL_FILE - defaults to $VZSH_CACHE/compinstall
-ZLE_LINE_INIT_FUNCS - this is an array of function names to run when zle-line-init is run - a couple of sub-plugins add to this
-ZLE_KEYMAP_SELECT_FUNCS - this is an array of function names to run when zle-keymap-select is run - a couple of sub-plugins add to this

Features
========

Snippets
--------

Expand text anywhere on the command line, like aliases.

    ps aux tg! # ! represents cursor position
    # run snippet-expand or hit M-hs (if you load the keys module)
    ps aux | grep! # ! is your new cursor position

Add snippets
    snippet-add d "/my/long/directory/or/something like that"
    # then you can expand d to... that long thing

Keys
----

Useful functions for defining prefix commands (emacs-style!) with built in key listing with C-h.

    define-prefix-command <mapname> # create sub-map
    bindkey-to-prefix-map <mapname> <key> <cmd> # bind function to prefix map
    bind-key <prefix-key> <mapname> # bind the map to a prefix key

Prefix maps automatically have a map listing command bound to $HELP_KEY which lists the bindings in the map (like emacs does it).
For now, bindings within maps must be specified with literal characters (including $HELP_KEY), because I haven't written any sort of parser for it.

-VZSH_REMAP_KEYS_P - this defaults to true if sourced by vzsh.zsh (IE if you load up all the plugins), false otherwise.  If set to "true", the keys plugin maps useful functions from the other plugins, and turns on a hybrid emacs/vi mode (as an emacs evil-mode user, I can promise you it's better that way).
-VZSH_ADD_HELP_KEY - defaults to true.  Sets Control-H to be a help prefix -- C-hh gives general help, C-hb lists the current keybindings, C-hs lists available snippets, C-hC-h lists helpers available in help map.
-HELP_KEY - defaults to 'C-h'.

grml
----

I took a bunch of their stuff, modified it, and stuck it in here.

-rationalise-dot - type ... and get ../.. -- add another . and get ../../..
-... ok, just scan through the source to see what useful functions are there.

setopt
------

Set basic, sane default options.

prompt
------

Ok, this should be a theme, but I haven't bothered changing that yet.  Source it if you want my cool prompt.

completion
----------

After so much frustration trying to figure out how to customize different completion commands to behave the way I wanted, I wrapped zsh completion with my own system to be able to define different keys to complete in different ways.  This was largely born out of frustration, and if I learn about the "right way" to do this later, it may simply be replaced by some clear documentation about that, with a good default setup.

Questions? Comments?
--------------------

I'd like to hear.  Shoot me an email at willghatch@gmail.com.  I would love feedback from some zsh experts -- I don't personally know any, so your feedback would be great.
