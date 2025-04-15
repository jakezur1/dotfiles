return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = require("langs"),
      handlers = {
        function(server_name)
          -- Define an on_attach callback that sets up autoformatting for servers with formatting support.
          local on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
              local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
              vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end
          end

          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      },
    })
  end,
}
