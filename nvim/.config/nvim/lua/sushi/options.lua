local opt = vim.opt

opt.guicursor = ""
opt.autowrite = true           -- Enable auto write
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.conceallevel = 3           -- Hide * markup for bold and italic
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.mouse = "a"            -- Enable mouse mode
-- opt.number = true -- Print line number
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
-- opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8          -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true      -- Round indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false       -- Dont show mode since we have a statusline
opt.sidescrolloff = 8      -- Columns of context
opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.smartindent = true     -- Insert indents automatically
opt.autoindent = true
opt.cindent = true
opt.breakindent = true
opt.spelllang = { "en" }
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.shiftwidth = 2       -- Size of an indent
opt.softtabstop = 2
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.swapfile = false
opt.backup = false
opt.undofile = true
---@diagnostic disable-next-line: assign-type-mismatch
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.updatetime = 50
opt.wildmode = "longest:full,full"
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false    -- Disable line wrap
opt.hlsearch = false
opt.incsearch = true
opt.colorcolumn = "80"
opt.encoding = "UTF-8"
opt.isfname:append("@-@")
-- opt.background = "dark"

-- opt.list = true
-- opt.listchars = { eol = "↴" }

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.markdown_composer_autostart = 0
vim.g.markdown_composer_browser = "brave"
