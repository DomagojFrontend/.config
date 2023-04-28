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
	"christoomey/vim-tmux-navigator",
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- syntax highlighting
	"nvim-treesitter/nvim-treesitter",

	-- find files
	{ "nvim-telescope/telescope.nvim", tag = "0.1.0", dependencies = { "nvim-lua/plenary.nvim" } },
	"nvim-telescope/telescope-file-browser.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- mason
	"folke/neoconf.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- git interigation
	"lewis6991/gitsigns.nvim",

	-- LSP config
	"neovim/nvim-lspconfig",

	-- code completition
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			-- Snippet Engine
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"onsails/lspkind.nvim",
		},
	},
	-- "hrsh7th/cmp-buffer",
	-- "hrsh7th/cmp-path",
	-- "onsails/lspkind.nvim",
	"glepnir/lspsaga.nvim",
	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/cmp-vsnip",
	-- "hrsh7th/vim-vsnip",

	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"rafamadriz/friendly-snippets",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 	},
	-- },

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

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
