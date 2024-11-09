return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clang-format",
        "clangd",
        "css-lsp",
        "eslint_d",
        "html-lsp",
        "jdtls",
        "latexindent",
        "lua-language-server",
        "prettier",
        "pylint",
        "pyright",
        "stylua",
        "typescript-language-server",
      },
    },
    dependencies = { "williamboman/mason.nvim" },
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
  },
}
