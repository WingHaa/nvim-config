local M = {}

M.setup = function(capabilities)
  require("lspconfig").clangd.setup({
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    keys = {
      -- see: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
      { "n", "cR", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header (C/C++)" } },
    },
    root_dir = function(fname)
      local util = require("lspconfig.util")
      return util.root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or util.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or util.find_git_ancestor(
        fname
      )
    end,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  })
end

return M
