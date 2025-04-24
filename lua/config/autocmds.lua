-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = (vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch"),
            timeout = 100,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
        local file_name = vim.fn.expand("%:t")
        if string.match(file_name, "compose%.yml$") or string.match(file_name, "compose%.yaml$") then
            vim.bo.filetype = "yaml.docker-compose"
        end
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = ".env*",
    callback = function()
        vim.bo.filetype = "conf"
    end,
})
