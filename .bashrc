# vim: ft=sh

# resource .profile, to make sure updates are applied immediately, not only after the next login
test -r "$HOME/.profile" && . "$HOME/.profile"

# init homebrew first, because otherwise macos is actually unusable...
test -n "$HOMEBREW_PREFIX" && test -f "$HOMEBREW_PREFIX/bin/brew" && eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# init sdkman to provide java, gradle, maven, etc.
test -r "$SDKMAN_DIR/bin/sdkman-init.sh" && . "$SDKMAN_DIR/bin/sdkman-init.sh"

# init nvm to provide node.js
test -r "$NVM_DIR/nvm.sh" && . "$NVM_DIR/nvm.sh"

### HERE WE'RE DONE WITH ALL GENERAL PURPOSE CONFIGS
###
### The following is only relevant for interactive
### shells!

# determine if we're interactive otherwise stop here
! [[ $- = *i* ]] && return

GIT_PROMPT_SH=/usr/lib/git-core/git-sh-prompt
test -n "$HOMEBREW_PREFIX" && GIT_PROMPT_SH="$HOMEBREW_PREFIX/opt/git/etc/bash_completion.d/git-prompt.sh"

# Note that the var "NEMO_GIT_STATUS" is only filled when we are in a git directory!
PS1='\033[01;32m\u@\h\033[0m: \033[01;34m\w\033[0m \t\n$NEMO_GIT_STATUS\$ '
if test -r "$GIT_PROMPT_SH"; then
  . $GIT_PROMPT_SH
  PROMPT_COMMAND='NEMO_GIT_STATUS="$(__git_ps1 | sed "s/^ //;s/)$/) /")";'
fi
unset GIT_PROMPT_SH

# keep history on multiple shells in parallel
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# log history on a daily basis, too (with more context)
HIST_LOG_DIR="$XDG_STATE_HOME/bash/log/"
HIST_LOG_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> '$HIST_LOG_DIR'/bash-history-$(date "+%Y-%m-%d").log; fi'
test -d "$HIST_LOG_DIR" || mkdir -p -m 700 "$HIST_LOG_DIR"
PROMPT_COMMAND="$HIST_LOG_COMMAND; $PROMPT_COMMAND"
unset HIST_LOG_DIR \
  HIST_LOG_COMMAND

# load bash_completion
__bash_completion_dir=/usr/share/bash-completion
test -n "$HOMEBREW_PREFIX" && __bash_completion_dir="$HOMEBREW_PREFIX/etc"
if test -r "$__bash_completion_dir/bash_completion"; then
  . "$__bash_completion_dir/bash_completion"

  # For whatever reason git and ssh autocompletion doesn't load immediately on my Linux...
  test -r "$__bash_completion_dir/completions/git" && . "$__bash_completion_dir/completions/git"
  test -r "$__bash_completion_dir/completions/ssh" && . "$__bash_completion_dir/completions/ssh"
fi
unset __bash_completion_dir
# nvm has this separated for whatever reason
test -r "$NVM_DIR/bash_completion" && . "$NVM_DIR/bash_completion"

# init zoxide and set alias cd
which zoxide > /dev/null && eval "$(zoxide init --cmd cd bash)"

# setup fzf to use it e.g. for Ctrl+r
which fzf > /dev/null && fzf --bash > /dev/null && eval "$(fzf --bash)"

# load and unload env-variables dynamically from ".envrc" files
which direnv > /dev/null && eval "$(direnv hook bash)"

# standard alias
alias z=cd
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
alias vimwiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'
alias wiki='vim -c VimwikiIndex -c "cd %:p:h" -c "silent Git pull"'
alias g=goto
alias ff="fd | fzf --preview 'my-cli-preview {}'"
alias ffv="ff | xargs vim"

# reboot required notice
test -f /var/run/reboot-required && (>&2 echo -e "\n\033[01;31mReboot required to apply updates"'!'"\033[0m\n")

# config changed notice
test -n "$(cd dotfiles && git status --short)" && (>&2 echo -e "\n\033[01;33mCurrent configuration is not committed"'!'"\033[0m\nSwitch to ~/dotfiles and run "'"'"\033[01mgit status\033[0m"'"'" for further information\n")
