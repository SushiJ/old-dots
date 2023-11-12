return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.beautysh,
          nls.builtins.formatting.stylua,

          nls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = '[eslint] #{m}\n(#{c})'
          }),

          nls.builtins.code_actions.eslint_d,
          nls.builtins.completion.spell
        },
      }
    end,
  },
}
