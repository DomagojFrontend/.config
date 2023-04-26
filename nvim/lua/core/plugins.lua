local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- theme
	{ "svrana/neosolarized.nvim", dependencies = { "tjdevries/colorbuddy.nvim" } },
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",

	-- syntax highlighting
	"nvim-treesitter/nvim-treesitter",

	-- find files
	{ "nvim-telescope/telescope.nvim", tag = "0.1.0", dependencies = { "nvim-lua/plenary.nvim" } },
	"nvim-telescope/telescope-file-browser.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- git interigation
	"lewis6991/gitsigns.nvim",

	-- LSP config
	"neovim/nvim-lspconfig",

	-- code completition
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"l3mon4d3/luasnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
	"chris Arbeitszeitoomey/vim-tmux-navigator",

	-- codeium
	"Exafunction/codeium.vim",

	-- mini.nvim
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.move",
		version = false,
		config = function()
			require("mini.move").setup()
		end,
	},
}

local opts = {}

require("lazy").setup(plugins, opts)
