-- https://github.com/oysandvik94/dotfiles/blob/main/dotfiles/.config/nvim/lua/langeoys/utils/lsp.lua

local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local cache_vars = {}

local root_files = {
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
}

local features = {
    -- change this to `true` to enable codelens
    codelens = true,

    -- change this to `true` if you have `nvim-dap`,
    -- `java-test` and `java-debug-adapter` installed
    debugger = false,
}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}

    path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

    local jdtls_install = require("mason-registry").get_package("jdtls"):get_install_path()

    path.java_agent = jdtls_install .. "/lombok.jar"
    path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    if vim.fn.has("mac") == 1 then
        path.platform_config = jdtls_install .. "/config_mac"
    elseif vim.fn.has("unix") == 1 then
        path.platform_config = jdtls_install .. "/config_linux"
    elseif vim.fn.has("win32") == 1 then
        path.platform_config = jdtls_install .. "/config_win"
    end

    path.bundles = {}

    ---
    -- Include java-test bundle if present
    ---
    local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()

    local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

    if java_test_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_test_bundle)
    end

    vim.list_extend(path.bundles, require("spring_boot").java_extensions())
    local spring_path = require("mason-registry").get_package("spring-boot-tools"):get_install_path()
        .. "/extension/jars/*.jar"
    local spring = vim.split(vim.fn.glob(spring_path), "\n", {})
    vim.list_extend(path.bundles, spring)

    ---
    -- Include java-debug-adapter bundle if present
    ---
    local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()

    local java_debug_bundle =
        vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")

    if java_debug_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_debug_bundle)
    end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---
    path.runtimes = {
        -- Note: the field `name` must be a valid `ExecutionEnvironment`,
        -- you can find the list here:
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        --
        -- This example assume you are using sdkman: https://sdkman.io
        -- {
        -- 	name = "JavaSE-1.8",
        -- 	path = vim.fn.expand("~/.sdkman/candidates/java/8.0.392-tem"),
        -- },
        {
            name = "JavaSE-11",
            path = vim.fn.expand("~/.sdkman/candidates/java/11.0.25-tem"),
        },
        {
            name = "JavaSE-17",
            path = vim.fn.expand("~/.sdkman/candidates/java/17.0.13-tem"),
        },
        {
            name = "JavaSE-21",
            path = vim.fn.expand("~/.sdkman/candidates/java/21.0.5-tem"),
        },
    }

    cache_vars.paths = path

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        group = java_cmds,
        desc = "refresh codelens",
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
    if features.debugger then
        enable_debugger(bufnr)
    end

    if features.codelens then
        enable_codelens(bufnr)
    end

    -- The following mappings are based on the suggested usage of nvim-jdtls
    -- https://github.com/mfussenegger/nvim-jdtls#usage

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    keymap("n", "<leader>oi", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    keymap("n", "<leader>rv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    keymap("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    keymap("n", "<leader>rc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    keymap("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    keymap("v", "<leader>rm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
    -- Dap
    -- keymap.set("n", "<leader>jt", ":lua require'jdtls'.test_class()<CR>", opts)
    -- keymap.set("n", "<leader>jn", ":lua require'jdtls'.test_nearest_method()<CR>", opts)
    local mason_registry = require("mason-registry")
    if opts.dap and mason_registry.is_installed("java-debug-adapter") then
        require("lua.plugins.lsp.nvim-jdtls").setup_dap(opts.dap)
        if opts.test and mason_registry.is_installed("java-test") then
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "<leader>tt",
                [[<Cmd>lua require('jdtls.dap').test_class()<CR>]],
                { desc = "Run All Tests" }
            )
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "<leader>tr",
                [[<Cmd>lua require('jdtls.dap').test_nearest_method()<CR>]],
                { desc = "Run Nearest Test" }
            )
        end
    end
end

local function jdtls_setup(event)
    local jdtls = require("jdtls")
    local spring_path = require("mason-registry").get_package("spring-boot-tools"):get_install_path()
    require("spring_boot").setup({
        ls_path = spring_path .. "/extension/language-server",
        exploded_ls_jar_data = true,
        server = {
            handlers = {
                ["textDocument/inlayHint"] = function(_, _, params, client_id, _)
                    -- ...
                end,
            },
        },
    })

    local path = get_jdtls_paths()
    local data_dir = path.data_dir .. "/" .. string.gsub(vim.fn.getcwd(), "/", "_")

    if cache_vars.capabilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        cache_vars.capabilities = require("blink.cmp").get_lsp_capabilities()
    end

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-XX:+UnlockExperimentalVMOptions",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. path.java_agent,
        "-Xms1g",
        "-Xmx8G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- 💀
        "-jar",
        path.launcher_jar,

        -- 💀
        "-configuration",
        path.platform_config,

        -- 💀
        "-data",
        data_dir,
    }

    local lsp_settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = {
                enabled = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                guessMethodArguments = true,
            },
            contentProvider = {
                preferred = "fernflower",
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
        },
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    require("spring_boot").init_lsp_commands()
    jdtls.start_or_attach({
        cmd = cmd,
        settings = lsp_settings,
        on_attach = jdtls_on_attach,
        handlers = {
            ["$/progress"] = function(_, result, ctx)
                --
            end,
        },
        capabilities = cache_vars.capabilities,
        root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    })
end

vim.api.nvim_create_autocmd("FileType", {
    group = java_cmds,
    pattern = { "java" },
    desc = "Setup jdtls",
    callback = jdtls_setup,
})

return {
    "mfussenegger/nvim-jdtls",
    "JavaHello/spring-boot.nvim",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap",
    },
}
