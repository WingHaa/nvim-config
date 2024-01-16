local M = {}

M.review = function()
	local branch = vim.fn.input("Target branch: ")
	if branch == "" then
		branch = "HEAD"
	end
	local command = "DiffviewOpen origin/" .. branch .. "...HEAD --imply-local"
	vim.cmd(command)
end

M.review_commit = function()
	local branch = vim.fn.input("Target branch: ")
	if branch == "" then
		branch = "HEAD"
	end
	local command = "DiffviewFileHistory --range=origin/" .. branch .. "...HEAD --right-only --no-merges"
	vim.cmd(command)
end

return M
