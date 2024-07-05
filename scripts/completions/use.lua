--------------------------------------------------------------------------------
-- Use (`use`) argmatcher.
--

-- Lists all known tools
local function list_tools()
    local tools
    local r = io.popen("2>nul use --list")
    tools = {}
    for line in r:lines() do
        table.insert(tools, line)
    end
    return tools
end

--------------------------------------------------------------------------------
local parser = clink.arg.new_parser

local use_default_flags = {
    "--list",
    "-l",
    "--help",
    "-h"
}


local use_parser = parser()
use_parser:set_flags(use_default_flags)
use_parser:set_arguments(list_tools())
clink.arg.register_parser("use", use_parser)
