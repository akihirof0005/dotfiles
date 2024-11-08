filetype plugin indent on

call plug#begin('~/.local/share/nvim/plugged')
"Plug 'Shougo/dein.vim'
" end補完
" https://github.com/tpope/vim-endwise
Plug 'tpope/vim-endwise'
" https://github.com/vim-syntastic/syntastic
" 構文エラーチェック
Plug  'scrooloose/syntastic'
" https://github.com/w0rp/ale
"[[plugins]]
"Plug 'w0rp/ale'
"https://github.com/tpope/vim-fugitive
" git rapper plugins
Plug 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the sign column.
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
" 検索時にマッチした個数とそれが何番目であるかの情報を表示する
" https://github.com/osyo-manga/vim-anzu
Plug 'osyo-manga/vim-anzu'
" シンタックスハイライト for kotlin
Plug 'udalov/kotlin-vim'
" シンタックスハイライト for gradle
Plug 'tfnico/vim-gradle'
Plug 'bronson/vim-trailing-whitespace'
" groovy indent script
" https://www.vim.org/scripts/script.php?script_id=5257
Plug 'vim-scripts/groovyindent-unix'
Plug 'glepnir/zephyr-nvim'
" When the plugin is correctly loaded, there will be a nice statusline at the bottom of each vim window.
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'
"ファイルの形式を文脈で判断するプラグイン
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neosnippet.vim'

Plug 'Shougo/neosnippet-snippets'
" LSP client
Plug 'rust-lang/rust.vim', {'branch': 'release'}
"LSP server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dense-analysis/ale'

Plug 'sainnhe/everforest'

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
" (Optional) Multi-entry selection UI.
"Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim'
"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'andymass/vim-matchup', { 'on': [] }
call plug#end()

set dir=~/.neovimswap
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
"set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
tnoremap <silent> <ESC> <C-\><C-n>
source $VIMRUNTIME/macros/matchit.vim

" Command
set wildmenu
set history=5000

if &compatible
  set nocompatible
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
set ff=unix

"set foldmethod=indent

highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
highlight Folded ctermbg=none guibg=none
highlight EndOfBuffer ctermbg=none guibg=none


set background=dark
set termguicolors
colorscheme everforest
source ~/.config/nvim/plugins/neosnippet.rc.vim
source ~/.config/nvim/plugins/rust.rc.vim
let g:rustfmt_autosave = 1
"nmap gg=G :rustfmt
let g:ale_fix_on_save = 1
let g:ale_fixers = { 'rust': ['rustfmt'] }
let g:ale_rustfmt_executable = 'rustfmt'
set rtp+=~/.vim/pack/XXX/start/LanguageClient-neovim
let g:LanguageClient_serverCommands = { 'haskell': ['haskell-language-server-wrapper', '--lsp'] }
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']



function! s:treesitter_init() abort
  " load once
  if exists('g:plug_treesitter_loaded')
    return
  endif
  let g:plug_treesitter_loaded = 1

  " lazy load
  call plug#load('nvim-treesitter', 'vim-matchup')

  " initialize treesitter
  let setup_file = g:plug_home .. '/nvim-treesitter/plugin/nvim-treesitter.lua'
  execute 'luafile' setup_file

  " setup treesitter
lua << EOF
  require('nvim-treesitter.configs').setup({
    highlight = { enable = true },
    indent = { enable = true },

    -- setup modules
    matchup = { enable = true },
  })
EOF

  " enable treesitter
  TSEnable highlight
endfunction

autocmd BufReadPost * ++once call <sid>treesitter_init()


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" for coc keybind
" autocomplete
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

" <Tab>で次、<S+Tab>で前
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

