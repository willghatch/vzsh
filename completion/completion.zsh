#!/usr/bin/env zsh

VZSH_COMPLETION_LOADED=true

# match on the left
# smart-case...ish... and match numbers without using L3-shift (my layout has numbers on AltGr+these letters), and -/_
zstyle ':completion:*'  matcher-list 'm:{a-z-}={A-Z_} '
zstyle ':completion:::::' completer _complete _approximate

# format all messages not formatted in bold prefixed with ----
zstyle ':completion:*' format '%B---- %d%b'
# format descriptions (notice the vt100 escapes)
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# bold and underline normal messages
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
# format in bold red error messages
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
# Put completion into groups
zstyle ':completion:*' group-name ''

# limit to 2 errors
#zstyle ':completion:*:approximate:*' max-errors 2
# or to have a better heuristic, by allowing one error per 3 character typed
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# let's complete known hosts and hosts from ssh's known_hosts file
#mybasehosts="examplehost.exampledomain.net"
#myhosts=($((
#( [ -r $HOME/.ssh/known_hosts ] && awk '{print $1}' $HOME/.ssh/known_hosts | tr , '\n');\
#echo $mybasehost; ) | sort -u) )

#zstyle ':completion:*' hosts $myhosts

# add partial completion highlighting
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==36=01;31}:${(s.:.)LS_COLORS}")'


VZSH_ANYWHERE_MATCHER_STR='m:{a-z-}={A-Z_} l:|=* r:|=*'

# _all_matches _approximate _complete _correct _expand _expand_alias _extensions
# _history _ignored _list _match _menu _oldlist _prefix _user_expand
# list from http://zsh.sourceforge.net/Doc/Release/Completion-System.html

zle -C vzsh-complete-std-anywhere complete-word _generic
zstyle ':completion:vzsh-complete-std-anywhere:*'  matcher-list $VZSH_ANYWHERE_MATCHER_STR

zle -C vzsh-complete-gnu complete-word _generic
zstyle ':completion:vzsh-complete-gnu::::' completer _complete _gnu_generic

zle -C vzsh-complete-expand complete-word _generic
zstyle ':completion:vzsh-complete-expand::::' completer _expand_word _expand_alias

zle -C vzsh-complete-history complete-word _generic
zstyle ':completion:vzsh-complete-history::::' completer _history

zle -C vzsh-complete-history-anywhere complete-word _generic
zstyle ':completion:vzsh-complete-history-anywhere::::' completer _history
zstyle ':completion:vzsh-complete-history-anywhere:*'  matcher-list $VZSH_ANYWHERE_MATCHER_STR

zle -C vzsh-complete-tmux complete-word _generic
zstyle ':completion:vzsh-complete-tmux::::' completer _complete_tmux_display

zle -C vzsh-complete-maximal complete-word _generic
zstyle ':completion:vzsh-complete-maximal::::' completer _oldlist _expand _complete _files _ignored _history _complete_tmux_display _gnu_generic _prefix _match _approximate

zle -C vzsh-complete-maximal-anywhere complete-word _generic
zstyle ':completion:vzsh-complete-maximal-anywhere::::' completer _oldlist _expand _complete _files _ignored _history _complete_tmux_display _gnu_generic _prefix _match _approximate
zstyle ':completion:vzsh-complete-maximal-anywhere:*'  matcher-list $VZSH_ANYWHERE_MATCHER_STR



#autoload -Uz compinit
# use -d... but some things use $COMPDUMPFILE, others $ZSH_COMPDUMP...
#compinit -d $COMPDUMPFILE

