-- local fs = require("lib.fs")
-- local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins"
--
-- local M = {}
--
-- for _, path in ipairs(fs.list_dirs(plugin_path)) do
--     table.insert(M, { import = "plugins." .. path })
-- end
--
-- return M

return {
    { import = "plugins.colorscheme" },
    { import = "plugins.core" },
    { import = "plugins.editor" },
    { import = "plugins.extra" },
    { import = "plugins.language-server-protocol" },
    { import = "plugins.treesitter" },
    { import = "plugins.ui" },
    { import = "plugins.version-control" },
}
