return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7t/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- dont add pairs in lua string
        javascript = { "template_string" }, -- dont add pairs in js template_string
        java = false, -- dont check treesitter on java
      },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    -- make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  end
}
