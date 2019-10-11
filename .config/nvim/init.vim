filetype plugin indent on

syntax enable
set number
set expandtab 
set tabstop=2 
set softtabstop=2 
set smartindent 
set autoindent
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed
set hls
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
tnoremap <silent> <ESC> <C-\><C-n>

if &compatible
  set nocompatible
endif
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable
set t_Co=256
set tabstop=2

:command UP UpdateRemotePlugins
