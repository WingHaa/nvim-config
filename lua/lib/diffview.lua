local M = {}

M.parse_string = function(string)
    local branches = {}

    for branch in string:gmatch("[^\r\n]+") do
        branch = branch:gsub("^%*", ""):gsub("%*$", ""):match("^%s*(.-)%s*$")
        if not branch:match("%s") then
            table.insert(branches, branch)
        end
    end

    return branches
end

M.get_local_branches = function()
    local branch = vim.fn.system("git branch -a 2> /dev/null")
    if branch ~= "" then
        return M.parse_string(branch)
    else
        return nil
    end
end

M.neo_review = function(opt)
    vim.ui.select(M.get_local_branches(), { prompt = "Branch to compare with: " }, function(choice)
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
