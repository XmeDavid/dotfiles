local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "pyright",
    "html",
    "cssls",
  },
})

-- Example: Lua config
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

lspconfig.pyright.setup({
	capabilities = capabilities,
})

lspconfig.gopls.setup({
  capabilities = capabilities,
})

lspconfig.ts_ls.setup({
	capabilities = capabilities
})


