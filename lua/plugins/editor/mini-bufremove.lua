return {
	'echasnovski/mini.bufremove',
	version = '*',
	keys = {
		{ "<leader>bc", function(n) require("mini.bufremove").delete(n, false) end, desc = "Delete current buffer" },
	}
	,

	config = function()
		require('mini.bufremove').setup(
			{
				-- Whether to disable showing non-error feedback
				silent = true,
			}
		)
	end
}
