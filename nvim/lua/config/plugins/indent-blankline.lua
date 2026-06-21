return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl", -- how to require main module
  opts = {
    indent = { char = "┊" },
  },
}
