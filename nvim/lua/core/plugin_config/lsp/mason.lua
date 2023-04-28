require("neoconf").setup({})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "volar", "tsserver", "html", "cssls", "emmet_ls" },
})
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
	function(server_name)
		local server_config = {}
		if require("neoconf").get(server_name .. ".disable") then
			return
		end
		if server_name == "volar" then
			server_config.filetypes = { "vue", "typescript", "javascript" }
		end
		lspconfig[server_name].setup(server_config)
	end,
})
