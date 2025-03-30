-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.scrolloff = 10

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.cmd("au BufRead,BufNewFile *.templ setfiletype templ")
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.templ" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "templ")
  end,
})

vim.opt.rtp:prepend(lazypath)

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Tabs vs spaces
vim.o.tabstop = 2 -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true
vim.o.wrap = false

-- Enable spellcheck
vim.opt.spell = true
vim.opt.spelllang = "en_us"

local map = vim.keymap.set

map("n", "J", "mzJ`z", { desc = "Combine lines down" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next match" })
map("n", "N", "Nzzzv", { desc = "Previous match" })
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank rest of line to clipboard" })
map("n", "<leader>d", '"_d', { desc = "Delete without yanking" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>d", '"_d', { desc = "Delete without yanking" })
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data")
  .. "/mason/bin"
  .. (is_windows and ";" or ":")
  .. vim.env.PATH

require("lazy").setup("plugins")
