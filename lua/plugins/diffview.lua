local map = vim.keymap
local add_desc = require("util.keymap").desc

map.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", add_desc("Diffview Open"))
map.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", add_desc("Diffview Close"))
map.set("n", "<leader>db", "<cmd>DiffviewFileHistory<CR>", add_desc("Branch History"))
map.set("n", "<leader>df", "<cmd>DiffviewFileHistory %<CR>", add_desc("File History"))
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua PrReview()<CR>", add_desc("PR Review"))
vim.api.nvim_set_keymap("n", "<leader>dR", ":lua PrReviewCommit()<CR>", add_desc("PR Review By Commit"))

function PrReview()
	local branch = vim.fn.input("Target branch: ")
	if branch == "" then
		branch = "HEAD"
	end
	local command = "DiffviewOpen origin/" .. branch .. "...HEAD --imply-local"
	vim.cmd(command)
end

function PrReviewCommit()
	local branch = vim.fn.input("Target branch: ")
	if branch == "" then
		branch = "HEAD"
	end
	local command = "DiffviewFileHistory --range=origin/" .. branch .. "...HEAD --right-only --no-merges"
	vim.cmd(command)
end

vim.opt.fillchars:append({ diff = "╱" })

return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			diff_binaries = false, -- Show diffs for binaries
			enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
			git_cmd = { "git" }, -- The git executable followed by default args.
			icons = { -- Only applies when use_icons is true.
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			view = {
				-- Available layouts:
				--  'diff1_plain'
				--    |'diff2_horizontal'
				--    |'diff2_vertical'
				--    |'diff3_horizontal'
				--    |'diff3_vertical'
				--    |'diff3_mixed'
				--    |'diff4_mixed'
				-- For more info, see ':h diffview-config-view.x.layout'.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_horizontal",
					winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
				},
				merge_tool = {
					-- Config for conflicted files in diff views during a merge or rebase.
					layout = "diff3_horizontal",
					disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
					winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
				},
				file_history = {
					-- Config for changed files in file history views.
					layout = "diff2_horizontal",
					winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
				},
			},
			default_args = { -- Default args prepended to the arg-list for the listed commands
				DiffviewOpen = { "-uno" },
				DiffviewFileHistory = {},
			},
			keymaps = {
				disable_defaults = false, -- Disable the default keymaps
				view = {
					{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
					{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
					{ "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
					{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
					{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
					{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
					{ "n", "<leader>l", actions.cycle_layout, { desc = "Cycle through available layouts." } },
					{ "n", "[x", actions.prev_conflict, { desc = "In merge-tool: jump to the previous conflict" } },
					{ "n", "]x", actions.next_conflict, { desc = "In merge-tool: jump to the next conflict" } },
					{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS version" } },
					{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS version" } },
					{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose BASE version" } },
					{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all the versions" } },
					{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
					{
						"n",
						"<leader>cO",
						actions.conflict_choose_all("ours"),
						{ desc = "Choose the OURS version for the whole file" },
					},
					{
						"n",
						"<leader>cT",
						actions.conflict_choose_all("theirs"),
						{ desc = "Choose the THEIRS version for the whole file" },
					},
					{
						"n",
						"<leader>cB",
						actions.conflict_choose_all("base"),
						{ desc = "Choose the BASE version for the whole file" },
					},
					{
						"n",
						"<leader>cA",
						actions.conflict_choose_all("all"),
						{ desc = "Choose all the versions for the whole file" },
					},
					{
						"n",
						"dX",
						actions.conflict_choose_all("none"),
						{ desc = "Delete the conflict region for the whole file" },
					},
				},
				diff3 = {
					-- Mappings in 3-way diff layouts
					{
						{ "n", "x" },
						"2do",
						actions.diffget("ours"),
						{ desc = "Obtain the diff hunk from the OURS version of the file" },
					},
					{
						{ "n", "x" },
						"3do",
						actions.diffget("theirs"),
						{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
					},
					{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
				},
				diff4 = {
					-- Mappings in 4-way diff layouts
					{
						{ "n", "x" },
						"1do",
						actions.diffget("base"),
						{ desc = "Obtain the diff hunk from the BASE version of the file" },
					},
					{
						{ "n", "x" },
						"2do",
						actions.diffget("ours"),
						{ desc = "Obtain the diff hunk from the OURS version of the file" },
					},
					{
						{ "n", "x" },
						"3do",
						actions.diffget("theirs"),
						{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
					},
					{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
				},
				file_panel = {
					{
						"n",
						"j",
						actions.next_entry,
						{ desc = "Bring the cursor to the next file entry" },
					},
					{
						"n",
						"k",
						actions.prev_entry,
						{ desc = "Bring the cursor to the previous file entry" },
					},
					{
						"n",
						"<cr>",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry" },
					},
					{
						"n",
						"l",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry" },
					},
					{
						"n",
						"<2-LeftMouse>",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry" },
					},
					{
						"n",
						"a",
						actions.toggle_stage_entry,
						{ desc = "Stage / unstage the selected entry" },
					},
					{ "n", "A", actions.stage_all, { desc = "Stage all entries" } },
					{ "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
					{
						"n",
						"X",
						actions.restore_entry,
						{ desc = "Restore entry to the state on the left side" },
					},
					{
						"n",
						"L",
						actions.open_commit_log,
						{ desc = "Open the commit log panel" },
					},
					{ "n", "zo", actions.open_fold, { desc = "Expand fold" } },
					{ "n", "h", actions.close_fold, { desc = "Collapse fold" } },
					{ "n", "zc", actions.close_fold, { desc = "Collapse fold" } },
					{ "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
					{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
					{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
					{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
					{
						"n",
						"<c-f>",
						actions.scroll_view(0.25),
						{ desc = "Scroll the view down" },
					},
					{
						"n",
						"<tab>",
						actions.select_next_entry,
						{ desc = "Open the diff for the next file" },
					},
					{
						"n",
						"<s-tab>",
						actions.select_prev_entry,
						{ desc = "Open the diff for the previous file" },
					},
					{
						"n",
						"gf",
						actions.goto_file_edit,
						{ desc = "Open the file in the previous tabpage" },
					},
					{
						"n",
						"<C-w><C-f>",
						actions.goto_file_split,
						{ desc = "Open the file in a new split" },
					},
					{
						"n",
						"<C-w>gf",
						actions.goto_file_tab,
						{ desc = "Open the file in a new tabpage" },
					},
					{
						"n",
						"i",
						actions.listing_style,
						{ desc = "Toggle between 'list' and 'tree' views" },
					},
					{
						"n",
						"f",
						actions.toggle_flatten_dirs,
						{ desc = "Flatten empty subdirectories in tree listing style" },
					},
					{
						"n",
						"R",
						actions.refresh_files,
						{ desc = "Update stats and entries in the file list" },
					},
					{
						"n",
						"<leader>e",
						actions.toggle_files,
						{ desc = "Toggle the file panel" },
					},
					{
						"n",
						"<leader>l",
						actions.cycle_layout,
						{ desc = "Cycle available layouts" },
					},
					{
						"n",
						"[x",
						actions.prev_conflict,
						{ desc = "Go to the previous conflict" },
					},
					{
						"n",
						"]x",
						actions.next_conflict,
						{ desc = "Go to the next conflict" },
					},
					{ "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
					{
						"n",
						"<leader>cO",
						actions.conflict_choose_all("ours"),
						{ desc = "Choose the OURS version for the whole file" },
					},
					{
						"n",
						"<leader>cT",
						actions.conflict_choose_all("theirs"),
						{ desc = "Choose the THEIRS version for the whole file" },
					},
					{
						"n",
						"<leader>cB",
						actions.conflict_choose_all("base"),
						{ desc = "Choose the BASE version for the whole file" },
					},
					{
						"n",
						"<leader>cA",
						actions.conflict_choose_all("all"),
						{ desc = "Choose all the versions for the whole file" },
					},
					{
						"n",
						"dX",
						actions.conflict_choose_all("none"),
						{ desc = "Delete the conflict region for the whole file" },
					},
				},
				file_history_panel = {
					{ "n", "g!", actions.options, { desc = "Open the option panel" } },
					{
						"n",
						"<C-A-d>",
						actions.open_in_diffview,
						{ desc = "Open the entry under the cursor in a diffview" },
					},
					{
						"n",
						"y",
						actions.copy_hash,
						{ desc = "Copy the commit hashunder the cursor" },
					},
					{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
					{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
					{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
					{
						"n",
						"j",
						actions.next_entry,
						{ desc = "Bring the cursor to the next file entry" },
					},
					{
						"n",
						"k",
						actions.prev_entry,
						{ desc = "Bring the cursor to the previous file entry." },
					},
					{
						"n",
						"<cr>",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry." },
					},
					{
						"n",
						"l",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry." },
					},
					{
						"n",
						"<2-LeftMouse>",
						actions.select_entry,
						{ desc = "Open the diff for the selected entry." },
					},
					{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
					{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
					{
						"n",
						"<tab>",
						actions.select_next_entry,
						{ desc = "Open the diff for the next file" },
					},
					{
						"n",
						"<s-tab>",
						actions.select_prev_entry,
						{ desc = "Open the diff for the previous file" },
					},
					{
						"n",
						"gf",
						actions.goto_file_edit,
						{ desc = "Open the file in the previous tabpage" },
					},
					{
						"n",
						"<C-w><C-f>",
						actions.goto_file_split,
						{ desc = "Open the file in a new split" },
					},
					{
						"n",
						"<C-w>gf",
						actions.goto_file_tab,
						{ desc = "Open the file in a new tabpage" },
					},
					{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
					{ "n", "<leader>l", actions.cycle_layout, { desc = "Cycle available layouts" } },
					{ "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
				},
				option_panel = {
					{ "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
					{ "n", "q", actions.close, { desc = "Close the panel" } },
					{ "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
				},
				help_panel = {
					{ "n", "q", actions.close, { desc = "Close help menu" } },
					{ "n", "<esc>", actions.close, { desc = "Close help menu" } },
				},
			},
		})
	end,
}
