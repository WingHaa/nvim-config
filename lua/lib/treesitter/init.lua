---@diagnostic disable: param-type-mismatch
local nodes = require("lib.treesitter.node")
local ts = {
    querys = {
        struct_block = [[((type_declaration (type_spec name:(type_identifier) @struct.name type: (struct_type)))@struct.declaration)]],
        em_struct_block = [[(field_declaration name:(field_identifier)@struct.name type: (struct_type)) @struct.declaration]],
        package = [[(package_clause (package_identifier)@package.name)@package.clause]],
        interface = [[((type_declaration (type_spec name:(type_identifier) @interface.name type:(interface_type)))@interface.declaration)]],
        method_name = [[((method_declaration receiver: (parameter_list)@method.receiver name: (field_identifier)@method.name body:(block))@method.declaration)]],
        func = [[((function_declaration name: (identifier)@function.name) @function.declaration)]],
    },
}

---@return table
local function get_name_defaults()
    return {
        ["func"] = "function",
        ["if"] = "if",
        ["else"] = "else",
        ["for"] = "for",
    }
end

---@param row string
---@param col string
---@param bufnr string|nil
---@return table|nil
function ts.get_struct_node_at_pos(row, col, bufnr)
    local query = ts.querys.struct_block .. " " .. ts.querys.em_struct_block
    local bufn = bufnr or vim.api.nvim_get_current_buf()
    local ns = nodes.nodes_at_cursor(query, get_name_defaults(), bufn, row, col)
    if ns == nil then
        return nil
    else
        return ns[#ns]
    end
end

---@param row string
---@param col string
---@return table|nil
function ts.get_func_method_node_at_pos(row, col, bufnr)
    local query = ts.querys.func .. " " .. ts.querys.method_name
    local bufn = bufnr or vim.api.nvim_get_current_buf()
    local ns = nodes.nodes_at_cursor(query, get_name_defaults(), bufn, row, col)
    if ns == nil then
        return nil
    else
        return ns[#ns]
    end
end

---@param row string
---@param col string
---@param bufnr string|nil
---@return table|nil
function ts.get_package_node_at_pos(row, col, bufnr)
  -- stylua: ignore
  if row > 10 then return end
    local query = ts.querys.package
    local bufn = bufnr or vim.api.nvim_get_current_buf()
    local ns = nodes.nodes_at_cursor(query, get_name_defaults(), bufn, row, col)
    if ns == nil then
        return nil
    else
        return ns[#ns]
    end
end

---@param row string
---@param col string
---@param bufnr string|nil
---@return table|nil
function ts.get_interface_node_at_pos(row, col, bufnr)
    local query = ts.querys.interface
    local bufn = bufnr or vim.api.nvim_get_current_buf()
    local ns = nodes.nodes_at_cursor(query, get_name_defaults(), bufn, row, col)
    if ns == nil then
        return nil
    else
        return ns[#ns]
    end
end

return ts
