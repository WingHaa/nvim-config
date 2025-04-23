local M = {}

setmetatable(M, {
    __index = function(t, key)
        local ok, mod = pcall(require, "lib.fzf." .. key)
        if ok then
            rawset(t, key, mod)
            return mod
        else
            error("Missing module: " .. key .. "\n" .. mod)
        end
    end,
})

return M
