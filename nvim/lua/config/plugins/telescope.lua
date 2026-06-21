return {
  -- master tracks fixes for Neovim 0.11 deprecations (the 0.1.x branch does not)
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        cache_picker = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to previous result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send file to quick-fix list and open it
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- telescope keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>fT", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Open last Picker" })
  end,
}
