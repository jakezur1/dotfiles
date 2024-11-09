return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  cmd = "WhichKey",
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
