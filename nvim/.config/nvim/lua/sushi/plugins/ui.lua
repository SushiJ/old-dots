return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_)
      local lspInfo = {
        function()
          local msg = "404"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return "[" .. client.name .. "]"
            end
          end
          return msg
        end,
      }
      return {
        options = {
          always_divide_middle = false,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
          },
          lualine_c = {
            { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
            { "filename", path = 1 },
          },
          lualine_x = {
            {
              "diff",
              padding = { left = 0, right = 1 },
            },
            {
              "diagnostics",
              symbols = {
                error = "E: ",
                warn = "W: ",
                info = "I: ",
                hint = "H: ",
              },
            },
          },
          lualine_y = {
            { "encoding" },
            { "location" },
          },
          lualine_z = {
            lspInfo,
          },
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "|" },
        scope = { enabled = false },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      text = {
        spinner = "moon",
      },
      align = {
        bottom = true,
      },
      window = {
        relative = "editor",
      },
    },
  },
}
