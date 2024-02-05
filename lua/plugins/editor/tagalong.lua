return {
  "AndrewRadev/tagalong.vim",
  event = "BufReadPre",
  config = function()
    vim.g.tagalong_additional_filetypes = { "blade", "vue", "svelte" }
  end,
}
