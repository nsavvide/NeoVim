return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Set up nvim-web-devicons
		require("nvim-web-devicons").setup({
			default = true,
		})

		-- Set up Neo Tree
		require("neo-tree").setup({
			source_selector = {
				winbar = true,
				statusline = false,
			},
			default_component_configs = {
				icon = {
					folder_closed = "", -- Nerd Font icon for closed folders
					folder_open = "", -- Nerd Font icon for open folders
					folder_empty = "", -- Nerd Font icon for empty folders
					default = "", -- Nerd Font icon for default file
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
			},
			window = {
				position = "left",
				width = 40,
				mappings = {
					["o"] = "open",
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
					["t"] = "open_tabnew",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["c"] = "close_window",
				},
			},
		})

		-- Key mappings
		vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
		vim.keymap.set("n", "<leader>bc", ":Neotree close<CR>", {})
	end,
}
