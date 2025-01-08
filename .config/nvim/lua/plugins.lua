local plug = vim.cmd

plug [[
  call plug#begin('~/.local/share/nvim/plugged')

  " end補完
  " https://github.com/tpope/vim-endwise
  Plug 'tpope/vim-endwise'

  " 構文エラーチェック
  " https://github.com/vim-syntastic/syntastic
  Plug 'scrooloose/syntastic'

  " git rapper plugins
  " https://github.com/tpope/vim-fugitive
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

  " ファイルの形式を文脈で判断するプラグイン
  Plug 'Shougo/context_filetype.vim'

  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  " LSP client
  Plug 'rust-lang/rust.vim', {'branch': 'release'}

  " LSP server
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'dense-analysis/ale'
  Plug 'sainnhe/everforest'

  " (Optional) Multi-entry selection UI.
  "Plug 'junegunn/fzf'
  Plug 'Shougo/deoplete.nvim'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  
  Plug 'andymass/vim-matchup', { 'on': [] }

  call plug#end()
]]
