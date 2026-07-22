vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
	files = {
		fd_opts = "--color=never --type f --hidden --follow --no-ignore --exclude .git --exclude .vscode --exclude target",
	},
})

require("fzf-lua").register_ui_select()
