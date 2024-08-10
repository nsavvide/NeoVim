return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-vscode-js",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_vscode_js = require("dap-vscode-js")
		local mason_dap = require("mason-nvim-dap")

		dapui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapStopped",
			{ text = "➔", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" }
		)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		vim.keymap.set("n", "<Leader>do", dap.step_over, {})
    vim.keymap.set("n", "<Leader>dv", function() dapui.eval() end, { noremap = true, silent = true })
		vim.keymap.set("v", "<Leader>dv", function() dapui.eval() end, { noremap = true, silent = true })

		dap_vscode_js.setup({
			node_path = "node",
			debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
			adapters = { "pwa-node" },
		})

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = vim.fn.getcwd(),
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
			},
		}

		mason_dap.setup({
			ensure_installed = { "netcoredbg" },
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				netcoredbg = function(config)
					config.adapters = {
						type = "executable",
						command = "netcoredbg",
						args = { "--interpreter=vscode" },
					}
					dap.configurations.cs = {
						{
							type = "coreclr",
							name = "launch - netcoredbg",
							request = "launch",
							env = {
								ASPNETCORE_URLS = "https://localhost:5001",
								ASPNETCODE_ENVIRONMENT = "Development",
							},

							program = function()
								return vim.fn.input({
									prompt = "Path to dll: ",
									default = vim.fn.getcwd() .. "/Satoca.Api/bin/Debug/net6.0/Satoca.Api.dll",
									completion = "file",
								})
							end,
							cwd = function()
								local dll_path = vim.fn.input(
									"Path to dll: ",
									vim.fn.getcwd() .. "/Satoca.Api/bin/Debug/net6.0/",
									"file"
								)
								return vim.fn.fnamemodify(dll_path, ":h:h:h:h")
							end,
							console = "integratedTerminal",
							stopAtEntry = false,
							internalConsoleOptions = "openOnSessionStart",
							justMyCode = false,
							logging = {
								engineLogging = true,
							},
						},
						{
							type = "coreclr",
							name = "attach - netcoredbg",
							request = "attach",
							processId = require("dap.utils").pick_process,
							cwd = function()
								local dll_path = vim.fn.input(
									"Path to dll: ",
									vim.fn.getcwd() .. "/Satoca.Api/bin/Debug/net6.0/",
									"file"
								)
								return vim.fn.fnamemodify(dll_path, ":h:h:h:h")
							end,
							args = {},
							stopAtEntry = false,
							justMyCode = false,
							logging = {
								engineLogging = true,
							},
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
