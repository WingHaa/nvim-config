vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.format_on_save = false
	else
		vim.g.format_on_save = false
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = false,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.format_on_save = true
	vim.g.format_on_save = true
end, {
	desc = "Re-enable autoformat-on-save",
})

local opts = {
	format = {
		timeout_ms = 3000,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
	},
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
	},
	formatters = {
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
		if not (vim.g.format_on_save or vim.b[bufnr].format_on_save) then
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
