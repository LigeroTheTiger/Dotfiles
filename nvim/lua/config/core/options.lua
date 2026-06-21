vim.cmd("let g:netrw_liststyle = 3")
vim.cmd(
  "let g:python3_host_prog = '/home/ligero/.cache/pypoetry/virtualenvs/protect-backend-YsDx_MOx-py3.13/bin/python'"
)

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- termguicolors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backsapce
opt.backspace = "indent,eol,start" -- allow backspace on indent, eol, insert mode

opt.clipboard:append("unnamedplus") -- use system clipboard

-- splits
opt.splitright = true
opt.splitbelow = true

-- swap file
vim.o.swapfile = false
