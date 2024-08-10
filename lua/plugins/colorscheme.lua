return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require('rose-pine').setup({
				-- You can add additional configuration here
				-- e.g., dark_variant = 'moon',
				disable_background = true,
				disable_italics = false,
				variant = 'main', -- other options: 'moon', 'dawn'
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}

