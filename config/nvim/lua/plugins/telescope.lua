return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      wk.add({
        {
          "<leader>ff",
          function()
            builtin.find_files({
              hidden = true,
              no_ignore = true,
            })
          end,
          desc = "Find File",
        },
        { "<leader>fb", builtin.buffers, desc = "Find Buffer" },
        {
          "<leader>fg",
          function()
            -- live_grep will use the updated vimgrep_arguments that include "--hidden"
            builtin.live_grep()
          end,
          desc = "Find with Grep",
        },
        { "<leader>fh", builtin.help_tags, desc = "Find Help" },
        {
          "<leader>fn",
          ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
          desc = "File Browser",
        },
      })
    end,
    opts = function()
      return {
        defaults = {
          initial_mode = "insert", -- start in normal mode
          vimgrep_arguments = {
            "rg",
            "-L",
            "--hidden", -- include hidden files in grep
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          previewer = true,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            grouped = true,
            hidden = true,
            initial_mode = "normal",
            respect_gitignore = false,
          },
        },
        extensions_list = {
          "file_browser",
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
