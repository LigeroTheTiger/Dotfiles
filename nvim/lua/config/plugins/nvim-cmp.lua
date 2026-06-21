return {
  "hrsh7th/nvim-cmp",
  evnet = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip", -- snippets
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- completion source for luasnip
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- load snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- select previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- select next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll
        ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- select
      }),
      --sources for autocompletion
      --ordering is important as order = priority
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, --snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      -- configure lspkind
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
