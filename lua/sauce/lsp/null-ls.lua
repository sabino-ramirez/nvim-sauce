local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

null_ls.setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
    end
  end,
	debug = false,
	sources = {
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
    -- null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
		-- null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.formatting.stylua,
    --diagnostics.flake8
	},
})
