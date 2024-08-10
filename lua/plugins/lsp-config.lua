return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			-- C#
			lspconfig.omnisharp.setup({
				cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
				settings = {
					omnisharp = {
						enableRoslynAnalyzers = true,
						organizeImportsOnFormat = true,
						enableEditorConfigSupport = true,
					},
				},
				on_attach = function(client)
					if client.server_capabilities.documentFormattingProvider then
						vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })")
					end
				end,
			})

			-- Solargraph (Ruby)
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})

			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- JSON
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

			-- CSS
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
