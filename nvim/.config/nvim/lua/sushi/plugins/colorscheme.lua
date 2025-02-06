return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "hard"
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       transparent_background = false,
  --       -- term_colors = true,
  --       -- no_italic = false,
  --       -- no_bold = false,
  --       -- styles = {
  --       --   comments = {},
  --       --   conditionals = {},
  --       --   loops = {},
  --       --   functions = {},
  --       --   keywords = {},
  --       --   strings = {},
  --       --   variables = {},
  --       --   numbers = {},
  --       --   booleans = {},
  --       --   properties = {},
  --       --   types = {},
  --       -- },
  --       color_overrides = {
  --         mocha = {
  --           base = "#000000",
  --           mantle = "#000000",
  --           crust = "#000000",
  --         },
  --       },
  --       -- highlight_overrides = {
  --       --   mocha = function(C)
  --       --     return {
  --       --       TabLineSel = { bg = C.pink },
  --       --       CmpBorder = { fg = C.surface2 },
  --       --       Pmenu = { bg = C.none },
  --       --       TelescopeBorder = { link = "FloatBorder" },
  --       --     }
  --       --   end,
  --       -- },
  --     })
  --     -- vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  -- {
  --   "sushij/vesper-nvim",
  --   config = function()
  --     vim.cmd([[colorscheme vesper]])
  --   end,
  -- },
}
