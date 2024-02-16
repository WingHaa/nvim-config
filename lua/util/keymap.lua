local M = {}

M.desc = function(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = desc,
  }
end

M.noisy_desc = function(desc)
  return {
    noremap = true,
    silent = false,
    nowait = true,
    desc = desc,
  }
end

return M
