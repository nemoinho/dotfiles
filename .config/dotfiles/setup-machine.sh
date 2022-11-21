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
        echo "deb https://apt.enpass.io/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
        curl -sSL https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
        sudo apt-get update
        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            gnupg \
            git \
            wget \
            asciidoctor \
            bash-completion \
            vim \
            rxvt-unicode \
            i3 \
            i3lock \
            i3status \
            rofi \
            oathtool \
            enpass
        # install icon-font which I use for i3status
        MATERIAL_DESIGN_FONT_ZIP=MaterialDesign-Webfont-4.9.95.zip
        curl -sSL --output-dir $HOME/Downloads -o "$MATERIAL_DESIGN_FONT_ZIP" https://github.com/Templarian/MaterialDesign-Webfont/archive/v4.9.95.zip
        mkdir -p $HOME/.local/share/fonts || true
        unzip -jod $HOME/.local/share/fonts/ "$HOME/Downloads/$MATERIAL_DESIGN_FONT_ZIP" MaterialDesign-Webfont-4.9.95/fonts/materialdesignicons-webfont.ttf
        fc-cache -fv
        rm "$HOME/Downloads/$MATERIAL_DESIGN_FONT_ZIP"

        # handle work-setup
        while true
        do
            echo ""
            read -p "Is this installation for work? [Yn] " yn </dev/tty
            case $yn in
                [Yy]*|"")
                    CHROME_DEB=google-chrome-stable_current_amd64.deb
                    curl -sSL --output-dir $HOME/Downloads -O https://dl.google.com/linux/direct/$CHROME_DEB
                    sudo apt-get install \
                        openconnect \
                        network-manager-openconnect \
                        network-manager-openconnect-gnome \
                        $HOME/Downloads/$CHROME_DEB
                    rm $HOME/Downloads/$CHROME_DEB
                    break;;
                [Nn]*) break;;
                *) echo "Please answer yes or no.";;
            esac
        done

        # handle cli's for clouds
        while true
        do
            echo ""
            read -p "Is gcloud required? [Yn] " yn </dev/tty
            case $yn in
                [Yy]*|"")
                    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
                    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg > /dev/null
                    sudo apt-get update && sudo apt-get install google-cloud-cli
                    break;;
                [Nn]*) break;;
                *) echo "Please answer yes or no.";;
            esac
        done
    else
        echo Unsupported system
        exit 1
    fi
fi

unset _osname

# clone dotfiles for fast startup
GIT_DIR=$HOME/Development/nemoinho/gitea.nehrke.info/nemoinho/dotfiles
config='/usr/bin/git --git-dir '"$GIT_DIR"' --work-tree '"$HOME"''
if [ ! -d "$GIT_DIR" ]
then
    GIT_REMOTE=git@gitea.nehrke.info:nemoinho/dotfiles.git
    git clone --separate-git-dir=$GIT_DIR $GIT_REMOTE $HOME/tmp-dotfiles
    rm -r ~/tmp-dotfiles
else
    $config pull
fi
alias config="$config"
$config config --local status.showUntrackedFiles no
$config checkout

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

# setup defaults
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt

echo "ready for work :-)"
