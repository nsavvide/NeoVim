return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			session_lens = {
				-- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
				buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session when a new one is loaded
			},
			vim.keymap.set("n", "S", require("auto-session.session-lens").search_session, {
				noremap = true,
			}),
		})
	end,
}
