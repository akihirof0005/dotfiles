filetype plugin indent on

" Encode
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double


" View
set number
set cursorline
set splitright
set clipboard=unnamed
set hls
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
tnoremap <silent> <ESC> <C-\><C-n>
source $VIMRUNTIME/macros/matchit.vim

" Command
set wildmenu
set history=5000

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

syntax enable
set t_Co=256

:command UP UpdateRemotePlugins

nnoremap s <Nop>
nnoremap sw <C-w>w
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" Tab & Indent
set showmatch
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

"for format snipet
nmap gg=G :call CocAction('format')<CR>

"for COPY&PASTE install xclip
set clipboard+=unnamedplus
se ff=unix
