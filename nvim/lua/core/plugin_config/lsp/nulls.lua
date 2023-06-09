local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end
-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"shellcheck", -- bash linter
		"shfmt", -- bash formatter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)

		-- Bash
		formatting.shfmt, -- formatter
		diagnostics.shellcheck, -- linter

		-- Lua
		formatting.stylua, -- formatter

		-- TypeScript/JavaScript etc
		formatting.prettier.with({
			disable_filetypes = { "vue" },
		}), -- formatter
		formatting.eslint_d.with({
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		}),
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
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
