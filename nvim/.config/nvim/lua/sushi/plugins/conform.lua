return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      graphql = { "prettierd", "prettier" },
      md = { "prettierd", "prettier" },
      txt = { "prettierd", "prettier" },
    },
    formatters = {
      stylua = {
        args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
      },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
