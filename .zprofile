export PATH=${PATH}:/var/lib/snapd/snap/bin
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
eval $(/opt/homebrew/bin/brew shellenv)

