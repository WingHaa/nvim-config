local M = {}

local function clean_code_text(text)
    -- Try to extract quoted string first
    local quoted = text:match([['([^']+)']]) or text:match([["([^"]+)"]])
    if quoted then
        -- ✅ Check for api=... inside quoted string
        local api = quoted:match("api=([%w%.]+)")
        if api then
            return api
        end

        -- ✅ Check for ?c=...&a=... inside quoted string
        local controller = quoted:match("[&?]c=([%w_]+)")
        local action = quoted:match("[&?]a=([%w_]+)")
        if controller and action then
            return controller .. "Controller." .. action
        end

        -- Otherwise just return the trimmed quoted string
        return quoted:match("^%s*(.-)%s*$")
    end

    text = text:match("=.*") or text
    text = text:gsub("^%W+", "") -- Trim non-word chars at start
    text = text:gsub("%(.*$", "") -- Trim from first '(' to end
    text = text:match("^%s*(.-)%s*$") -- Trim all leading and trailing whitespace
    return text
end

local function get_text_by_mode()
    local mode = vim.fn.mode()
    local text = ""
    if mode:match("[vV]") then
        text = require("fzf-lua.utils").get_visual_selection()
    else
        text = vim.fn.getline(".")
    end
    return text
end

function M.grep_definition()
    local text = get_text_by_mode()
    text = clean_code_text(text)
    -- Split text by "." or "->"
    local parts = vim.split(text, "[%.->]", { plain = false, trimempty = true })
    local method = parts[#parts] or ""

    if method == "" then
        return
    end

    local file_name = ""
    for i = 1, #parts - 1 do
        local part = parts[i]
        if part and part ~= "" then
            local normalized = part
                :gsub("[^%w]", "") -- Remove punctuation
                :gsub("([A-Z])", string.lower) -- Lowercase uppercase letters
            file_name = file_name .. normalized
        end
    end

    require("fzf-lua").grep({
        no_esc = true,
        search = [[function\s*]] .. method .. [[\s*\(?]],
        prompt = string.format("Grep Method: "),
        rg_opts = "--no-heading --column --line-number  --smart-case",
        fzf_opts = {
            ["--query"] = file_name,
        },
    })
end

function M.cword_file()
    require("fzf-lua").files({
        cmd = string.format("fd --type f --ignore-case --glob '*%s*'", vim.fn.expand("<cword>")),
        prompt = string.format("Grep files: "),
    })
end

function M.cword_buffer()
    require("fzf-lua").grep({
        search = get_text_by_mode(),
        grep_opts = "--no-heading --with-filename --line-number --column --smart-case",
        rg_opts = "--no-heading --column --line-number --smart-case",
        file = vim.fn.expand("%"),
    })
end

return M
