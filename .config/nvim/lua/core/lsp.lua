local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "pyright",
    "html",
    "cssls",
    "ts_ls",
  },
})

-- Configure diagnostic signs and display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Define diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP keymaps (applied on attach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    -- Hover and help
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

    -- Code actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

    -- Diagnostics
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic list" }))
  end,
})

-- Get default capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure LSP servers
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  pyright = {},
  gopls = {},
  ts_ls = {},
  html = {},
  cssls = {},
}

-- Setup each server using vim.lsp.enable with capabilities
for server_name, config in pairs(servers) do
  -- Enable the LSP server
  vim.lsp.enable(server_name)

  -- Apply settings if specified
  if config.settings then
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == server_name then
          client.config.settings = config.settings
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
      end,
    })
  end
end


