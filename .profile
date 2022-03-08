# freedesktop
# see: https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.config/nvm/current/bin" ] && PATH="$HOME/.config/nvm/current/bin:$PATH"
[ -d "$HOME/.local/opt/go/bin" ] && PATH="$HOME/.local/opt/go/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
