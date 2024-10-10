local M = {}

M.lsp = {
    function()
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        if #buf_clients == 0 then
            return ""
        end

        local buf_ft = vim.bo.filetype
        local buf_client_names = {}
        -- local copilot_active = false

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "copilot" then
                table.insert(buf_client_names, client.name)
            end

            -- if client.name == "copilot" then
            --   copilot_active = true
            -- end
        end

        -- Add linters (from nvim-lint)
        local lint_s, lint = pcall(require, "lint")
        if lint_s then
            for ft_k, ft_v in pairs(lint.linters_by_ft) do
                if type(ft_v) == "table" then
                    for _, linter in ipairs(ft_v) do
                        if buf_ft == ft_k then
                            table.insert(buf_client_names, linter)
                        end
                    end
                elseif type(ft_v) == "string" then
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, ft_v)
                    end
                end
            end
        end

        -- Add formatters (from conform)
        local success, conform = pcall(require, "conform")
        if success then
            local bufnr = vim.api.nvim_get_current_buf()
            for _, formatter in pairs(conform.list_formatters(bufnr)) do
                if formatter.available then
                    table.insert(buf_client_names, formatter.name)
                end
            end
        end

        local unique_client_names = table.concat(buf_client_names, ", ")
        -- local language_servers = string.format("[%s]", unique_client_names)

        -- if copilot_active then
        --   language_servers = language_servers .. "%#SLCopilot#" .. " " .. "" .. "%*"
        -- end

        return unique_client_names
    end,
}

M.shiftwidth = {
    function()
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "local" })
        return "󰌒" .. " " .. shiftwidth
    end,
    padding = 1,
}

M.encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
}

M.scrollbar = {
    function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = "SLProgress",
    cond = nil,
}

M.diff = {
    "diff",
    symbols = { added = "", modified = "󰿡 ", removed = " " },
    source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end,
}

M.vim = {
    function()
        return ""
    end,
}

M.recording = {
    function()
        local reg = vim.fn.reg_recording()
        if reg == "" then
            return ""
        end -- not recording
        return "recording to @" .. reg
    end,
    color = { fg = "#ff9e64" },
}

M.filetype = {
    "filetype",
    colored = true, -- Displays filetype icon in color if set to true
    icon_only = true, -- Display only an icon for filetype
    icon = { align = "right" }, -- Display filetype icon on the right hand side
}

M.filename = {
    "filename",
    file_status = true, -- Displays file status (readonly status, modified status)
    newfile_status = true, -- Display new file status (new file means no write after created)
    path = 1, -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    -- 4: Filename and parent dir, with tilde as the home directory
    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    symbols = {
        modified = "", -- Text to show when the file is modified.
        readonly = "", -- Text to show when the file is non-modifiable or readonly.
        unnamed = " ", -- Text to show for unnamed buffers.
        newfile = "󰎔", -- Text to show for newly created file before first write
    },
}

return M
