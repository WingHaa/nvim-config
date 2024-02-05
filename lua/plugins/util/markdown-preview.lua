return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
    keys = {
      { "<leader>mt", "<cmd>MarkdownPreview<cr>", desc = "Preview Markdown" },
    },
  },
}
