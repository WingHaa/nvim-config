local opts = {
    -- whether to map keybinds or not. default true
    default_mappings = false,
    refresh_interval = 150,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = require("lib.exclude").filetype,
    mappings = {
        delete_line = "<leader>md", --            Deletes all marks on current line.
        delete_buf = "<leader>mr", --             Deletes all marks in current buffer.
    },
}

return {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    opts = opts,
}
