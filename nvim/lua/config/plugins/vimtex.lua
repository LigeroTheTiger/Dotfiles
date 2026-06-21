return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    vim.g.vimtex_view_general_options_latexmk = "--unique"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
    vim.g.maplocalleader = ","
    vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
    vim.g.vimtex_log_ignore = {}
  end,
}
