local M = {
    path = {},
}

function M.path.bin(package)
    return vim.fn.exepath(package)
end

function M.path.share(package)
    return vim.fn.expand("$MASON/share/" .. package)
end

function M.path.share_glob(package, glob)
    return vim.fn.globpath("$MASON/share/" .. package, glob, true, true)
end

function M.path.package(package)
    return vim.fn.expand("$MASON/packages/" .. package)
end

function M.path.package_glob(package, glob)
    return vim.fn.globpath("$MASON/packages/" .. package, glob, true, true)
end

return M
