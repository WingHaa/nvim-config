local M = {}

---@class runner.Opts
---@field args? string[]
---@field cwd? string?
---@field writer? Job|table|string Job that writes to stdin of this job.
---@field on_exit? fun(data:string, status:number)

---@param cmd string
---@param opts table
---@return string[]|nil
function M.sync(cmd, opts)
    local ok, Job = pcall(require, "plenary.job")
    if not ok then
        vim.notify("Failed to load plenary", vim.log.levels.ERROR)
        return
    end

    local output

    Job:new({
        command = cmd,
        args = opts.args,
        cwd = opts.cwd,
        writer = opts.writer,
        on_stderr = function(_, data)
            vim.print(data)
        end,
        on_exit = function(data, status)
            output = data:result()
            vim.schedule(function()
                if opts.on_exit then
                    opts.on_exit(output, status)
                end
            end)
        end,
    }):sync(5000 --[[5 seconds]])

    return output
end

return M
