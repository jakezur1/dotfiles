return {
  "SirVer/ultisnips",
  ft = { "tex" },
  init = function()
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
    vim.g.UltiSnipsSnippetDirectories = { "~/.config/UltiSnips/" }
  end,
}
