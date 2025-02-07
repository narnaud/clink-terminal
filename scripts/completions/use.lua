--------------------------------------------------------------------------------
-- Use (`use`) argmatcher.
--

-- Lists all known envs
local function list_envs()
    local envs
    local r = io.popen("2>nul use --list")
    envs = {}
    for line in r:lines() do
        table.insert(envs, line)
    end
    return envs
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
use_parser:set_arguments(list_envs())
clink.arg.register_parser("use", use_parser)
