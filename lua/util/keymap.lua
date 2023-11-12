local M = {}

M.desc = function(desc)
	return {
		noremap = true,
		silent = true,
		nowait = true,
		desc = desc,
	}
end

return M
