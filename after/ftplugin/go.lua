vim.b.autoformat = true

local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_buf_create_user_command(bufnr, "GoTagAdd", function(args)
    if args.range > 1 then
        require("lib.golang.modifytags").add(args["fargs"], args.line1 .. "," .. args.line2)
    else
        require("lib.golang.modifytags").add(args["fargs"])
    end
end, { nargs = "*", range = true })

vim.api.nvim_buf_create_user_command(bufnr, "GoTagRm", function(args)
    if args.range > 1 then
        require("lib.golang.modifytags").remove(args["fargs"], args.line1 .. "," .. args.line2)
    else
        require("lib.golang.modifytags").remove(args["fargs"])
    end
end, { nargs = "*", range = true })
