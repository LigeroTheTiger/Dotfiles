return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local keymap = vim.keymap

		-- execue logic on LspAttach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}), -- group autocommands
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- keymaps (only available when lspclient attaches to buffer)
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Goto declaration"
				keymap.set("n", "gD", "<cmd>tab split<CR>:lua vim.lsp.buf.declaration()<CR>", opts) -- goto declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telscope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telscope lsp_type_definitions<CR>", opts)

				opts.desc = "See available Code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local capabilities = capabilities

		-- rust
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			filetypes = { "rust" },
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					checkOnSave = {
						command = "clippy",
					},
					diagnostics = {
						enable = true,
					},
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Vue (vue_ls)
		vim.lsp.config("vue_ls", {
			capabilities = capabilities,
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
			},
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		-- TypeScript
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
			},
		})

		-- Kotlin -- root at the nearest Gradle/Maven project, not the monorepo .git
		vim.lsp.config("kotlin_language_server", {
			capabilities = capabilities,
			root_markers = {
				"settings.gradle",
				"settings.gradle.kts",
				"build.gradle",
				"build.gradle.kts",
				"pom.xml",
			},
		})

		-- Svelte -- root at the nearest package, not the monorepo .git
		vim.lsp.config("svelte", {
			capabilities = capabilities,
			root_markers = {
				"svelte.config.js",
				"svelte.config.mjs",
				"package.json",
			},
		})

		-- Nix
		vim.lsp.config("nixd", {
			settings = {
				nixd = {
					formatting = {
						command = { "nixfmt" },
					},
				},
			},
		})
		-- enable servers explicitly (binaries provided by nix, found on PATH)
		vim.lsp.enable({
			"clangd",
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"graphql",
			"emmet_ls",
			"prismals",
			"pyright",
			"lua_ls",
			"vue_ls",
			"rust_analyzer",
			"expert",
			"kotlin_language_server",
			"nixd",
			"jsonfmt",
			"jdtls",
		})
	end,
}
