export SHELL=/bin/bash

[ -z "$XDG_CONFIG_HOME" ] && [ -f "$HOME/.profile" ] && . "$HOME/.profile"

# Shut off deprecation warning of bash on macos
export BASH_SILENCE_DEPRECATION_WARNING=1

# load all the defauls on debian
# TODO: get rid of it by applying all relevant things in this file
[ -d /etc/skel/.bashrc ] && . /etc/skel/.bashrc

# ensure to delete files from ~/Downloads after 1 day
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/bin/find $HOME/Downloads/ -type f -mtime +1 -exec $(which rm) {} \;") | sort -u | crontab -

# debian, ubuntu and so on
GIT_PROMPT_SH=/usr/lib/git-core/git-sh-prompt

# newtons vegetable with brew installed
[ ! -e "$GIT_PROMPT_SH" ] && (which brew > /dev/null) && GIT_PROMPT_SH="$(brew --prefix)/opt/git/etc/bash_completion.d/git-prompt.sh"

# Note that the var "NEMO_GIT_STATUS" is only set if in a git directory!
PS1='\033[01;32m\u@\h\033[0m: \033[01;34m\w\033[0m \t\n$NEMO_GIT_STATUS\$ '
export GIT_PS1_SHOWCOLORHINTS=1 
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM='auto'
if [ -f $GIT_PROMPT_SH ]; then
    . $GIT_PROMPT_SH
    PROMPT_COMMAND='NEMO_GIT_STATUS="$(__git_ps1 | sed "s/^ //;s/)$/) /")"'
fi

[ ! -d $XDG_STATE_HOME/bash/log ] && mkdir -p $XDG_STATE_HOME/bash/log
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=40000
export HISTFILESIZE=50000
export HISTFILE=$XDG_STATE_HOME/bash/bash_history
export HISTCONTROL=ignorespace:ignoredups

MY_HISTORY_PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> '$XDG_STATE_HOME'/bash/log/bash-history-$(date "+%Y-%m-%d").log; fi;'
PROMPT_COMMAND=${MY_HISTORY_PROMPT_COMMAND}${PROMPT_COMMAND}

[ -s $XDG_CONFIG_HOME/broot/launcher/bash/br ] && . $XDG_CONFIG_HOME/broot/launcher/bash/br

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# standard alias
alias cz='(pushd $(git rev-parse --show-toplevel); $(which cz); popd)'
alias e='eza --icons --long --time-style=long-iso --group'
alias ls='eza --time-style=long-iso --group'
alias lg='git lg'
alias lgb='git lgb'
alias co='git checkout'
alias push='git push'
alias commit='git commit'
alias gc='git commit'
alias st='git status'
alias gd='git diff'
alias gdl='GIT_PAGER=less git diff'
alias gt='git gt'
alias gtl='GIT_PAGER=less git gt'
alias gdc='gd --cached'
alias gdcl='GIT_PAGER=less gd --cached'
alias c='git commit'
alias markdown_pdf="docker run --rm -v \$PWD:/opt/docs auchida/markdown-pdf markdown-pdf"
alias vimwiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'
alias wiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'
alias g=goto
alias ff="fd | fzf --preview 'my-cli-preview {}'"
alias ffv="ff | xargs vim"

which fzf > /dev/null && fzf --bash > /dev/null && eval "$(fzf --bash)"
which zoxide > /dev/null && eval "$(zoxide init bash)" && alias cd=z

if [ -f .local/bin/lessfilter ]
then
  export LESS='-R'
  export LESSOPEN='|lesspipe %s'
fi

[ -s "$XDG_CONFIG_HOME/bash/local-config" ] && . "$XDG_CONFIG_HOME/bash/local-config"

# autocompletion
__bash_completion_dir="$XDG_DATA_HOME/bash-completion/completions"
which brew &>/dev/null && __bash_completion_dir="$(brew --prefix)/etc/bash_completion.d"

mkdir -p "$__bash_completion_dir"

which kubectl &> /dev/null && [ ! -f "$__bash_completion_dir/kubectl" ] && kubectl completion bash > "$__bash_completion_dir/kubectl"
which fly &> /dev/null && [ ! -f "$__bash_completion_dir/fly" ] && fly completion --shell bash > "$__bash_completion_dir/fly"
[ -f ~/Development/nemoinho/github.com/iridakos/goto/goto.sh ] && [ ! -f "$__bash_completion_dir/goto" ] && ln -s ~/Development/nemoinho/github.com/iridakos/goto/goto.sh "$__bash_completion_dir/goto"

# load bash-completion
which brew &> /dev/null && . "$(brew --prefix)/etc/bash_completion"
[ -s /etc/bash_completion ] && . /etc/bash_completion

# Enable autocompletion for "config" to manage dotfiles
[ -s /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git
__git_complete config __git_main
__git_complete c __git_main

# load goto alias (isn't looaded for alias by bash-completion, don't know why)
[ -e "$__bash_completion_dir/goto" ] && . "$__bash_completion_dir/goto"
unset __bash_completion_dir

# reboot required notice
[ -f /var/run/reboot-required ] && (>&2 echo -e "\n\033[01;31mReboot required to apply updates"'!'"\033[0m\n")

# config changed notice
[ -n "$(config status --short)" ] && (>&2 echo -e "\n\033[01;33mCurrent configuration is not committed"'!'"\033[0m\nRun "'"'"\033[01mconfig status\033[0m"'"'" for further information\n")
