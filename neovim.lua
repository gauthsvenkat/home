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
require("plenary")
require("nvim-autopairs").setup()
require("ibl").setup()
require("lualine").setup()
require("hlslens").setup()
require("nvim-tree").setup()
require("gitsigns").setup()
require("toggleterm").setup()
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

-- whichkey will be setup here
-- but keybindings will be in the bottom
local wk = require("which-key")
wk.setup()

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

wk.register({
	t = {
		name = "Terminal",
		t = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
	},
	e = {
		name = "Explorer",
		e = { "<cmd>NvimTreeToggle<CR>", "Toggle Explorer" },
		f = { "<cmd>NvimTreeFindFile<CR>", "Find the current file" },
		c = { "<cmd>NvimTreeCollapse<CR>", "Collapse tree" },
	},
	f = {
		name = "Telescope",
		f = { "<cmd>Telescope find_files<CR>", "Find files" },
		t = { "<cmd>Telescope live_grep<CR>", "Find file with matching text" },
	},
}, {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
	expr = false, -- use `expr` when creating keymaps
})
