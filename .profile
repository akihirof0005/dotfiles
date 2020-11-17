export PATH="$HOME/.cargo/bin:$PATH"
export PATH=${PATH}:/var/lib/snapd/snap/bin
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.1/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"


export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
xrdb ~/.Xresources
xsetroot -cursor_name left_ptr &
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
