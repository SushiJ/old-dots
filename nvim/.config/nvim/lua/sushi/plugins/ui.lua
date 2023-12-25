return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("sushi.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
  -- { "arkav/lualine-lsp-progress" },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_)
      -- local icons = require("sushi.config").icons
      --
      -- local function fg(name)
      --   return function()
      --     ---@type {foreground?:number}?
      --     local hl = vim.api.nvim_get_hl_by_name(name, true)
      --     return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      --   end
      -- end
      local lspInfo = {
        function()
          local msg = ""
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
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
          theme = "rose-pine",
          always_divide_middle = false,
          -- globalstatus = false,
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
        extensions = { "neo-tree" },
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
  { "HiPhish/rainbow-delimiters.nvim" },
}
