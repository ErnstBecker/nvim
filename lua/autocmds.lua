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

-- Reopen alpha when the last buffer is closed
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function(ev)
		-- Ignore unlisted buffers (alpha, oil, fzf...)
		if not vim.bo[ev.buf].buflisted then
			return
		end
		vim.schedule(function()
			-- Only if a single window is left on an empty buffer
			if
				vim.fn.winnr("$") == 1
				and vim.bo.buftype == ""
				and vim.api.nvim_buf_get_name(0) == ""
				and not vim.bo.modified
			then
				vim.cmd.Alpha()
			end
		end)
	end,
})

vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]
