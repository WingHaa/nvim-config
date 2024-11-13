for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/config/*.lua", true)) do
    loadfile(ft_path)()
end
