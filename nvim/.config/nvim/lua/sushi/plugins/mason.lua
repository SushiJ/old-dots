return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsp_zero = require("lsp-zero")
			local lsp_config = require("lspconfig")
			require("mason-lspconfig").setup({
				automatic_installation = true,
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) configure lua language server
						local lua_opts = lsp_zero.nvim_lua_ls()
						lsp_config.lua_ls.setup(lua_opts)
					end,
					clangd = function()
						local capabilities = vim.lsp.protocol.make_client_capabilities()
						capabilities.offsetEncoding = { "utf-16" }
						lsp_config.clangd.setup({
							capabilities = capabilities,
						})
					end,
					pylsp = function()
						lsp_config.pylsp.setup({
							settings = {
								pylsp = {
									plugins = {
										pycodestyle = {
											ignore = { "W391", "E501" },
											maxLineLength = 100,
										},
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
