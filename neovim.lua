-- Misc (stuff that needs to happen in the beginning)
---- set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.qs_highlight_on_keys = { "f", "F" }

---- disable netrw for NvimTree to work properly
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Options
local o = vim.o

---- numbering
o.number = true
o.relativenumber = true

---- window splitting
o.splitbelow = true
o.splitleft = true

---- search options
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

---- wrapped line will continue with the same indent
o.breakindent = true

---- extra column for signs
o.signcolumn = "yes"

o.termguicolors = true

---- theme options
o.gruvbox_material_background = "hard"
vim.cmd("colorscheme gruvbox-material")

-- Plugins
require("plenary")
require("nvim-autopairs").setup()
require("ibl").setup()
require("lualine").setup()
require("bufferline").setup()
require("hlslens").setup()
require("nvim-tree").setup()
require("gitsigns").setup()
require("toggleterm").setup()
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

---- whichkey will be setup here
---- but keybindings will be in the bottom
local wk = require("which-key")
wk.setup()

-- Keymaps
---- local variable to hold some redundant stuff
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

---- make sure space isn't assigned anything else
keymap("", "<Space>", "<Nop>", opts)
---- clear highlights on pressing escape twice
keymap("n", "<Esc><Esc>", ":noh<CR>", opts)
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
---- easier window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

---- mapping to quickly move lines
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-down>", ":m .+1<CR>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-down>", "<Esc>:m .+1<CR>==gi", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-down>", ":m '>+1<CR>gv=gv", opts)

keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("n", "<A-up>", ":m .-2<CR>==", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<A-up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-up>", ":m '<-2<CR>gv=gv", opts)

wk.register({
	["w"] = { "<cmd>NvimTreeToggle<CR>", "Toggle Explorer" },
	["t"] = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Terminal" },
	["q"] = { "<cmd>bprevious<CR>", "Previous buffer" },
	["e"] = { "<cmd>bnext<CR>", "Next buffer" },
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
