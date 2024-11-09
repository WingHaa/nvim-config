local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
    filter = filter or {}
    filter.direction = filter.direction or 1

    if filter.direction == 1 then
        return ls.expand_or_jumpable()
    else
        return ls.jumpable(filter.direction)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
    if direction == 1 then
        if ls.expandable() then
            return ls.expand_or_jump()
        else
            return ls.jumpable(1) and ls.jump(1)
        end
    else
        return ls.jumpable(-1) and ls.jump(-1)
    end
end

vim.snippet.stop = ls.unlink_current

-- ================================================
--      My Configuration
-- ================================================
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    override_builtin = true,
})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true })

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/config/snippets.lua<CR>", { silent = true })

local function get_line_iter(str)
    if str:sub(-1) ~= "\n" then
        str = str .. "\n"
    end

    return str:gmatch("(.-)\n")
end
local function box_trim_lines(str)
    local new_str = ""

    for line in get_line_iter(str) do
        line = line:gsub("^%s+", "")
        line = string.gsub(line, "%s+$", "")
        new_str = new_str .. "\n" .. line
    end

    return new_str
end

local date = function()
    return { os.date("%Y-%m-%d") }
end

local filename = function()
    return { vim.fn.expand("%:p") }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}

    if not file then
        return res
    end

    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

local function get_port_snip(args)
    if #args < 1 and not args[1][1] then
        return node(nil, text("hello world"))
    end

    local type = args[1][1]
    local indent = "      "

    if type == "NodePort" or type == "LoadBalancer" then
        return node(
            nil,
            fmt(
                box_trim_lines([[
        - port: {}
          {}targetPort: {}
          {}nodePort: {}
        ]]),
                {
                    insert(1, "30000"),
                    indent,
                    insert(2, "80"),
                    indent,
                    insert(3, "30000"),
                }
            )
        )
    end

    if type == "ClusterIP" then
        return node(
            nil,
            fmt(
                [[
        - port: {}
        {}targetPort: {}
        ]],
                {
                    insert(1, "30000"),
                    indent,
                    insert(2, "80"),
                }
            )
        )
    end
end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "pwd",
            namr = "PWD",
            dscr = "Path to current working directory",
        }, {
            func(bash, {}, { user_args = { "pwd" } }),
        }),
        snip({
            trig = "filename",
            namr = "Filename",
            dscr = "Absolute path to file",
        }, {
            func(filename, {}),
        }),
        snip({
            trig = "signature",
            namr = "Signature",
            dscr = "Name and Surname",
        }, {
            text("Sergei Bulavintsev"),
            insert(0),
        }),
    },
    sh = {
        snip("shebang", {
            text({ "#!/bin/sh", "" }),
            insert(0),
        }),
    },
    blade = {
        snip(
            "forelse",
            fmt(
                [[
                  @forelse ({} as {})
                    {}
                  @empty
                    {}
                  @endforelse
                ]],
                {
                    insert(1, "$models"),
                    insert(2, "$model"),
                    insert(0, "$data"),
                    insert(3, "No data"),
                }
            )
        ),
        snip(
            "switch",
            fmt(
                [[
                  @switch({})
                    @case({})
                        {}
                        @break
                 
                    @default
                        {}
                  @endswitch
                ]],
                {
                    insert(1, "true"),
                    insert(2),
                    insert(3),
                    insert(0),
                }
            )
        ),
        snip(
            "@class",
            fmt(
                [[
                  @class([
                      {},
                      {} => {},
                  ]
                ]],
                {
                    insert(1, "defaults"),
                    insert(2, "conditonals"),
                    insert(0, "$condition"),
                }
            )
        ),
        snip(
            "@style",
            fmt(
                [[
                  @style([
                      {},
                      {} => {},
                  ]
                ]],
                {
                    insert(1, "defaults"),
                    insert(2, "conditonals"),
                    insert(0, "$condition"),
                }
            )
        ),
    },
    php = {
        snip(
            "class",
            fmt(
                [[
                  <?php

                  declare(strict_types=1);

                  class {}
                  {{
                    {}
                  }}
                ]],
                {
                    insert(1, "ExampleClass"),
                    insert(2, "start typing..."),
                }
            )
        ),
        snip(
            "match",
            fmt(
                [[
                  match ({}) {{
                    {} => {},
                    {} => {},
                  }};
                ]],
                {
                    insert(1, "true"),
                    insert(2, "$first > 0, $second < 12"),
                    insert(3, "'result'"),
                    insert(4, "default"),
                    insert(0, "'result'"),
                }
            )
        ),
        snip(
            "fork",
            fmt(
                [[
                  foreach ({} as {} => {}) {{
                    {}
                  }};
                ]],
                {
                    insert(1, "$iterable"),
                    insert(2, "$key"),
                    insert(3, "$value"),
                    insert(0),
                }
            )
        ),
        snip(
            "fora",
            fmt(
                [[
                  foreach ({} as {}) {{
                    {}
                  }};
                ]],
                {
                    insert(1, "$iterable"),
                    insert(2, "$value"),
                    insert(0),
                }
            )
        ),
        snip(
            "fori",
            fmt(
                [[
                  for ({}; {}; {}) {{
                    {}
                  }};
                ]],
                {
                    insert(1, "$index = 0"),
                    insert(2, "$index < 10"),
                    insert(3, "$index++"),
                    insert(0),
                }
            )
        ),
    },
    lua = {
        snip("shebang", {
            text({ "#!/usr/bin/lua", "", "" }),
            insert(0),
        }),
        snip("req", {
            text("require('"),
            insert(1, "Module-name"),
            text("')"),
            insert(0),
        }),
        snip("func", {
            text("function("),
            insert(1, "Arguments"),
            text({ ")", "\t" }),
            insert(2),
            text({ "", "end", "" }),
            insert(0),
        }),
        snip("forp", {
            text("for "),
            insert(1, "k"),
            text(", "),
            insert(2, "v"),
            text(" in pairs("),
            insert(3, "table"),
            text({ ") do", "\t" }),
            insert(4),
            text({ "", "end", "" }),
            insert(0),
        }),
        snip("fori", {
            text("for "),
            insert(1, "k"),
            text(", "),
            insert(2, "v"),
            text(" in ipairs("),
            insert(3, "table"),
            text({ ") do", "\t" }),
            insert(4),
            text({ "", "end", "" }),
            insert(0),
        }),
        snip("if", {
            text("if "),
            insert(1),
            text({ " then", "\t" }),
            insert(2),
            text({ "", "end", "" }),
            insert(0),
        }),
        snip("M", {
            text({ "local M = {}", "", "" }),
            insert(0),
            text({ "", "", "return M" }),
        }),
    },
    markdown = {
        -- Select link, press C-s, enter link to receive snippet
        snip({
            trig = "link",
            namr = "markdown_link",
            dscr = "Create markdown link [txt](url)",
        }, {
            text("["),
            insert(1),
            text("]("),
            func(function(_, snip)
                return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            text(")"),
            insert(0),
        }),
        snip({
            trig = "codewrap",
            namr = "markdown_code_wrap",
            dscr = "Create markdown code block from existing text",
        }, {
            text("``` "),
            insert(1, "Language"),
            text({ "", "" }),
            func(function(_, snip)
                local tmp = {}
                tmp = snip.env.TM_SELECTED_TEXT
                tmp[0] = nil
                return tmp or {}
            end, {}),
            text({ "", "```", "" }),
            insert(0),
        }),
        snip({
            trig = "codeempty",
            namr = "markdown_code_empty",
            dscr = "Create empty markdown code block",
        }, {
            text("``` "),
            insert(1, "Language"),
            text({ "", "" }),
            insert(2, "Content"),
            text({ "", "```", "" }),
            insert(0),
        }),
        snip({
            trig = "meta",
            namr = "Metadata",
            dscr = "Yaml metadata format for markdown",
        }, {
            text({ "---", "title: " }),
            insert(1, "note_title"),
            text({ "", "author: " }),
            insert(2, "author"),
            text({ "", "date: " }),
            func(date, {}),
            text({ "", "cathegories: [" }),
            insert(3, ""),
            text({ "]", "lastmod: " }),
            func(date, {}),
            text({ "", "tags: [" }),
            insert(4),
            text({ "]", "comments: true", "---", "" }),
            insert(0),
        }),
    },
    go = {
        snip("test", {
            text("func "),
            insert(1, "Name"),
            text("(t *testing.T)"),
            text({ " {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip("typei", {
            text("type "),
            insert(1, "Name"),
            text({ " interface {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip("types", {
            text("type "),
            insert(1, "Name"),
            text({ " struct {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip("func", {
            text("func "),
            insert(1, "Name"),
            text("("),
            insert(2),
            text(")"),
            insert(3),
            text({ " {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip("if", {
            text("if "),
            insert(1, "true"),
            text({ " {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip(
            "ef",
            fmta(
                [[
                if <err> := <f>(<args>); <err_same> != nil {
                  return <result>
                }
                <finish>
            ]],
                {
                    err = insert(1, "err"),
                    f = insert(2, "f"),
                    args = insert(3, "args"),
                    err_same = rep(1),
                    result = insert(4),
                    finish = insert(0),
                }
            )
        ),
        snip(
            "efi",
            fmta(
                [[
                <val>, <err> := <f>(<args>)
                if <err_same> != nil {
                  return <result>
                }
                <finish>
            ]],
                {
                    val = insert(1, "var"),
                    err = insert(2, "err"),
                    f = insert(3, "f"),
                    args = insert(4, "args"),
                    err_same = rep(2),
                    result = insert(5),
                    finish = insert(0),
                }
            )
        ),
        snip("fori", {
            text("for "),
            insert(1, "i := 0"),
            text(";"),
            insert(2, "i < 10"),
            text(";"),
            insert(3, "i++"),
            text({ " {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
        snip("forr", {
            text("for "),
            insert(1, "k, v"),
            text(" := range "),
            insert(2, "expr"),
            text({ " {", "" }),
            text("\t"),
            insert(0),
            text({ "", "}" }),
        }),
    },
    yaml = {
        snip(
            {
                trig = "pod",
                namr = "k8s Pod",
                dscr = "Kubernetes Pod definition",
            },
            fmt(
                [[
                  apiVersion: v1
                  kind: Pod
                  metadata:
                    name: {}
                    labels:
                      {}: {}
                  spec:
                    containers:
                    - name: {}
                      image: {}:{}
                      ports:
                      - containerPort: {}
                ]],
                {
                    insert(1, "nginx"),
                    insert(2, "run"),
                    insert(3, "nginx"),
                    insert(4, "nginx"),
                    insert(5, "nginx"),
                    insert(6, "latest"),
                    insert(7, "80"),
                }
            )
        ),
        snip(
            {
                trig = "deploy",
                namr = "k8s Deployment",
                dscr = "Kubernetes Deployment definition",
            },
            fmt(
                [[
                  apiVersion: apps/v1
                  kind: Deployment
                  metadata:
                    name: {}
                    labels:
                      {}
                  spec:
                    replicas: {}
                    selector:
                      matchLabels:
                        {}
                    template:
                      metadata:
                        labels:
                          {}
                      spec:
                        containers:
                        - name: {}
                          image: {}:{}
                          ports:
                          - containerPort: {}
                ]],
                {
                    insert(1, "name"),
                    insert(2, "label"),
                    insert(3, "1"),
                    insert(4, "label"),
                    rep(4),
                    insert(5, "container_name"),
                    insert(6, "image"),
                    insert(7, "1.0"),
                    insert(8, "80"),
                }
            )
        ),
        snip(
            {
                trig = "service",
                namr = "k8s Service",
                dscr = "Kubernetes Service definition",
            },
            fmt(
                [[
                    apiVersion: v1
                    kind: Service
                    metadata:
                      name: {}
                      labels:
                        {}
                    spec:
                      selector:
                        {}
                      type: {}
                      ports:
                        {}
                ]],
                {
                    insert(1, "name"),
                    insert(2),
                    insert(3),
                    choice(4, {
                        text("ClusterIP"),
                        text("NodePort"),
                        text("LoadBalancer"),
                    }),
                    dynamicn(5, get_port_snip, { 4 }),
                }
            )
        ),
    },
})
