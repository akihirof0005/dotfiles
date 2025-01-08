-- プラグインの管理
vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')
]]

local plugins = {
    {'tpope/vim-endwise'},                        -- end補完
    {'scrooloose/syntastic'},                     -- 構文エラーチェック
    {'tpope/vim-fugitive'},                       -- git rapper plugins
    {'airblade/vim-gitgutter'},                   -- A Vim plugin which shows a git diff in the sign column.
    {'osyo-manga/vim-anzu'},                      -- 検索時にマッチした個数とそれが何番目であるかの情報を表示する
    {'udalov/kotlin-vim'},                        -- シンタックスハイライト for kotlin
    {'tfnico/vim-gradle'},                        -- シンタックスハイライト for gradle
    {'bronson/vim-trailing-whitespace'},          -- Trailing whitespace removal
    {'vim-scripts/groovyindent-unix'},            -- groovy indent script
    {'glepnir/zephyr-nvim'},                      -- Zephyr theme
    {'itchyny/lightline.vim'},                    -- ステータスライン
    {'Shougo/context_filetype.vim'},              -- ファイルの形式を文脈で判断するプラグイン
    {'Shougo/neosnippet.vim'},                    -- Snippet support
    {'Shougo/neosnippet-snippets'},               -- Snippet snippets
    {'rust-lang/rust.vim', {'branch': 'release'}},  -- LSP client
    {'neoclide/coc.nvim', {'branch': 'release'}}, -- LSP server
    {'dense-analysis/ale'},                        -- Asynchronous linting
    {'sainnhe/everforest'},                        -- Everforest color scheme
    {'Shougo/deoplete.nvim'},                      -- Deoplete for autocompletion
    {'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }},  -- Treesitter
    {'andymass/vim-matchup', { 'on': [] }}       -- Matchup plugin
}

for _, plugin in ipairs(plugins) do
    vim.cmd('Plug "' .. plugin[1] .. '"')
end

vim.cmd [[
  call plug#end()
]]

-- エンコーディング設定
vim.opt.encoding = "utf-8"
vim.opt.scriptencoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "euc-jp", "cp932" }
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.ambiwidth = "double"

-- ビュー設定
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamed"
vim.opt.hlsearch = true
vim.cmd [[tnoremap <silent> <ESC> <C-\><C-n>]]
vim.cmd [[source $VIMRUNTIME/macros/matchit.vim]]

-- コマンド設定
vim.opt.wildmenu = true
vim.opt.history = 5000

if vim.opt.compatible:get() then
    vim.opt.compatible = false
end

vim.cmd [[syntax enable]]
vim.opt.t_Co = 256

vim.cmd [[command! UP UpdateRemotePlugins]]

vim.api.nvim_set_keymap('n', 's', '<Nop>', {})
vim.api.nvim_set_keymap('n', 'sw', '<C-w>w', {})
vim.api.nvim_set_keymap('n', 'ss', ':<C-u>sp<CR>', {})
vim.api.nvim_set_keymap('n', 'sv', ':<C-u>vs<CR>', {})

-- タブとインデント設定
vim.opt.showmatch = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- フォーマット用スニペット
vim.api.nvim_set_keymap('n', 'gg', '=G :call CocAction("format")<CR>', {})

-- コピー＆ペースト用の設定
vim.opt.clipboard:append("unnamedplus")
vim.opt.fileformat = "unix"

-- ハイライト設定
local highlights = {
    Normal = { ctermbg = "none", guibg = "none" },
    NonText = { ctermbg = "none", guibg = "none" },
    LineNr = { ctermbg = "none", guibg = "none" },
    Folded = { ctermbg = "none", guibg = "none" },
    EndOfBuffer = { ctermbg = "none", guibg = "none" },
}

for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
end

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd [[colorscheme everforest]]

vim.cmd [[source ~/.config/nvim/plugins/neosnippet.rc.vim]]
vim.cmd [[source ~/.config/nvim/plugins/rust.rc.vim]]

vim.g.rustfmt_autosave = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = { rust = { 'rustfmt' } }
vim.g.ale_rustfmt_executable = 'rustfmt'

vim.opt.rtp:append("~/.vim/pack/XXX/start/LanguageClient-neovim")
vim.g.LanguageClient_serverCommands = { haskell = { 'haskell-language-server-wrapper', '--lsp' } }
vim.g.LanguageClient_rootMarkers = { '*.cabal', 'stack.yaml' }

local function treesitter_init()
    if vim.g.plug_treesitter_loaded then return end
    vim.g.plug_treesitter_loaded = 1

    vim.cmd('PlugLoad nvim-treesitter vim-matchup')

    local setup_file = vim.g.plug_home .. '/nvim-treesitter/plugin/nvim-treesitter.lua'
    vim.cmd('luafile ' .. setup_file)

    require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        indent = { enable = true },
        matchup = { enable = true },
    })

    vim.cmd('TSEnable highlight')
end

vim.cmd [[autocmd BufReadPost * ++once lua treesitter_init()]]

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.')[col]:match('%s')
end

-- cocのキーバインド設定
vim.api.nvim_set_keymap('i', '<C-j>', [[coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-k>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Enter>', [[coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Esc>', [[coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-h>', [[coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"]], { silent = true, expr = true })

-- <Tab>で次、<S+Tab>で前
vim.api.nvim_set_keymap('i', '<TAB>', [[coc#pum#visible() ? coc#pum#next(1) : check_back_space() ? "\<Tab>" : coc#refresh()]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"]], { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { silent = true })
