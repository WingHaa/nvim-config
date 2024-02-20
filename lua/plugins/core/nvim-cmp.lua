local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")
  local neogen = require("neogen")

  require("luasnip/loaders/from_vscode").lazy_load()

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<tab>"] = cmp.mapping(function(fallback)
        if neogen.jumpable() then
          neogen.jump_next()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-tab>"] = cmp.mapping(function(fallback)
        if neogen.jumpable(true) then
          neogen.jump_prev()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- lsp
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
      { name = "codeium" },
    }),
    -- configure lspkind for vs-code like icons
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 80,
        ellipsis_char = "...",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
          Codeium = "",
        },
      }),
    },
  })
end

M.dependencies = {
  "onsails/lspkind.nvim",
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
}

return M
