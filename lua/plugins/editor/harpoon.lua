local desc = require("util.keymap").desc
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
    {
      "<leader>a",
      function()
        harpoon:list():append()
      end,
      "n",
      desc("Harpoon add"),
    },
    {
      "<leader>hl",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "n",
      desc("Harpoon list"),
    },
    -- Toggle previous & next buffers stored within Harpoon list
    {
      "<S-h>",
      function()
        harpoon:list():prev()
      end,
      "n",
      desc("Previous harpoon"),
    },
    {
      "<S-l>",
      function()
        harpoon:list():next()
      end,
      "n",
      desc("Next harpoon"),
    },
  }

  for i = 1, 5 do
    -- set("n", "<leader>" .. i, function() harpoon:list():select(i) end, desc("Harpoon " .. i))
    table.insert(keys, {
      "<leader>" .. i,
      function()
        harpoon:list():select(i)
      end,
      "n",
      desc("Harpoon " .. i),
    })
  end

  return keys
end

return M
