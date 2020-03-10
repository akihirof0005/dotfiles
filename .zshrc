autoload -U compinit promptinit
compinit
promptinit
prompt redhat

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=10000000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# コマンドミスを修正
setopt correct

zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*:default' menu select true
zstyle ':completion:*:default' menu select=1
#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#予測入力させる
autoload predict-on
zstyle ':predict' verbose true

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

path=($HOME/dotfiles/bin(N-/) $path)
path=($HOME/.gem/ruby/2.7.0/bin(N-/) $path)

export EDITOR=nvim
export TERM=xterm-256color
setopt share_history

source $HOME/.cargo/env
