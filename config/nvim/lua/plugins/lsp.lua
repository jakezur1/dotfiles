return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	lazy = false,
	config = function()
		-- Configure diagnostics to show inline virtual text for warnings and errors.
		vim.diagnostic.config({
			virtual_text = {
				-- Only show virtual text for messages with severity WARN or higher (i.e. WARN and ERROR)
				severity = { min = vim.diagnostic.severity.WARN },
			},
			signs = true,
			underline = true,
			update_in_insert = false,
		})

		-- Extend default capabilities (including those for cmp_nvim_lsp)
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- Use an autocmd to attach all desired keymaps when an LSP attaches to a buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", opts)
				vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "<leader>e", function()
					vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
				end, opts)
			end,
		})

		-- Handle special case: mason can't install dafny
		if vim.fn.executable("dafny") then
			require("lspconfig").dafny.setup({})
		end
	end,
}
