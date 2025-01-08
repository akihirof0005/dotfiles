-- lua/keymaps.lua

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.')[col]:match('%s')
end

-- cocのキーバインド設定
vim.api.nvim_set_keymap('i', '<C-j>', [[coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-k>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Enter>', [[coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Esc>', [[coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"]], { silent = true, expr = true })

-- <Tab>で次、<S+Tab>で前
vim.api.nvim_set_keymap('i', '<TAB>', [[coc#pum#visible() ? coc#pum#next(1) : check_back_space() ? "\<Tab>" : coc#refresh()]], { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"]], { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { silent = true })

-- その他のキーバインド...

