vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.history = 10000
vim.opt.backup = false
vim.opt.hidden = true
vim.opt.swapfile = false

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = true
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.updatetime = 100
-- need to set vertical line

vim.opt.scrolloff = 999

vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true

-- removes status bar
vim.opt.laststatus = 0


-- Function to setup writing mode
local function writing_mode()
  vim.opt.linebreak = true
  vim.opt.textwidth = 80
  vim.opt.spell = true
  vim.opt.spelllang = { 'en_us' }
  vim.opt.conceallevel = 2
  vim.opt.foldmethod = 'marker'
  vim.opt.foldlevel = 0
end

-- Function to setup coding mode
local function coding_mode()
  vim.opt.linebreak = false
  vim.opt.textwidth = 0
  vim.opt.spell = false
  vim.opt.conceallevel = 0
  vim.opt.foldmethod = 'syntax'
end

-- Commands to switch modes
vim.api.nvim_create_user_command('WritingMode', writing_mode, {})
vim.api.nvim_create_user_command('CodingMode', coding_mode, {})
