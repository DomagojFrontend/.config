require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vue", "css", "scss", "javascript", "typescript" },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
