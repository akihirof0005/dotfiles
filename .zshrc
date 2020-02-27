autoload -U promptinit
zstyle ':completion:*:default' menu select=2

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk
zinit light "zsh-users/zsh-history-substring-search"
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
zinit light "zdharma/history-search-multi-word"

zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zsh-users/zsh-completions"
#zinit light "dracula/zsh"
zinit light romkatv/powerlevel10k

if [ "$(uname)" = 'Darwin' ]; then
  export JAVA_HOME=`/usr/libexec/java_home -v "1.8"` &&  export PATH=${JAVA_HOME}/bin:${PATH}
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  eval "$(rbenv init -)"

  [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
  source /usr/share/nvm/nvm.sh
  source /usr/share/nvm/bash_completion
  source /usr/share/nvm/install-nvm-exec
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR=$HOME"/.sdkman"
  [[ -s $HOME"/.sdkman/bin/sdkman-init.sh" ]] && source $HOME"/.sdkman/bin/sdkman-init.sh"
fi
export EDITOR=nvim
export TERM=xterm-256color

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

path=($HOME/dotfiles/bin(N-/) $path)
path=($HOME/.gem/ruby/2.6.0/bin(N-/) $path)
setopt share_history

if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
