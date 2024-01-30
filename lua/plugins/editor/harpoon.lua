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

		for i = 1, 5 do
			set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, desc("Harpoon " .. i))
		end

		-- Toggle previous & next buffers stored within Harpoon list
		set("n", "<M-k>", function()
			harpoon:list():prev()
		end, desc("Previous harpoon"))

		set("n", "<M-j>", function()
			harpoon:list():next()
		end, desc("Next harpoon"))
	end,
}
