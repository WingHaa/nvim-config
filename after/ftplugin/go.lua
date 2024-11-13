vim.b.autoformat = true

local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_buf_create_user_command(bufnr, "GoTagAdd", function(args)
    require("lib.golang.modifytags").add(unpack(args["fargs"]))
end, { nargs = "*" })

vim.api.nvim_buf_create_user_command(bufnr, "GoTagRm", function(args)
    require("lib.golang.modifytags").remove(unpack(args["fargs"]))
end, { nargs = "*" })
