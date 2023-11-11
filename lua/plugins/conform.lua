vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.autoformat = false
	else
		vim.g.autoformat = false
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = false,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.autoformat = true
	vim.g.autoformat = true
end, {
	desc = "Re-enable autoformat-on-save",
})

local opts = {
	format = {
		timeout_ms = 3000,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
	},
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		php = { { "php_cs_fixer", "prettierd" } },
		blade = { "blade-formatter" },
	},
	-- Custom formatters and changes to built-in formatters
	formatters = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		php = { "php_cs_fixer", "prettierd" },
		blade = { "blade-formatter" },
		-- # Example of using dprint only when a dprint.json file is present
		-- dprint = {
		--   condition = function(ctx)
		--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
		--   end,
		-- },
		--
		-- # Example of using shfmt with extra args
		-- shfmt = {
		--   prepend_args = { "-i", "2", "-ci" },
		-- },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if not (vim.g.autoformat or vim.b[bufnr].autoformat) then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
}

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	opts = opts,
}
