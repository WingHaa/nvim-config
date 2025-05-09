local M = {}

function M.uniq(tbl)
    local seen = {}
    local result = {}
    for _, path in ipairs(tbl) do
        if not seen[path] then
            table.insert(result, path)
            seen[path] = true
        end
    end
    return result
end

return M
