for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/config/*.lua", true)) do
    if not ft_path:match("snippets.lua") then
        loadfile(ft_path)()
    end
end
