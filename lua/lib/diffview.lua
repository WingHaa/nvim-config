local M = {}

local function parse_string(string)
    local branches = {}

    for branch in string:gmatch("[^\r\n]+") do
        branch = branch:gsub("^%*", ""):gsub("%*$", ""):match("^%s*(.-)%s*$")
        if not branch:match("%s") then
            table.insert(branches, branch)
        end
    end

    return branches
end

local function get_local_branches()
    local branch = vim.fn.system("git branch -a 2> /dev/null")
    if branch ~= "" then
        return parse_string(branch)
    else
        return nil
    end
end

function M.neo_review(opt)
    vim.ui.select(get_local_branches(), { prompt = "Branch to compare with: " }, function(choice)
        if choice == nil then
            return
        elseif opt.type == "branch" or not opt then
            return vim.cmd("DiffviewOpen " .. choice .. "...HEAD --imply-local")
        elseif opt.type == "commit" then
            return vim.cmd("DiffviewFileHistory --range=" .. choice .. "...HEAD --right-only --no-merges")
        end
    end)
end

return M
