-- Misc (stuff that needs to happen in the beginning)
---- set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- only activate quick-scope on the following presses
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

--- more color!!!
o.termguicolors = true

---- theme options
o.gruvbox_material_background = "hard"
vim.cmd("colorscheme gruvbox-material")

-- Plugins
---- helpful functions for other nvim plugins
require("plenary")
---- make working with brackets easier
require("nvim-autopairs").setup()
---- indentation guides
require("ibl").setup({ enabled = false })
---- status indicator
require("lualine").setup()
---- buffer tab indicator
require("bufferline").setup()
---- helps searching
require("hlslens").setup({ calm_down = true })
---- explorer
require("nvim-tree").setup({ renderer = { highlight_git = true } })
---- monitor git changes
require("gitsigns").setup()
---- terminal
require("toggleterm").setup()
---- file finder
require("telescope").setup()
---- code parser for the modern era
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

-- Keymaps
---- local variable to hold some redundant stuff
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

---- make sure space isn't assigned anything else
keymap("", "<Space>", "<Nop>", opts)

---- clear highlights on pressing escape
keymap("n", "<Esc>", ":noh<cr>", opts)
---- exit from terminal mode on pressing escape
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

---- easier window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-q>", "<cmd>bprevious<cr>", opts)
keymap("n", "<C-e>", "<cmd>bnext<cr>", opts)

---- resize pane with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

---- mapping to quickly move lines or visual blocks
keymap("n", "<A-j>", ":m .+1<cr>==", opts)
keymap("n", "<A-down>", ":m .+1<cr>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<cr>==gi", opts)
keymap("i", "<A-down>", "<Esc>:m .+1<cr>==gi", opts)
keymap("x", "<A-j>", ":m '>+1<cr>gv=gv", opts)
keymap("x", "<A-down>", ":m '>+1<cr>gv=gv", opts)
keymap("n", "<A-k>", ":m .-2<cr>==", opts)
keymap("n", "<A-up>", ":m .-2<cr>==", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<cr>==gi", opts)
keymap("i", "<A-up>", "<Esc>:m .-2<cr>==gi", opts)
keymap("x", "<A-k>", ":m '<-2<cr>gv=gv", opts)
keymap("x", "<A-up>", ":m '<-2<cr>gv=gv", opts)

local wk = require("which-key")
wk.setup()
wk.register({
	e = {
		name = "Explorer",
		e = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
		f = { "<cmd>NvimTreeFindFile<cr>", "Find current file in Explorer" },
		c = { "<cmd>NvimTreeCollapse<cr>", "Collapse tree" },
		w = { "<cmd>NvimTreeFocus<cr>", "Focus on Explorer" },
	},
	f = {
		name = "Telescope",
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		t = { "<cmd>Telescope live_grep<cr>", "Find file with matching text" },
		b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
		c = { "<cmd>Telescope command_history<cr>", "Find command in history" },
		k = { "<cmd>Telescope keymaps<cr>", "Find (normal mode) keymaps" },
		v = { "<cmd>Telescope treesitter<cr>", "Find (treesitter) variables" },
	},
	g = {
		name = "Gitsigns",
		s = { "<cmd>Gitsigns toggle_signs<cr>", "Toggle signs" },
		n = { "<cmd>Gitsigns toggle_numhl<cr>", "Highlight line numbers" },
		l = { "<cmd>Gitsigns toggle_linehl<cr>", "Highlight changed lines" },
		w = { "<cmd>Gitsigns toggle_word_diff<cr>", "Show word diffs" },
		d = { "<cmd>Gitsigns toggle_deleted<cr>", "Show deleted lines" },
		b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Show blame" },
		q = { "<cmd>Gitsigns prev_hunk<cr>", "Jump to prev hunk" },
		e = { "<cmd>Gitsigns next_hunk<cr>", "Jump to next hunk" },
		r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
		c = { "<cmd>Telescope git_commits<cr>", "Show commits" },
		o = { "<cmd>Telescope git_branches<cr>", "Show branches" },
	},
	t = {
		name = "Terminal",
		t = { "<cmd>ToggleTerm direction=horizontal size=10<cr>", "Bottom terminal" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Floating terminal" },
	},
	i = {
		name = "Indent Guide",
		i = { "<cmd>IBLToggle<cr>", "Toggle Indent Guide" },
		s = { "<cmd>IBLToggleScope<cr>", "Toggle Scope Guide" },
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
