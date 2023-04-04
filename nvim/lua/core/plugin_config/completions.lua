local cmp = require("cmp")

vim.api.nvim_set_hl(0, "transparentBG", { bg = "NONE", fg = "LightGray" })

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#ffffff", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#2688cd", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#1d7c79", bg = "NONE" })

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<leader>"] = cmp.mapping.confirm({ select = false }),
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:transparentBG,FloatBorder:transparentBG,Search:None",
		}),
	},
})
