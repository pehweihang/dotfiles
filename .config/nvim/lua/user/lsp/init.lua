local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

lspconfig.r_language_server.setup{ on_attach = require('user.lsp.handlers').on_attach}
require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
