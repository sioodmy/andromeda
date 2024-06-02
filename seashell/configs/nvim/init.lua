vim.o.timeout = true
vim.o.timeoutlen = 500

require("catppuccin").setup({
      flavour = "frappe",
})
vim.cmd.colorscheme "catppuccin"

vim.opt.termguicolors = true
require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    right_mouse_command = nil,
    middle_mouse_command = "bdelete! %d",
    indicator = {
      style = " ",
    },
  },
}

require("gitsigns").setup {}
vim.opt.list = true

require("lualine").setup {
  options = {
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
}

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup {
  check_ts = true,
  enable_check_bracket_line = false,
}

local lisps = {
  "scheme",
  "racket",
  "clojure",
}
npairs.get_rules("'")[1].not_filetypes = lisps
npairs.get_rules("`")[1].not_filetypes = lisps
npairs.get_rules("(")[1].not_filetypes = lisps
npairs.get_rules("[")[1].not_filetypes = lisps
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp = require("cmp")
cmp.setup {
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
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
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "orgmode" },
    { name = "path", option = { trailing_slash = true } },
    { name = "buffer" },
  }, {
    { name = "buffer" },
  }),
}

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

nvim_lsp.rnix.setup {
  capabilities = capabilities,
  autostart = true,
  cmd = { "nil" },
}
nvim_lsp.gopls.setup {
   capabilities = capabilities,
   autostart = true,
}

nvim_lsp.html.setup {
  capabilities = capabilities,
}

local on_attach = function(client)
  require("completion").on_attach(client)
end

nvim_lsp.rust_analyzer.setup {
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
}

require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }

local orgmode = require("orgmode")

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
}

vim.o.timeout = true
vim.o.timeoutlen = 500

local wk = require("which-key")
wk.setup()

wk.register {
  ["<leader>b"] = { "<cmd>Neotree toggle<cr>", "Open Neotree" },
  ["<leader>."] = { vim.lsp.buf.hover, "LSP hover" },
}

orgmode.setup {
    org_agenda_files = { "~/docs/notes/*.org" },
    org_default_notes_file = "~/docs/notes/refile.org",
}

require("Comment").setup()

vim.filetype.add {
  filename = {
    [".envrc"] = "bash",
  },
}

require('telescope').setup{}
