local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- local buf_map = function(bufnr, mode, lhs, rhs, opts)
--     vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
--         silent = true,
--     })
-- end

null_ls.setup({
	on_attach = function(client)
		vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
		-- buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
		if client.server_capabilities.document_formatting then
			vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format
        augroup END
        ]])
		end
	end,
	debug = false,
	sources = {
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.code_actions.eslint,
		null_ls.builtins.code_actions.eslint_d,
		-- null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.stylelint
		--diagnostics.flake8
	},
})
