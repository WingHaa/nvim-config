local desc = require("util.keymap").desc
local set = vim.keymap.set

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		set("n", "<leader>a", function()
			harpoon:list():append()
		end, desc("Harpoon add"))
		set("n", "<leader>hl", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, desc("Harpoon list"))

		set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, desc("Harpoon 1"))
		set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, desc("Harpoon 2"))
		set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, desc("Harpoon 3"))
		set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, desc("Harpoon 4"))

		-- Toggle previous & next buffers stored within Harpoon list
		set("n", "<M-k>", function()
			harpoon:list():prev()
		end, desc("Previous harpoon"))
		set("n", "<M-j>", function()
			harpoon:list():next()
		end, desc("Next harpoon"))
	end,
}
