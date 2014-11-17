VZSH
====

vzsh is a project that has grown out of my constant configuration of dotfiles.  I realized that my configuration was huge enough, and that others might benefit if I extracted the more generic parts.  So here it is:  a collection of some useful plugins.  Much of this is stuff that floats around in snippets online that I want to make available to be sourced easily without combing the web.  Some I have improved.  Some I just wrote up myself.  Note that it is in early stages and will change as I have time to hack on it.

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

    antigen bundle https://github.com/willghatch/vzsh.git completion
    antigen bundle https://github.com/willghatch/vzsh.git keys

to get just the parts you want.

Configuration
-------------

Configuration for each sub-plugin is discussed in its section.  Some global configuration that is pulled in by some of the plugins includes variables that you can customize (including some general zsh variables that I just set to some defaults if they're empty):

- VZSH_CACHE - this defaults to $HOME/.cache/zsh, and is automatically created if it doesn't exist.
- HISTFILE - if you haven't already set it up, this defaults to $VZSH_CACHE/history
- HISTSIZE - if you haven't already set it up, this defaults to 1000
- SAVEHIST - if you haven't already set it up, this defaults to 1000
- REPORTTIME - if you haven't already set it up, this defaults to 5 -- it's the number of seconds for a program to run for it to automatically report time stats.
- PAGER - if you haven't already set it up, this defaults to "less"
- COMPINSTALL_FILE - defaults to $VZSH_CACHE/compinstall

Features
========

Note that I've moved the snippet submodule [here](https://github.com/willghatch/zsh-snippets)

Keys
----

Useful functions for defining prefix commands (emacs-style!) with built in key listing with C-h.

    define-prefix-command <mapname> # create sub-map
    bindkey-to-prefix-map <mapname> <key> <cmd> # bind function to prefix map
    bind-key <prefix-key> <mapname> # bind the map to a prefix key

Prefix maps automatically have a map listing command bound to $HELP_KEY which lists the bindings in the map (like emacs does it).
For now, bindings within maps must be specified with literal characters (including $HELP_KEY), because I haven't written any sort of parser for it.

- VZSH_REMAP_KEYS_P - this defaults to true.  If set to "true", the keys plugin maps useful functions from the other plugins, and turns on a hybrid emacs/vi mode (as an emacs evil-mode user, I can promise you it's better that way).
- VZSH_ADD_HELP_KEY - defaults to true, and is always true if other keys are remapped.  Sets Control-H to be a help prefix -- C-hh gives general help, C-hb lists the current keybindings, C-hs lists available snippets, C-hC-h lists helpers available in help map.
- HELP_KEY - defaults to 'C-h'.

If key remapping is set up, it provides the following:

completion map (in insert/default mode)

- M-hs - expand snippet (needs snippet module)
- M-hn - complete word from history (needs completion module)
- M-hN - complete word from history matching anywhere in the completion (needs completion module)
- M-hg - GNU generic completion (works for commands that have a standard --help option) (needs completion module)
- M-he - expand word (eg. $HOME -> /home/wgh) (needs completion module)
- M-ht - complete word from tmux or screen window (needs completion and grml modules)
- M-hp - copy last word
- M-hP - copy last shell word (IE everything in eg. quotes)
- M-Hd - insert date (needs grml module)
- M-hm - use a bunch of completers (needs completion module)
- M-hM - same as above, but matches anywhere in the word
- tab - normal completion, with 'smartcase' style matching, and matching - to _. (needs completion module)
- backtab (shift-tab) - same as above, but matching anywhere in the completion, rather than just the start (needs completion module)

Note that if you want to use these completers but you have custom completion setup already, you should read the completion section.

vi command mode stuff:
- esc - this goes from insert to command mode, so technically this is in the wrong place
- md - make directory named under cursor (needs grml module)
- g2 - jump to second word on the command line (needs grml module)

Also makes ... become ../..
And I decided not to put it... but you should really add this:

    bindkey -M viins 'jk' vi-cmd-mode
    bindkey -M viins 'kj' vi-cmd-mode

so you can just mash j and k together to get out of insert mode.

hooks
-----

Mostly copied from add-zsh-hook's implementation, this allows new hooks to be defined, and defines the zle-line-init and zle-keymap-select functions that are auto-run if they exist, with the hooks zle_line_init_hook and zle_keymap_select_hook.

Usage:

    vzsh-add-hook zle_keymap_select_hook my-func
    # now my-func will be run every time a keymap is selected

    # define a new hook
    vzsh-define-hook my_hook
    vzsh-add-hook my_hook my-function
    # and now this will execute all the functions defined in a hook (in this
    # case, that's just my-function)
    vzsh-run-hook my_hook

vzsh-add-hook supports the same options add-zsh-hook supports.

grml
----

I took a bunch of their stuff, modified some of it, and stuck it in here.

- rationalise-dot - type ... and get ../.. -- add another . and get ../../..
- ... ok, just scan through the source to see what useful functions are there.
- (but the source is pretty messy, because it's just been a file I've been working on deciding what I like from grml... but it's useful enough that I added it despite being a mess)

setopt
------

Set basic, sane default options.

prompt
------

This has my cool prompt.  The colors can be customized (after the module is loaded) with the variables VZSH_PROMPT_STYLES and VZSH_KEYMAP_INDICATOR -- look in the source of prompt.zsh to see the options.

completion
----------

This module sets up some completion styles (if you have your own defined before this is run they might be overwritten), and defines some completion widgets with different behaviors.  This is most useful if you also source the keys file after, so they are bound.

cdr
---

This module sets up the cdr (cd to recent directory) function that is explained in the zsh docs.  It is simply a convenient setup ready to source.

- VZSH_CDR_FILE_STYLE - if set to "multiple", a style is set to keep recent dir history split up by tty.  If set to "none", no style is set.  If not set, a style is set to put the recent dirs in VZSH_CACHE/recent-dirs/recent

zaw-sources
-----------

These are sources for the wonderful [zaw](https://github.com/zsh-users/zaw) plugin to do its thing with.  Widgets, functions, aliases, programs, and commands in general.  They were just so quick to write and they seemed like they should just be with zaw for completeness.  These need to be sourced after zaw, or it will have no effect.

Questions? Comments?
--------------------

I'd like to hear.  Shoot me an email at willghatch@gmail.com.  I would love feedback from some zsh experts -- I don't personally know any, so your feedback would be great.
