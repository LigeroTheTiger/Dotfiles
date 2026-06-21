return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag", -- auto closing for tags
	},
	config = function()
		require("nvim-treesitter").install({
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"latex",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"vue",
			"regex",
			"rust",
			"python",
			"elixir",
			"heex",
			"eex",
			"kotlin",
			"nix",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft
				if not pcall(vim.treesitter.start, args.buf, lang) then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
