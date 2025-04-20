local desc = require("lib.keymap").desc
local wk = require("lib.keymap").wk_desc
local Job = require("plenary.job")

local function get_os_command_output(cmd, cwd)
    if type(cmd) ~= "table" then
        return {}
    end
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = Job:new({
        command = command,
        args = cmd,
        cwd = cwd,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
    }):sync()
    return stdout, ret, stderr
end

local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    commit = "e76cb03",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
            key = function()
                local branch = get_os_command_output({
                    "git",
                    "rev-parse",
                    "--abbrev-ref",
                    "HEAD",
                })[1]

                if branch then
                    return vim.loop.cwd() .. "-" .. branch
                else
                    return vim.loop.cwd()
                end
            end,
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
    wk({ "<leader>rf", function() harpoon:list():add() end, "n", }, desc("Harpoon Remember File")),
    wk({ "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "n", }, desc("Harpoon list")),
    -- Toggle previous & next buffers stored within Harpoon list
    wk({ "<M-j>", function() harpoon:list():prev() end, "n", }, desc("Previous harpoon")),
    wk({ "<M-k>", function() harpoon:list():next() end, "n", }, desc("Next harpoon")),
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
