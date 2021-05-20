export LANG=ja_JP.utf8
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:$HOME/.bin"
source "$HOME/.cargo/env"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.local/bin:$PATH"

export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
