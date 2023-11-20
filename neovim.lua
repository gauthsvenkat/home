-- Options
vim.o.number = true
vim.o.relativenumber = true

-- search options
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- wrapped line will continue with the same indent
vim.o.breakindent = true

-- extra column for signs
vim.o.signcolumn = "yes"

vim.o.termguicolors = true

-- theme options
vim.o.gruvbox_material_background = "hard"
vim.cmd("colorscheme gruvbox-material")

-- Plugins
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

require("which-key").setup()

require("hlslens").setup()

-- Keymaps
