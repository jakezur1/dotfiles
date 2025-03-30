return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local on_attach = function(_, bufnr)
      local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
      end

      local map = vim.keymap.set
      map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
      map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
      map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
      map(
        "n",
        "<leader>sh",
        vim.lsp.buf.signature_help,
        opts("Show signature help")
      )
      map(
        "n",
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        opts("Add workspace folder")
      )
      map(
        "n",
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        opts("Remove workspace folder")
      )

      map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts("List workspace folders"))

      map(
        "n",
        "<leader>D",
        vim.lsp.buf.type_definition,
        opts("Go to type definition")
      )

      map("n", "<leader>ra", function()
        vim.lsp.buf.rename()
      end)

      map(
        { "n", "v" },
        "<leader>ca",
        vim.lsp.buf.code_action,
        opts("Code action")
      )
      map("n", "gr", vim.lsp.buf.references, opts("Show references"))

      map("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end, opts("Show error float"))
    end

    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    lspconfig.pyright.setup({
      on_attach = on_attach,
    })

    lspconfig.ts_ls.setup({
      on_attach = on_attach,
    })

    lspconfig.clangd.setup({
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    })

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            disable = { "different-requires" },
          },
        },
      },
    })

    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      filetypes = { "rust" },
      root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
      settings = {
        ["rust_analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    })

    lspconfig.gopls.setup({
      on_attach = on_attach,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        env = {
          GOEXPERIMENT = "rangefunc",
        },
        formatting = {
          gofumpt = true,
        },
      },
    })

    -- lspconfig.tailwindcss.setup({
    --   on_attach = on_attach,
    --   settings = {
    --     includeLanguages = {
    --       templ = "html",
    --     },
    --   },
    -- })
    --

    lspconfig.cssls.setup({
      on_attach = on_attach,
    })

    lspconfig.templ.setup({
      on_attach = on_attach,
    })

    lspconfig.dafny.setup({
      on_attach = on_attach,
    })

    lspconfig.nil_ls.setup({})

    lspconfig.ocamlls.setup({})
  end,
}
