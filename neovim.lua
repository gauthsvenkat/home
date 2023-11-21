-- Set the leader key.
-- Must happen before plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
local o = vim.o

o.number = true
o.relativenumber = true

-- search options
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- wrapped line will continue with the same indent
o.breakindent = true

-- extra column for signs
o.signcolumn = "yes"

o.termguicolors = true

-- theme options
o.gruvbox_material_background = "hard"
vim.cmd("colorscheme gruvbox-material")

-- Plugins
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

require("which-key").setup()

require("hlslens").setup()

-- Keymaps
-- local variable to hold some redundant stuff
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- make sure space isn't assigned anything else
keymap("", "<Space>", "<Nop>", opts)
-- clear highlights on pressing escape twice
keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true })
-- Easier window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Navigate buffers
keymap("n", "<C-e>", ":bnext<CR>", opts)
keymap("n", "<C-q>", ":bprevious<CR>", opts)
