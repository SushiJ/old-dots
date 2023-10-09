return {
  {'williamboman/mason.nvim' ,
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  {'williamboman/mason-lspconfig.nvim',
    config = function()
      local lsp_zero = require("lsp-zero")
      require('mason-lspconfig').setup{
        automatic_installation = true,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) configure lua language server
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      }
    end,
  },
}
