return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
    "icon",
     "permissions",
     "size",
     "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      max_width = 0.5,         -- Optional: constrain width
      max_height = 0.5,        -- Optional: constrain height
      border = "rounded",     -- Optional: rounded border
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
