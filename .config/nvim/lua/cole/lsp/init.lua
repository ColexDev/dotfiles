local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("cole.lsp.lsp-installer")
require("cole.lsp.handlers").setup()
