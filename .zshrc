autoload -U compinit promptinit
compinit
promptinit
prompt redhat

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=100000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000000000
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

eval "$(~/.rbenv/bin/rbenv init - zsh)"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR=$HOME"/.sdkman"
[[ -s $HOME"/.sdkman/bin/sdkman-init.sh" ]] && source $HOME"/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
export TERM=xterm-256color
setopt share_history

source $HOME/.cargo/env
source $HOME/dotfiles/theme.zsh

setopt prompt_cr
setopt prompt_sp

##alias
alias update='$HOME/dotfiles/update.sh'

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

### Added by Zinit's installer
# Load a few important annexes, without Turbo
# (this is currently required for annexes)

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit installer's chunk
zinit light "zsh-users/zsh-history-substring-search"
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
zinit light "zdharma/history-search-multi-word"
zinit light "z-shell/fast-syntax-highlighting"
zinit light "zsh-users/zsh-completions"
zinit light "paulirish/git-open"
#zinit light "dracula/zsh"
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
