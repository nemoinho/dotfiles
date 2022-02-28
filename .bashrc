# freedesktop
# see: https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export EDITOR=vim

# Shut off deprecation warning of bash in mac
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -d /etc/skel/.bashrc ]
then
    source /etc/skel/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/opt/java/bin" ] ; then
    PATH="$HOME/.local/opt/java/bin:$PATH"
fi

if [ -d "$HOME/.local/opt/node/bin" ] ; then
    PATH="$HOME/.local/opt/node/bin:$PATH"
fi

if [ -d "$HOME/.local/opt/go/bin" ] ; then
    PATH="$HOME/.local/opt/go/bin:$PATH"
fi

# autocompletion
if [ $(which brew) ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
else
    if [ -s /usr/share/bash-completion/completions/git ]; then
        . /usr/share/bash-completion/completions/git
    fi
fi

alias config='/usr/bin/git --git-dir=$HOME/Development/nemoinho/gitea.nehrke.info/nemoinho/dotfiles --work-tree=$HOME'
alias lg='git lg'
alias lgb='git lgb'
alias co='git checkout'
alias push='git push'
alias commit='git commit'
alias gc='git commit'
alias st='git status'
alias gd='git diff'
alias gt='git gt'
alias gdc='gd --cached'
alias c='git commit'
alias markdown_pdf="docker run --rm -v \$PWD:/opt/docs auchida/markdown-pdf markdown-pdf"
alias vimwiki='vim -c VimwikiIndex -c "cd %:p:h"'
alias wiki='vim -c VimwikiIndex -c "cd %:p:h"'

__git_complete config __git_main

# debian, ubuntu and so on
GIT_PROMPT_SH=/usr/lib/git-core/git-sh-prompt

# newtons vegetable with brew installed
if [ ! -d $(dirname $GIT_PROMPT_SH) ]; then
    GIT_PROMPT_SH=/usr/local/etc/bash_completion.d/git-prompt.sh
fi

if [ -d $(dirname $GIT_PROMPT_SH) ]; then
    export GIT_PS1_SHOWCOLORHINTS=1 
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM='auto'
    if [ -f $GIT_PROMPT_SH ]; then
        source $GIT_PROMPT_SH
        PS1='\t \[\e]0;\u@\h: \w$(__git_ps1)\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \t$(__git_ps1 " (%s)") \$ '
        MY_GIT_PROMPT_COMMAND='__git_ps1 "\[\e]0;\u@\h: \w \t$(__git_ps1) \a\]\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \t\n" "\\\$ " "(%s) ";'
        PROMPT_COMMAND=${MY_GIT_PROMPT_COMMAND}${PROMPT_COMMAND}
    fi
fi

[ ! -d $XDG_STATE_HOME/bash/log ] && mkdir -p $XDG_STATE_HOME/bash/log
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=40000
export HISTFILESIZE=50000
export HISTFILE=$XDG_STATE_HOME/bash/bash_history

MY_HISTORY_PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> '$XDG_STATE_HOME'/bash/log/bash-history-$(date "+%Y-%m-%d").log; fi;'
PROMPT_COMMAND=${MY_HISTORY_PROMPT_COMMAND}${PROMPT_COMMAND}

[ -s $XDG_CONFIG_HOME/broot/launcher/bash/br ] && source $XDG_CONFIG_HOME/broot/launcher/bash/br

which fly &>/dev/null && source <(fly completion --shell bash)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
