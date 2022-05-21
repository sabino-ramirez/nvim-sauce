local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "sauce.lsp.lsp-installer"
require"sauce.lsp.handlers".setup()
require "sauce.lsp.null-ls"
