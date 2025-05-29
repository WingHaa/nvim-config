local map = vim.keymap
local desc = require("lib.keymap").desc

vim.bo.commentstring = "// %s"

vim.api.nvim_create_user_command("ConvertArrColumns", function(a)
    local range = string.format("%d,%d", a.line1, a.line2)

    vim.cmd("silent! " .. range .. [[s/'type/'pdo_type' => PDO::PARAM_STR, 'type]])
    vim.cmd("silent! " .. range .. [[s/string/text]])
    vim.cmd("silent! " .. range .. [[s/number/int]])
    vim.cmd("silent! " .. range .. [[s/select/text]])
    vim.cmd("silent! " .. range .. [[s/virtTable./]])
end, { range = true, desc = "Convert $abc, {$abc}, N'$abc' to :abc" })

vim.api.nvim_create_user_command("ConvertToBindKeys", function(a)
    local range = string.format("%d,%d", a.line1, a.line2)

    vim.cmd("silent! " .. range .. [[s/\$\zs\w*\['\(\w*\)'\]/\1/g]])
    vim.cmd("silent! " .. range .. [[s/\$\(\w\+\)/:\1/g]])
    vim.cmd("silent! " .. range .. [[s/{\(:*\w*\)}/\1/g]])
    vim.cmd("silent! " .. range .. [[s/N\?'\(:\w*\)'/\1/g]])
end, { range = true, desc = "Convert $abc, {$abc}, N'$abc' to :abc" })

vim.api.nvim_create_user_command("ConvertToBindStatements", function(a)
    local start_line = a.line1
    local end_line = a.line2

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local seen = {}
    local ordered = {}

    for _, line in ipairs(lines) do
        for param in line:gmatch("[$:]([%w_]+)") do
            if not seen[param] then
                table.insert(ordered, param)
                seen[param] = true
            end
        end
    end

    local output = {}
    if a.args == "extract" then
        vim.ui.input({ prompt = "From array($data): " }, function(input)
            local arr_expr = "$data"
            if input ~= "" then
                local keys = vim.split(input, "%.")
                for i, key in ipairs(keys) do
                    if i > 1 then
                        arr_expr = arr_expr .. "['" .. key .. "']"
                    else
                        arr_expr = "$" .. key
                    end
                end
            end

            for _, param in ipairs(ordered) do
                table.insert(
                    output,
                    string.format("$stmt->bindValue(':%s', %s['%s'], PDO::PARAM_STR);", param, arr_expr, param)
                )
            end

            vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, output)
        end)
    else
        for _, param in ipairs(ordered) do
            table.insert(output, string.format("$stmt->bindValue(':%s', $%s, PDO::PARAM_STR);", param, param))
        end
        vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, output)
    end
end, { range = true, nargs = "?", desc = "Parse to Bindings" })

map.set("v", "<leader>ma", ":'<,'>ConvertArrColumns<CR>", desc("Bind Column"))
map.set("v", "<leader>mk", ":'<,'>ConvertToBindKeys<CR>", desc("Bind Key"))
map.set("v", "<leader>ms", ":'<,'>ConvertToBindStatements<CR>", desc("Bind Statement"))
map.set("v", "<leader>md", ":'<,'>ConvertToBindStatements extract<CR>", desc("Bind Statement with $data"))
