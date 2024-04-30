return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()
			local pretty_hover = require("pretty_hover")
			local function diagnostic_goto(next, severity)
				local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
				severity = severity and vim.diagnostic.severity[severity] or nil
				return function()
					go({ severity = severity })
				end
			end
			lsp_zero.on_attach(function(_client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				local map = function(mode, keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = desc, silent = true })
				end

				map("", "<leader>cd", vim.diagnostic.open_float, "Show Diagnostics Error")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("", "<leader>cl", "<cmd>LspInfo<cr>", "Show Lsp Info")
				map("", "<leader>rn", vim.lsp.buf.rename, "Rename")
				map("", "gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
				map("", "gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
				map("", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("", "gI", "<cmd>Telescope lsp_implementations<cr>", "[G]oto [I]mplementation")
				map("", "gt", "<cmd>Telescope lsp_type_definitions<cr>", "[G]oto [T]ype Definition")
				-- map("", "K", vim.lsp.buf.hover, "Hover")
				map("", "K", pretty_hover.hover, "Hover")
				map("", "gK", vim.lsp.buf.signature_help, "Signature Help")
				map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				map("", "]d", diagnostic_goto(true), "Next Diagnostic")
				map("", "[d", diagnostic_goto(false), "Prev Diagnostic")
				map("", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
				map("", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
				map("", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
				map("", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")
			end)
		end,
	},
	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_window = require("cmp.config.window")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp_window.bordered(),
					documentation = cmp_window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(_, item)
						local icons = require("sushi.config").icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},

	-- Scala Lsp
	{
		"scalameta/nvim-metals",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	},
}
