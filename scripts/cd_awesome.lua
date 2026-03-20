-- cd_awesome.lua
-- Replaces the cd command: if the argument is a file path, navigate to its
-- parent directory instead of failing.

local function onfilterinput(text)
    -- Extract the path argument from a cd command.
    -- Handles: cd [/d] "path" or cd [/d] path
    local path = text:match('^%s*[Cc][Dd]%s+/[Dd]%s+"(.+)"')
              or text:match('^%s*[Cc][Dd]%s+/[Dd]%s+(%S+)')
              or text:match('^%s*[Cc][Dd]%s+"(.+)"')
              or text:match('^%s*[Cc][Dd]%s+(%S+)')

    if not path then
        return
    end

    local full_path = os.getfullpathname(path)
    if not full_path then
        return
    end

    -- If it's not a directory, treat it as a file and go to its parent
    if not os.isdir(full_path) then
        local parent = full_path:match('^(.+)[/\\][^/\\]+$')
        if parent and parent ~= '' then
            return 'cd /d "' .. parent .. '"', false
        end
    else
        return 'cd /d "' .. full_path .. '"', false
    end
end

if clink.onfilterinput then
    clink.onfilterinput(onfilterinput)
else
    clink.onendedit(onfilterinput)
end
