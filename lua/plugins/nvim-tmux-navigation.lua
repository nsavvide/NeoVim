return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    require('nvim-tmux-navigation').setup({
      -- Add any custom configuration options here
    })

    local opts = { noremap = true, silent = true }

    -- Keybindings for navigating between splits and tmux panes
    vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", opts)
    vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", opts)
    vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", opts)
    vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", opts)

    -- Keybindings for creating splits
    vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", opts)  -- Horizontal split
    vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", opts)  -- Vertical split

    -- Keybindings for resizing splits
    vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", opts)     -- Increase height
    vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", opts)   -- Decrease height
    vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", opts)  -- Decrease width
    vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", opts) -- Increase width
  end,
}

