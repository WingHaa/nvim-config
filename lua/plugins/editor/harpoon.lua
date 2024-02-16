local desc = require("util.keymap").desc
local wk = require("util.keymap").wk_desc

local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
}

M.keys = function()
  local harpoon = require("harpoon")
  local keys = {
    wk({
      "<leader>a",
      function()
        harpoon:list():append()
      end,
      "n",
    }, desc("Harpoon add")),
    wk({
      "<leader>hl",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "n",
    }, desc("Harpoon list")),
    -- Toggle previous & next buffers stored within Harpoon list
    wk({
      "<M-h>",
      function()
        harpoon:list():prev()
      end,
      "n",
    }, desc("Previous harpoon")),
    wk({
      "<M-l>",
      function()
        harpoon:list():next()
      end,
      "n",
    }, desc("Next harpoon")),
  }

  for i = 1, 10 do
    table.insert(
      keys,
      wk({
        "<leader>" .. i,
        function()
          harpoon:list():select(i)
        end,
        "n",
      }, desc("Harpoon " .. i))
    )
  end

  return keys
end

return M
