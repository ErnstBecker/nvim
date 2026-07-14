vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, "utf-16")
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local unlisted = vim.iter(vim.fn.tabpagebuflist()):filter(function(b)
			return vim.fn.buflisted(b) == 0
		end):totable()
		if #unlisted == 0 and vim.fn.winnr("$") == 1 then
			vim.cmd.Alpha()
		end
	end,
})

vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]
