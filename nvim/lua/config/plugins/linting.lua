return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			vue = { "eslint_d" },
		}

		lint.linters.pylint.cmd = "python"
		lint.linters.pylint.args = { "-m", "pylint", "-f", "json" }

		-- In a monorepo the parent dir has no eslint install, so eslint_d would
		-- fall back to an incompatible bundled copy. Find the nearest project root
		-- (eslint config or package.json) for the current file and run from there.
		local function eslint_root(bufnr)
			local fname = vim.api.nvim_buf_get_name(bufnr)
			if fname == "" then
				return nil
			end
			local markers = {
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
				"eslint.config.ts",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				".eslintrc.yaml",
				".eslintrc.yml",
				".eslintrc",
				"package.json",
			}
			local found = vim.fs.find(markers, { path = vim.fs.dirname(fname), upward = true })[1]
			return found and vim.fs.dirname(found) or nil
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function(args)
				local root = eslint_root(args.buf)
				if root then
					lint.linters.eslint_d.cwd = root
				end
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
