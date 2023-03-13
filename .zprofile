export PATH=${PATH}:/var/lib/snapd/snap/bin
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ $(uname -s) = "Darwin" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#export PERL_CPANM_OPT="--local-lib=~/.perl5"
#export PATH=$HOME/.perl5/bin:$PATH;
#export PERL5LIB=$HOME/.perl5/lib/perl5:$PERL5LIB;

eval $(/opt/homebrew/bin/brew shellenv)
