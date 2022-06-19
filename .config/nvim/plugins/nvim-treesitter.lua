require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'lua',
      'c_sharp',
      'vue',
    }
  },
   indent = {
    enable = true,
  },
  ensure_installed = 'all',
}

