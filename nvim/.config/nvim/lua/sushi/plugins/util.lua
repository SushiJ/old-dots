return {
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "tpope/vim-repeat", event = "VeryLazy" },

	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },

	{ "mbbill/undotree" },
	{ "windwp/nvim-ts-autotag" },
	{ "wuelnerdotexe/vim-astro" },
	{ "mattn/emmet-vim" },
	{ "uga-rosa/ccc.nvim" },
	{ "neovim/nvim-lspconfig", opts = {
		servers = {
			tailwindcss = {},
		},
	} },
	{
		"nvchad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"roobert/tailwindcss-colorizer-cmp.nvim",
			config = true,
		},
		opts = function(_, opts)
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item)
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- {
	-- 	"dhruvmanila/browser-bookmarks.nvim",
	-- 	config = function()
	-- 		require("browser-bookmarks").setup({
	-- 			selected_browser = "brave",
	-- 		})
	-- 	end,
	-- },
}
