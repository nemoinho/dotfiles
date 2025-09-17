# vim: ft=sh

# export everything
set -a

# freedesktop
# see: https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

test -d "$XDG_CONFIG_HOME" || mkdir -p -m 0700 "$XDG_CONFIG_HOME"
test -d "$XDG_CACHE_HOME"  || mkdir -p -m 0700 "$XDG_CACHE_HOME"
test -d "$XDG_DATA_HOME"   || mkdir -p -m 0700 "$XDG_DATA_HOME"
test -d "$XDG_STATE_HOME"  || mkdir -p -m 0700 "$XDG_STATE_HOME"

# adjust the PATH to include .local/bin
case "$PATH" in *"$HOME/.local/bin"*) ;; *) PATH="$HOME/.local/bin:$PATH";; esac

# ignore bash-deprecation on macos
BASH_SILENCE_DEPRECATION_WARNING=1

# configure history
HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=40000
HISTFILESIZE=50000
HISTFILE="$XDG_STATE_HOME/shell-history.log"
HISTCONTROL=ignorespace:ignoredups

# configure less so it will display pdf and stuff "raw" (needs lesspipe installed)
LESS='-R'
LESSOPEN='|lesspipe %s'

# git prompt
GIT_PS1_SHOWCOLORHINTS=1 
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM='auto'

# arbitrary variables for required by different tools
# nvm to use different node.js versions
NVM_DIR="$XDG_CONFIG_HOME/nvm"
# sdkman to use different java tools in different versions easily
SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
# homebrew is complicated as shit, lucky me only relevant on macos
test `uname` = "Darwin" && test `uname -m` = "arm64" && HOMEBREW_PREFIX=/opt/homebrew
test `uname` = "Darwin" && test ! `uname -m` = "arm64" && HOMEBREW_PREFIX=/usr/local

# add homebrew to path
case "$PATH" in *"$HOMEBREW_PREFIX/bin"*) ;; *) PATH="$HOMEBREW_PREFIX/bin:$PATH";; esac

# stop exporting everything
set +a
