return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = false, -- Do not make it true
    config = function()
      local lsp_zero = require("lsp-zero")
      local pretty_hover = require("pretty_hover")

      local function diagnostic_goto(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end

      local on_attach = function(_client, bufnr)
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
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("", "]d", diagnostic_goto(true), "Next Diagnostic")
        map("", "[d", diagnostic_goto(false), "Prev Diagnostic")
        map("", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
        map("", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
        map("", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
        map("", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")
      end

      -- Language servers
      local lspconfig = require("lspconfig")
      local lsp_configurations = require("lspconfig.configs")

      if not lsp_configurations.ts_ls then
        lsp_configurations.ts_ls = {
          default_config = {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
          },
        }
      end

      lspconfig.rust_analyzer.setup({})
      lspconfig.lua_ls.setup({
        on_init = function(client)
          lsp_zero.nvim_lua_settings(client, {})
        end,
      })
      lspconfig.ts_ls.setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/home/sushi/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin",
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
          "typescriptreact",
          "javascriptreact",
        },
      })
      lspconfig.tailwindcss.setup({})
      lspconfig.gopls.setup({})
      lspconfig.nil_ls.setup({})
      lspconfig.ols.setup({})
      lspconfig.ccls.setup({})
      lspconfig.templ.setup({})
      lspconfig.volar.setup({})

      --Enable (broadcasting) snippet capability for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
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
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
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
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "path" },
          { name = "calc" },
        }),
        view = {
          entries = "custom",
          selection_order = "near_cursor",
          docs = {
            auto_open = false,
          },
        },
        formatting = {
          format = function(entry, item)
            local icons = require("sushi.config").icons.kinds
            local calc = "󰃬 "
            item.abbr = string.sub(item.abbr, 1, 50)

            item.menu = ({
              buffer = "[BUFFER]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
            })[entry.source.name]

            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            if entry.source.name == "calc" then
              item.kind = calc
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

  -- -- Scala Lsp
  -- {
  --   "scalameta/nvim-metals",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
}
