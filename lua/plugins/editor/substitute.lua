return {
  "gbprod/substitute.nvim",
  event = "BufRead",
  config = function()
    local sub = require("substitute")
    sub.setup({
      on_substitute = nil,
      yank_substituted_text = false,
      preserve_cursor_position = false,
      modifiers = nil,
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      },
      range = {
        prefix = "s",
        prompt_current_text = false,
        confirm = false,
        complete_word = false,
        subject = nil,
        range = nil,
        suffix = "",
        auto_apply = false,
        cursor_position = "end",
      },
      exchange = {
        motion = false,
        use_esc_to_cancel = true,
        preserve_cursor_position = false,
      },
    })

    vim.keymap.set("n", "gs", sub.operator, { noremap = true })
    vim.keymap.set("n", "gss", sub.line, { noremap = true })
    vim.keymap.set("n", "gS", sub.eol, { noremap = true })
    vim.keymap.set("x", "gs", sub.visual, { noremap = true })
    vim.keymap.set("n", "+gs", "<cmd>lua require('substitute').operator({register='+'})<CR>", { noremap = true })
    vim.keymap.set("n", "+gss", "<cmd>lua require('substitute').line({register='+'})<CR>", { noremap = true })
    vim.keymap.set("n", "+gS", "<cmd>lua require('substitute').eol({register='+'})<CR>", { noremap = true })
    vim.keymap.set("x", "+gs", "<cmd>lua require('substitute').visual({register='+'})<CR>", { noremap = true })
  end,
}
