return {
	"chrisgrieser/nvim-early-retirement",
	event = "VeryLazy",
	config = function()
		require("early-retirement").setup({
			-- if a buffer has been inactive for this many minutes, close it
			retirementAgeMins = 20,

			-- filetypes to ignore
			ignoredFiletypes = {},

			-- ignore files matching this lua pattern; empty string disables this setting
			ignoreFilenamePattern = "",

			-- will not close the alternate file
			ignoreAltFile = true,

			-- minimum number of open buffers for auto-closing to become active. E.g.,
			-- by setting this to 4, no auto-closing will take place when you have 3
			-- or fewer open buffers. Note that this plugin never closes the currently
			-- active buffer, so a number < 2 will effectively disable this setting.
			minimumBufferNum = 1,

			-- will ignore buffers with unsaved changes. If false, the buffers will
			-- automatically be written and then closed.
			ignoreUnsavedChangesBufs = true,

			-- ignore non-empty buftypes, for example terminal buffers
			ignoreSpecialBuftypes = true,

			-- ignore visible buffers ("a" in `:buffers`). Buffers that are open in
			-- a window or in a tab are considered visible by vim.
			ignoreVisibleBufs = true,

			-- ignore unloaded buffers. Session-management plugin often add buffers
			-- to the buffer list without loading them.
			ignoreUnloadedBufs = false,

			-- Show notification on closing. Works with plugins like nvim-notify.
			notificationOnAutoClose = false,

			-- When a file is deleted, for example via an external program, delete the
			-- associated buffer as well. (This feature is independent from the automatic
			-- closing of `nvim-early-retirement`.)
			deleteBufferWhenFileDeleted = true,
		})
	end,
}
