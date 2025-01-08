-- lua/settings.lua

-- エンコーディング設定
vim.opt.encoding = "utf-8"
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

-- コマンド設定
vim.opt.wildmenu = true
vim.opt.history = 5000

if vim.opt.compatible:get() then
    vim.opt.compatible = false
end

vim.cmd [[syntax enable]]

-- ターミナルカラーを有効にする
vim.opt.termguicolors = true

-- タブとインデント設定
vim.opt.showmatch = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- その他の設定...
