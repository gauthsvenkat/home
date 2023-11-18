vim.o.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true

vim.g.gruvbox_material_background = 'hard'
vim.cmd('colorscheme gruvbox-material')

require('nvim-treesitter.configs').setup{
  highlight = {enable = true},
  indent = {enable = true},
}

require("which-key").setup()

require("hlslens").setup()
