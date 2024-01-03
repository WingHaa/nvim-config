local config = function(_, opts)
	local bufferline = require("bufferline")
	bufferline.setup(opts)
	-- Fix bufferline when restoring a session
	vim.api.nvim_create_autocmd("BufAdd", {
		callback = function()
			vim.schedule(function()
				pcall(nvim_bufferline)
			end)
		end,
	})
end

local opts = {
	options = {
		close_command = function(n)
			require("mini.bufremove").delete(n, false)
		end, -- can be a string | function, | false see "Mouse actions"
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		diagnostics_indicator = function(_, _, diag)
			local icons = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			}
			local ret = (diag.error and icons.Error .. diag.error .. " " or "")
				.. (diag.warning and icons.Warn .. diag.warning or "")
			return vim.trim(ret)
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				separator = false,
			},
		},
		sort_by = "id",
	},
}

return {
	"akinsho/bufferline.nvim",
	event = "FileReadPre",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
		{ "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
		{ "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
		{ "<M-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<M-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	},
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = opts,
	config = config,
}
