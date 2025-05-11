local M = {}

function M.list_dirs(path)
    local dirs = {}
    local uv = vim.loop

    local handle = uv.fs_scandir(path)
    if not handle then
        return dirs
    end

    while true do
        local name, type = uv.fs_scandir_next(handle)
        if not name then
            break
        end
        if type == "directory" then
            table.insert(dirs, name)
        end
    end

    return dirs
end

return M
