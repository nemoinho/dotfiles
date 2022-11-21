#!/bin/bash
set -e

_osname=$(uname -s)

if [ "$_osname" = "Darwin" ]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install \
        git \
        wget \
        asciidoctor \
        bash-completion \
        vim
else
    if [ $(which apt-get) ]
    then
        sudo apt-get update
        sudo apt-get install \
            git \
            wget \
            asciidoctor \
            bash-completion \
            vim \
            i3 \
            i3lock \
            i3status \
            rofi
    else
        echo Unsupported system
        exit 1
    fi
fi

unset _osname

# clone dotfiles for fast startup
GIT_DIR=$HOME/Development/nemoinho/gitea.nehrke.info/nemoinho/dotfiles
if [ ! -d "$GIT_DIR" ]
then
    GIT_REMOTE=git@gitea.nehrke.info:nemoinho/dotfiles.git
    git clone --separate-git-dir=$GIT_DIR $GIT_REMOTE $HOME/tmp-dotfiles
    rm -r ~/tmp-dotfiles
else
    /usr/bin/git --git-dir "$GIT_DIR" --work-tree "$HOME" pull
fi
alias config='/usr/bin/git --git-dir=$GIT_DIR --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout

# reload bash_profile to configure the current shell with the just installed dotfiles
. ~/.bash_profile

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

# install java with sdkman
export SDKMAN_DIR=${SDKMAN_DIR:-$XDG_CONFIG_HOME/sdkman}
curl -s https://beta.sdkman.io | /bin/bash
source "$SDKMAN_DIR/bin/sdkman-init.sh"
sdk version
sdk install java 11.0.14-tem
sdk install gradle 7.4

# install nvm to manage nodejs
curl -s https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | /bin/bash
nvm install node
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "ready for work :-)"
