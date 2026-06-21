return {
  "marko-cerovac/material.nvim",
  priority = 1000,
  config = function()
    require("material").setup({
      contrast = {
        sidebars = false,
        floating_windows = false,
        cursor_line = false,
        lsp_virtual_text = false
      }
    })

    vim.g.material_style = "deep ocean"
    vim.cmd("colorscheme material")
  end
}
