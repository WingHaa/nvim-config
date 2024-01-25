local M = {}

M.desc = function(desc, silent)
	silent = silent or true
	return {
		noremap = true,
		silent = true,
		nowait = true,
		desc = desc,
	}
end

return M
