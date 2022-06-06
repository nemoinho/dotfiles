[[ -f ~/.profile ]] && . ~/.profile

# Shut off deprecation warning of bash on macos
export BASH_SILENCE_DEPRECATION_WARNING=1

# load all the defauls on debian
# TODO: get rid of it by applying all relevant things in this file
[ -d /etc/skel/.bashrc ] && . /etc/skel/.bashrc

# autocompletion
[ -s /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git
which brew &>/dev/null && [ -s $(brew --prefix)/etc/bash_completion ] && .  $(brew --prefix)/etc/bash_completion 

[ -s /etc/bash_completion ] && . /etc/bash_completion

# debian, ubuntu and so on
GIT_PROMPT_SH=/usr/lib/git-core/git-sh-prompt

# newtons vegetable with brew installed
[ ! -d $(dirname $GIT_PROMPT_SH) ] && GIT_PROMPT_SH=/usr/local/etc/bash_completion.d/git-prompt.sh

if [ -d $(dirname $GIT_PROMPT_SH) ]; then
    export GIT_PS1_SHOWCOLORHINTS=1 
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM='auto'
    if [ -f $GIT_PROMPT_SH ]; then
        . $GIT_PROMPT_SH
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

[ -s $XDG_CONFIG_HOME/broot/launcher/bash/br ] && . $XDG_CONFIG_HOME/broot/launcher/bash/br

which fly &>/dev/null && . <(fly completion --shell bash)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
alias vimwiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'
alias wiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'

# Enable autocompletion for "config" to manage dotfiles
__git_complete config __git_main
