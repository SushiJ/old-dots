-- This file is automatically loaded by plugins.init

local function augroup(name)
  return vim.api.nvim_create_augroup("sushi_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ReasonML"),
  pattern = "*.re,*.rei",
  desc = "Detect and set the proper file type for ReasonML files",
  callback = function()
    vim.cmd("set filetype=reason")
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
  group = augroup("astro"),
  pattern = "*.astro",
  callback = function()
    vim.opt_local.filetype = "astro"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
  group = augroup("c_lang"),
  pattern = {
    "*.c",
    "*.cpp",
  },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "oil",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("oil"),
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("oil"),
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("nvim-metals"),
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
})

local format_is_enabled = true
vim.api.nvim_create_user_command("FormatToggle", function()
  format_is_enabled = not format_is_enabled
  print("Setting autoformatting to: " .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
  if not _augroups[client.id] then
    local id = augroup("lsp-format-" .. client.name)
    _augroups[client.id] = id
  end

  return _augroups[client.id]
end

--
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp-attach-format"),
  -- This is where we attach the autoformatting for reasonable clients
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    -- Only attach to clients that support document formatting
    if not client.server_capabilities.documentFormattingProvider then
      return
    end

    -- Tsserver usually works poorly. Sorry you work with bad languages
    -- You can remove this line if you know what you're doing :)
    if client.name == "tsserver" then
      return
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = get_augroup(client),
      buffer = bufnr,
      callback = function()
        if not format_is_enabled then
          return
        end
        vim.lsp.buf.format({
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        })
      end,
    })
  end,
})
