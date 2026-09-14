vim.pack.add({
	"https://github.com/kndndrj/nvim-dbee",
	"https://github.com/MunifTanjim/nui.nvim",
})

local drawer_mappings = vim.deepcopy(require("dbee.config").default.drawer.mappings)
table.insert(drawer_mappings, { key = "s", mode = "n", action = "action_1" })

require("dbee").setup({
	drawer = {
		mappings = drawer_mappings,
	},
	editor = {
		buffer_options = { buflisted = true },
	},
})
