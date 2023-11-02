return {
	{
		"echasnovski/mini.surround",
		event = "InsertEnter",
		opts = {
			mappings = {
				add = "csa",        -- Add surrounding in Normal and Visual modes
				delete = "ds",      -- Delete surrounding
				find = "csf",       -- Find surrounding (to the right)
				find_left = "csF",  -- Find surrounding (to the left)
				highlight = "csh",  -- Highlight surrounding
				replace = "cs",     -- Replace surrounding
				update_n_lines = "csn", -- Update `n_lines`
			},
		},
	},
}
