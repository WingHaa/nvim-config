local O = {}
local M = {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
}

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	"MunifTanjim/nui.nvim",
	"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}

M.keys = {
	{
		"<leader>e",
		"<cmd>Neotree filesystem toggle reveal float<CR>",
		desc = "Neotree",
		{ noremap = true, silent = true },
	},
}

M.opts = {
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
		-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
		file_size = {
			enabled = true,
			required_width = 64, -- min width of window required to show this column
		},
		type = {
			enabled = true,
			required_width = 122, -- min width of window required to show this column
		},
		last_modified = {
			enabled = true,
			required_width = 88, -- min width of window required to show this column
		},
		created = {
			enabled = true,
			required_width = 110, -- min width of window required to show this column
		},
		symlink_target = {
			enabled = true,
		},
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-custom-commands-global`
	commands = {},
	nesting_rules = {},
	-- List of sources
	sources = {
		"filesystem",
		"git_status",
	},
	-- Show source in winbar
	source_selector = {
		winbar = true,
	},
	event_handlers = {
		{
			event = "vim_buffer_enter",
			handler = function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd([[setlocal rnu ]])
				end
			end,
		},
	},
}

-- Keymappings
O.window = {
	position = "left",
	width = 40,
	mapping_options = {
		noremap = true,
		nowait = true,
	},
	mappings = {
		["<space>"] = {
			"toggle_node",
			nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
		},
		["<l>"] = "open",
		["<esc>"] = "cancel", -- close preview or floating neo-tree window
		["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
		-- Read `# Preview Mode` for more information
		["L"] = "focus_preview",
		["s"] = "open_split",
		["v"] = "open_vsplit",
		["S"] = "split_with_window_picker",
		["V"] = "vsplit_with_window_picker",
		["t"] = "open_tabnew",
		-- ["<cr>"] = "open_drop",
		-- ["t"] = "open_tab_drop",
		["w"] = "open_with_window_picker",
		["C"] = "close_node",
		-- ['C'] = 'close_all_subnodes',
		["z"] = "close_all_nodes",
		["Z"] = "expand_all_nodes",
		["a"] = {
			"add",
			-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
			-- some commands may take optional config options, see `:h neo-tree-mappings` for details
			config = {
				show_path = "relative", -- "none", "relative", "absolute"
			},
		},
		["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
		["d"] = "delete",
		["r"] = "rename",
		["y"] = "copy_to_clipboard",
		["x"] = "cut_to_clipboard",
		["p"] = "paste_from_clipboard",
		["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
		-- ["c"] = {
		--  "copy",
		--  config = {
		--    show_path = "none" -- "none", "relative", "absolute"
		--  }
		--}
		["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
		["q"] = "close_window",
		["R"] = "refresh",
		["?"] = "show_help",
		["<"] = "prev_source",
		[">"] = "next_source",
		["i"] = "show_file_details",
	},
}

O.filesystem = {
	filtered_items = {
		visible = false, -- when true, they will just be displayed differently than normal items
		hide_dotfiles = true,
		hide_gitignored = false,
		hide_hidden = true, -- only works on Windows for hidden files/directories
		hide_by_name = {
			"node_modules",
		},
		hide_by_pattern = { -- uses glob style patterns
			--"*.meta",
			--"*/src/*/tsconfig.json",
		},
		always_show = { -- remains visible even if other settings would normally hide it
			--".gitignored",
		},
		never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
			--".DS_Store",
			--"thumbs.db"
		},
		never_show_by_pattern = { -- uses glob style patterns
			--".null-ls_*",
		},
	},
	follow_current_file = {
		enabled = false, -- This will find and focus the file in the active buffer every time
		--               -- the current file is changed while the tree is open.
		leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	},
	group_empty_dirs = false, -- when true, empty folders will be grouped together
	hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
	-- in whatever position is specified in window.position
	-- "open_current",  -- netrw disabled, opening a directory opens within the
	-- window like netrw would, regardless of window.position
	-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
	use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	-- instead of relying on nvim autocmd events.
	window = {
		mappings = {
			["l"] = "open",
			["h"] = "navigate_up",
			["."] = "set_root",
			["H"] = "toggle_hidden",
			["/"] = "fuzzy_finder",
			["D"] = "fuzzy_finder_directory",
			["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
			-- ["D"] = "fuzzy_sorter_directory",
			["f"] = "filter_on_submit",
			["<c-x>"] = "clear_filter",
			["[g"] = "prev_git_modified",
			["]g"] = "next_git_modified",
			["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
			["oc"] = { "order_by_created", nowait = false },
			["od"] = { "order_by_diagnostics", nowait = false },
			["og"] = { "order_by_git_status", nowait = false },
			["om"] = { "order_by_modified", nowait = false },
			["on"] = { "order_by_name", nowait = false },
			["os"] = { "order_by_size", nowait = false },
			["ot"] = { "order_by_type", nowait = false },
		},
		fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
			["<down>"] = "move_cursor_down",
			["<C-n>"] = "move_cursor_down",
			["<up>"] = "move_cursor_up",
			["<C-p>"] = "move_cursor_up",
		},
	},

	commands = {}, -- Add a custom command or override a global one using the same function name
}

O.buffers = {
	follow_current_file = {
		enabled = true, -- This will find and focus the file in the active buffer every time
		--              -- the current file is changed while the tree is open.
		leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	},
	group_empty_dirs = true, -- when true, empty folders will be grouped together
	show_unloaded = true,
	window = {
		mappings = {
			["bd"] = "buffer_delete",
			["h"] = "navigate_up",
			["."] = "set_root",
			["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
			["oc"] = { "order_by_created", nowait = false },
			["od"] = { "order_by_diagnostics", nowait = false },
			["om"] = { "order_by_modified", nowait = false },
			["on"] = { "order_by_name", nowait = false },
			["os"] = { "order_by_size", nowait = false },
			["ot"] = { "order_by_type", nowait = false },
		},
	},
}

O.git_status = {
	window = {
		position = "float",
		mappings = {
			["A"] = "git_add_all",
			["u"] = "git_unstage_file",
			["a"] = "git_add_file",
			["r"] = "git_revert_file",
			["c"] = "git_commit",
			["p"] = "git_push",
			["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
			["oc"] = { "order_by_created", nowait = false },
			["od"] = { "order_by_diagnostics", nowait = false },
			["om"] = { "order_by_modified", nowait = false },
			["on"] = { "order_by_name", nowait = false },
			["os"] = { "order_by_size", nowait = false },
			["ot"] = { "order_by_type", nowait = false },
		},
	},
}

M.opts = vim.tbl_deep_extend("force", M.opts, O)

return M