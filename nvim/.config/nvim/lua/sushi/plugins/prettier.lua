return {
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("prettier").setup({
        bin = "prettierd",
        filetypes = {
          "css",
          "graphql",
          "html",
          "astro",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "tsx",
          "ts",
          "yaml",
        },
      })
    end,
  },
}
