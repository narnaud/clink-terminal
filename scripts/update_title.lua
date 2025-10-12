--------------------------------------------------------------------------------
settings.add('terminal.update_title', false, 'Change terminal title based on the current folder and git branch.',
    'When true, the terminal will change.')

if not settings.get('terminal.update_title') then
    return
end

--------------------------------------------------------------------------------
-- Change the tab title based on the current folder and git branch

-- This script will change the tab title to the current folder name and git branch
-- if the current folder is a git repository.
-- - not git: "last_folder_name"
-- - git: "git_toplevel_folder - [branch_name]"
-- Example:
-- - not git: "scripts"
-- - git: "clink - [master]"
--------------------------------------------------------------------------------

-- Return the current git branch name
local function get_git_branch()
    local line = io.popen("git branch --show-current 2>nul"):read("*a")
    local branch = line:match("(.+)\n")
    if branch then
        return branch
    end
end

-- Extract the git toplevel folder using git rev-parse --show-toplevel
local function get_git_toplevel()
    local line = io.popen("git rev-parse --show-toplevel 2>nul"):read("*a")
    local toplevel = line:match("([^/\\]+)[/\\]*\n$")
    if toplevel then
        return toplevel, true
    end
    return os.getcwd():match("([^/\\]+)[/\\]*$"), false
end

local function onbeginedit()
    -- get the result from get_git_toplevel
    local folder_name, is_git = get_git_toplevel()
    if is_git then
        -- set the console title to the git toplevel folder name and branch name
        console.settitle(folder_name.." - ["..get_git_branch().."]")
    else
        -- set the console title to the current folder name
        console.settitle(folder_name)
    end
end

clink.onbeginedit(onbeginedit)
