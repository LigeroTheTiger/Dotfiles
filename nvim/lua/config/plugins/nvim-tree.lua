return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35, -- default width
        relativenumber = true -- show relative numbers
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = ""
            },
          },
        },
      },
      -- disable window picker to work well with window splits
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
      },
      -- filter mac os specific directory
      filters = {
        custom = { ".DS_Store" },
      },
      -- show files ignored by git
      -- -- show files ignored by git
      git = {
        ignore = false,
      }
    })

    -- keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer (open if necessary)" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end
}
