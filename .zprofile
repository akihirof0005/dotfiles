export PATH=${PATH}:/var/lib/snapd/snap/bin
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ $(expr substr $(uname -s) 1 6) = "Darwin" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ $(expr substr $(uname -s) 1 5) = "Linux" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
fi

