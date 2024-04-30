return {
	-- Reason parser
	-- { "danielo515/nvim-treesitter-reason" },
	-- Rescript parser
	-- { "nkrkv/nvim-treesitter-rescript" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			auto_install = true,
			sync_install = false,
			ignore_install = { "" },
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			ensure_installed = {
				"lua",
				"luap",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- { "nvim-treesitter/nvim-treesitter-context" }
}
