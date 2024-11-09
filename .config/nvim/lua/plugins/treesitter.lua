return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  dependencies = {
    "apple/pkl-neovim",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    ensure_installed = {
      "go",
      "lua",
      "pkl",
      "rust",
      "gleam",
      "templ",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
      filetypes = { "html", "xml" },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
