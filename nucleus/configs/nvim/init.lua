vim.loader.enable()

vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		right_mouse_command = nil,
		middle_mouse_command = "bdelete! %d",
		indicator = {
			style = " ",
		},
	},
})

require("gitsigns").setup({})

require("ibl").setup()

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
})

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = true,
	enable_check_bracket_line = false,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				return
			end
			fallback()
		end, { "i", "c" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				return
			end
			fallback()
		end, { "i", "c" }),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "treesitter" },
		{ name = "orgmode" },
	}),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_lsp = require("lspconfig")

nvim_lsp.rnix.setup({
	capabilities = capabilities,
	autostart = true,
	cmd = { "nil" },
})
nvim_lsp.gopls.setup({
	capabilities = capabilities,
	autostart = true,
})

nvim_lsp.html.setup({
	capabilities = capabilities,
})
nvim_lsp.nixd.setup({})
nvim_lsp.tsserver.setup({})

local on_attach = function(client)
	require("completion").on_attach(client)
end

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

local orgmode = require("orgmode")

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

vim.o.timeout = true
vim.o.timeoutlen = 500

local wk = require("which-key")
wk.setup()

wk.register({
	["<leader>b"] = { "<cmd>Neotree toggle<cr>", "Open Neotree" },
	["<leader>."] = { vim.lsp.buf.hover, "LSP hover" },
})

orgmode.setup({
	org_agenda_files = { "~/docs/notes/*.org" },
	org_default_notes_file = "~/docs/notes/refile.org",
})
require("org-bullets").setup()

require("Comment").setup()

vim.filetype.add({
	filename = {
		[".envrc"] = "bash",
	},
})

local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("orgmode")
telescope.load_extension("harpoon")

require("colorizer").setup({
	filetypes = { "*" },
	user_default_options = {
		rgb_fn = false,
		hsl_fn = false,
	},
})
