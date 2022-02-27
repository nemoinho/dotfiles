#!/usr/bin/env bash
if [ -d /etc/skel/.bashrc ]
then
	source /etc/skel/.bashrc
fi

export EDITOR=vim
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/opt/node/bin

# autocompletion
if [ $(which brew) ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

alias config='/usr/bin/git --git-dir=$HOME/Development/nemoinho/gitea.nehrke.info/nemoinho/dotfiles --work-tree=$HOME'
alias lg='git lg'
alias co='git checkout'
alias push='git push'
alias commit='git commit'
alias gc='git commit'
alias st='git status'
alias gd='git diff'
alias gdc='gd --cached'
alias markdown_pdf="docker run --rm -v \$PWD:/opt/docs auchida/markdown-pdf markdown-pdf"
alias vimwiki='vim -c VimwikiIndex -c "cd %:p:h"'
alias wiki='vim -c VimwikiIndex -c "cd %:p:h"'
alias mintern="xrandr | grep ' connected' | cut -d' ' -f1-3 | sed 's/\\(^[A-Z0-9]\\{1,\\}\\).*primary/--output \\1 --auto/;s/\\(^[A-Z0-9]\\{1,\\}\\).*/--output \\1 --off/' | xargs xrandr && xbacklight -set 100"
alias mextern="xrandr | grep ' connected' | cut -d' ' -f1-3 | sed 's/\\(^[A-Z0-9]\\{1,\\}\\).*primary/--output \\1 --off/;s/\\(^[A-Z0-9]\\{1,\\}\\).*/--output \\1 --auto/' | tr '\\n' ' ' | sed 's/\\([A-Z0-9]\\{1,\\}\\) --auto --output [A-Z0-9]\\{1,\\}/\\0 --right-of \\1/' | xargs xrandr && xbacklight -set 100"

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
        PS1='\t \[\e]0;\u@\h: \w$(__git_ps1)\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\t$(__git_ps1 " (%s)") \$ '
        MY_GIT_PROMPT_COMMAND='__git_ps1 "\[\e]0;\u@\h: \w\n\t$(__git_ps1) \a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\t" " \\\$ ";'
        PROMPT_COMMAND=${MY_GIT_PROMPT_COMMAND}${PROMPT_COMMAND}
    fi
fi

[ ! -d ~/.local/state/bash-history ] && mkdir ~/.local/state/bash-history
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=40000
export HISTFILESIZE=50000

MY_HISTORY_PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.local/state/bash-history/bash-history-$(date "+%Y-%m-%d").log; fi;'
PROMPT_COMMAND=${MY_HISTORY_PROMPT_COMMAND}${PROMPT_COMMAND}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
