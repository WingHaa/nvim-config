return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Recommended - see "Configuring" below for more config options
			transparent = true,
			italic_comments = false,
			hide_fillchars = false,
			borderless_telescope = false,
		})
	end,
}
