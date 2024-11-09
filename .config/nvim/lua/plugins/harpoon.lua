return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>a", function()
      harpoon:list():add()
    end)
    map("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    map("n", "<C-o>", function()
      harpoon:list():select(1)
    end)
    map("n", "<C-p>", function()
      harpoon:list():select(2)
    end)
    map("n", "<C-[>", function()
      harpoon:list():select(3)
    end)
    map("n", "<C-]>", function()
      harpoon:list():select(4)
    end)
  end,
}
