require("mason").setup({
	PATH = "prepend",
})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "volar", "cssls", "html", "emmet_ls" },
})

require("mason-null-ls").setup({
	ensure_installed = { "prettier", "eslint_d" },
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
local lspconfig = require("lspconfig")

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
debug = false,

	sources = {
		formatting.eslint_d,
		-- formatting.prettier.with({
		--     filetypes = {
		-- 		"css",
		-- 		"scss",
		-- 		"less",
		-- 		"html",
		-- 		"json",
		-- 		"jsonc",
		-- 		"yaml",
		-- 		"markdown",
		-- 		"graphql",
		-- 	},
		--   }),
		diagnostics.eslint_d.with({ -- linter
			-- use eslint only if .eslintrc file exists
			condition = function(utils)
				return utils.root_has_file(".eslintrc") -- change file extension if you use something else
			end,
		}),
	},

	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})

--vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("n", "<leader>nd", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
vim.keymap.set("n", "<leader>pd", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		vim.keymap.set("n", "<leader>gD", ":TypescriptGoToSourceDefinition<CR>") -- go to definition
		vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end

	if client.name == "volar" then
		vim.keymap.set("n", "<leader>gD", ":lua vim.lsp.buf.definition()<CR>") -- go to definition
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({})

-- configure vue server
lspconfig.volar.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "vue" },
})

-- configure emmet language server
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})
