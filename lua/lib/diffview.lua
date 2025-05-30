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

local function get_recent_commits()
    local output = vim.fn.systemlist("git log --pretty=format:'%h %s' -n 50")
    return output
end

local function get_branches()
    local branch = vim.fn.system("git branch -a 2> /dev/null")
    if branch ~= "" then
        return parse_string(branch)
    else
        return nil
    end
end

function M.neo_review(opt)
    if not opt or opt.type == "branch" then
        vim.ui.select(get_branches(), { prompt = "Branch to compare with:" }, function(choice)
            if choice then
                vim.cmd("DiffviewOpen " .. choice .. "...HEAD --imply-local")
            end
        end)
    elseif opt.type == "commit" then
        vim.ui.select(get_recent_commits(), { prompt = "Commit to compare with:" }, function(choice)
            if choice then
                local sha = choice:match("^([0-9a-fA-F]+)")
                if sha then
                    vim.cmd("DiffviewFileHistory --range=" .. sha .. "...HEAD --right-only --no-merges")
                end
            end
        end)
    end
end

function M.set_diff_highlights()
    if vim.o.background == "dark" then
        vim.api.nvim_set_hl(0, "DiffAdd", { bold = true, fg = "none", bg = "#2e4b2e" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bold = true, fg = "none", bg = "#4c1e15" })
        vim.api.nvim_set_hl(0, "DiffChange", { bold = true, fg = "none", bg = "#45565c" })
        vim.api.nvim_set_hl(0, "DiffText", { bold = true, fg = "none", bg = "#996d74" })
    else
        vim.api.nvim_set_hl(0, "DiffAdd", { bold = true, fg = "none", bg = "palegreen" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bold = true, fg = "none", bg = "lightred" })
        vim.api.nvim_set_hl(0, "DiffChange", { bold = true, fg = "none", bg = "lightblue" })
        vim.api.nvim_set_hl(0, "DiffText", { bold = true, fg = "none", bg = "lightpink" })
    end
end

return M
