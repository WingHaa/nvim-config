local ts_utils = require("lib.treesitter")
local r = require("lib.runner")
local M = {}

-- stylua: ignore start
local CASINGS = {
    snake  = "snakecase",  -- "BaseDomain" ->  "base_domain"         
    camel  = "camelcase",  -- "BaseDomain" ->  "baseDomain"          
    lisp   = "lispcase",   -- "BaseDomain" ->  "base-domain"         
    pascal = "pascalcase", -- "BaseDomain" ->  "BaseDomain"          
    title  = "titlecase",  -- "BaseDomain" ->  "Base Domain" 
    keep   = "keep",       --  keeps the original field name
}
-- stylua: ignore end

local function get_binary_path()
    local ok, registry = pcall(require, "mason-registry")
    if not ok then
        vim.notify("Failed to load mason-registry", vim.log.levels.ERROR)
    end

    return registry.get_package("gomodifytags"):get_install_path()
end

--- Get current buffer content in gomodifytags archive format
---@param filename string
---@return string
local function get_buf_content(filename)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local content = table.concat(lines, "\n")
    return string.format("%s\n%d\n%s", filename, #content, content)
end

---@alias NextArg string|nil
---@param arg NextArg
---@return boolean
local function is_valid_transform(arg)
    return arg ~= nil and CASINGS[arg] ~= nil
end

--- Parse user's arguments
---@alias Operator "-add-tags" | "-remove-tags"
---@param args table
---@param operator Operator
---@return table
local function parse_args(args, operator)
    if next(args) == nil then
        return { operator, "json" }
    end

    local transform = CASINGS["snake"]

    local cmd_args = {}
    local i = 1
    while i <= #args do
        local v = args[i]

        if string.sub(v, 1, 1) ~= "-" then
            table.insert(cmd_args, operator)
            table.insert(cmd_args, v)
        elseif v == "-t" and is_valid_transform(args[i + 1]) then
            transform = CASINGS[args[i + 1]] or transform
            i = i + 1
        elseif v == "-s" then
            table.insert(cmd_args, "--skip-unexported")
        elseif v == "-ct" then
            table.insert(cmd_args, "-clear-tags")
        elseif v == "-ro" and args[i + 1] then
            table.insert(cmd_args, "-remove-options")
        elseif v == "-co" then
            table.insert(cmd_args, "-clear-options")
        else
            i = i + 1 -- skip next argument when unknown flag is passed
        end

        i = i + 1
    end

    table.insert(cmd_args, "-transform")
    table.insert(cmd_args, transform)

    return cmd_args
end

local function modify(...)
    local fpath = vim.fn.expand("%") ---@diagnostic disable-line: missing-parameter
    local ns = ts_utils.get_struct_node_at_pos(unpack(vim.api.nvim_win_get_cursor(0)))
    if ns == nil then
        return
    end

    -- stylua: ignore
    local cmd_args = {
      "-format", "json",
      "-file", fpath,
      "-modified"
    }

    -- by struct name of line pos
    if ns.name == nil then
        local _, csrow, _, _ = unpack(vim.fn.getpos("."))
        table.insert(cmd_args, "-line")
        table.insert(cmd_args, csrow)
    else
        table.insert(cmd_args, "-struct")
        table.insert(cmd_args, ns.name)
    end

    -- set user args for cmd
    local arg = { ... }
    for _, v in ipairs(arg) do
        table.insert(cmd_args, v)
    end

    local output = r.sync(get_binary_path(), {
        args = cmd_args,
        writer = get_buf_content(fpath),
        on_exit = function(data, status)
            if not status == 0 then
                error("gotag failed: " .. data)
            end
        end,
    })

    -- decode gotten value
    local tagged = vim.json.decode(table.concat(output))
    if tagged.errors ~= nil or tagged.lines == nil or tagged["start"] == nil or tagged["start"] == 0 then
        error("failed to set tags " .. vim.inspect(tagged))
    end

    vim.api.nvim_buf_set_lines(0, tagged.start - 1, tagged.start - 1 + #tagged.lines, false, tagged.lines)
end

-- add tags to struct under cursor
function M.add(...)
    local cmd_args = parse_args({ ... }, "-add-tags")
    vim.notify(table.concat(cmd_args, ", "))
    modify(unpack(cmd_args))
end

-- remove tags to struct under cursor
function M.remove(...)
    local cmd_args = parse_args({ ... }, "-remove-tags")
    modify(unpack(cmd_args))
end

return M
