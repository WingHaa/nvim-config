local desc = require("lib.keymap").desc
local wk = require("lib.keymap").wk_desc

local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            sync_on_ui_close = true,
        },
    },
    config = function(_, opts)
        local harpoon = require("harpoon")
        harpoon:setup(opts)

    -- stylua: ignore start
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function() harpoon.ui:select_menu_item({ vsplit = true }) end, { buffer = cx.bufnr })
        vim.keymap.set("n", "<C-s>", function() harpoon.ui:select_menu_item({ split = true }) end, { buffer = cx.bufnr })
        vim.keymap.set("n", "<C-t>", function() harpoon.ui:select_menu_item({ tabedit = true }) end, { buffer = cx.bufnr })
      end,
    })
    end,
}

M.keys = function()
    local harpoon = require("harpoon")
  -- stylua: ignore start
  local keys = {
    wk({ "<leader>a", function() harpoon:list():add() end, "n", }, desc("Harpoon add")),
    wk({ "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "n", }, desc("Harpoon list")),
    -- Toggle previous & next buffers stored within Harpoon list
    wk({ "<M-h>", function() harpoon:list():prev() end, "n", }, desc("Previous harpoon")),
    wk({ "<M-l>", function() harpoon:list():next() end, "n", }, desc("Next harpoon")),
  }

  -- stylua: ignore
  for i = 1, 9 do
    table.insert(
      keys,
      wk({ "<leader>" .. i, function() harpoon:list():select(i) end, "n", }, desc("Harpoon " .. i))
    )
  end

  return keys
end

return M
