local opt = vim.opt
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
require("cmp").setup.buffer({ enabled = false })