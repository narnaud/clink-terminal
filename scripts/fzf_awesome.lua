--------------------------------------------------------------------------------
-- Some advanced FXF functions for Clink.
--
-- Either put fzf.exe in a directory listed in the system PATH environment
-- variable, or run 'clink set fzf.exe_location <directoryname>' to tell Clink
-- where to find fzf.exe.
--
-- To use those advanced FZF functions integration, you may set key binds
-- manually in your .inputrc file, or you may use the default key binds.
--
--[[

# Default key binds for fzf with Clink.
"\C-e":        "luafunc:fzf_explorer"      # Ctrl+E to show an explorer like view with directories and files preview

]]
--
--
-- bat is available at https://github.com/sharkdp/bat
-- FZF is available from https://github.com/junegunn/fzf
-- DIRX is available at https://github.com/chrisant996/dirx
-- Clink is available at https://github.com/chrisant996/clink
--

--------------------------------------------------------------------------------
-- Compatibility check.

if not io.popenrw then
    print('fzf.lua requires a newer version of Clink; please upgrade.')
    return
end

--------------------------------------------------------------------------------
-- Utility methods.

-- Shamelessly stolen from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/fzf.lua
local function get_word_insert_bounds(line_state)
    if line_state:getwordcount() > 0 then
        local info = line_state:getwordinfo(line_state:getwordcount())
        if info then
            local first = info.offset
            local last = line_state:getcursor() - 1
            local quote
            local delimit
            if info.quoted then
                local line = line_state:getline()
                first = first - 1
                quote = line:sub(first, first)
                local eq = line:sub(last + 1, last + 1)
                if eq == '' or eq == ' ' or eq == '\t' then
                    delimit = true
                end
            end
            return first, last, quote, delimit
        end
    end
end

-- Shamelessly stolen from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/fzf.lua
local function maybe_strip_icon(str, width)
    if width and width > 0 then
        if unicode.iter then
            local iter = unicode.iter(str)
            local c = iter()
            if c then
                return str:sub(#c + (width - 1) + 1)
            end
        else
            if str:byte() == 32 then
                return str:sub(width + 1)
            elseif width > 1 then
                local tmp = str:match("^[^ ]+(.*)$")
                if tmp then
                    return tmp:sub(width)
                end
            end
        end
    end
    return str
end

-- Shamelessly stolen from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/fzf.lua
local function need_quote(word)
    return word and word:find("[ &()[%]{}^=;!%%'+,`~]") and true
end

-- Shamelessly stolen from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/fzf.lua
local function insert_match(rl_buffer, first, last, has_quote, match, icon_width)
    match = maybe_strip_icon(match, icon_width)
    local quote = has_quote or '"'
    local use_quote = ((has_quote or need_quote(match)) and quote) or ''
    rl_buffer:beginundogroup()
    rl_buffer:remove(first, last + 1)
    rl_buffer:setcursor(first)
    rl_buffer:insert(use_quote)
    rl_buffer:insert(match)
    rl_buffer:insert(use_quote)
    rl_buffer:insert(' ')
    rl_buffer:endundogroup()
end

-- Inspired from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/fzf.lua
local function get_fzf(mode, label, help, preview)
    local command = settings.get('fzf.exe_location')
    if not command or command == '' then
        command = 'fzf.exe'
    end
    command = command:gsub('"', '')

    -- It's important to invoke an .exe file, otherwise quoting for --query can
    -- malfunction and potentially fall into a code injection situation.
    if path.getname(command) ~= command then
        local command_path = path.toparent(command)
        command = path.join(command_path, path.getbasename(command)..".exe")
    else
        command = path.getbasename(command)..".exe"
    end

    command = '"'..command..'"'

    command = command..' --ansi --layout=reverse'
    command = command..' --border=rounded --color="header:italic:underline"'
    command = command..' --height=50% --min-height=20'
    command = command..' --border-label="'..label..'"'
    command = command..' --preview="'..preview..'"'

    -- Check if help is not empty and display it
    if help and help ~= '' then
        command = command..' --header-first --header "'..help..'"'
    end

    if mode == 'horizontal' then
        command = command..' --preview-window="right,50%,border-left" --bind="ctrl-/:change-preview-window(down,50%,border-top|hidden|)"'
    elseif mode == 'vertical' then
        command = command..' --preview-window="down,50%,border-top" --bind="ctrl-/:change-preview-window(down,70%,border-top|hidden|)"'
    end
    return command
end

-- Shamelessly stolen from fzf.lua: https://github.com/chrisant996/clink-gizmos/blob/main/noclink.lua
local function get_script_dir()
    local dir
    local info = debug.getinfo(1, "S")
    if info and info.source then
        dir = path.getdirectory(info.source:sub(2))
    end
    return dir or ""
end


--------------------------------------------------------------------------------
-- Shows an "explorer" like view, with preview of directories and files.
-- Requires both dirx and bat to be installed and in the PATH.
function fzf_explorer(rl_buffer, line_state)
    local command = 'dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8 --ignore-glob=.git/**'

    local dir = get_script_dir()
    local preview = path.join(dir, "fzf-preview.cmd")..' {+2..}'

    local fzf_command = get_fzf('horizontal', '📁 Explorer', 'ALT-E (Edit in VS Code)', preview)
    local open_bind = ' --bind="alt-e:execute-silent(code {+2..})"'
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..open_bind..' --multi')
    if not r then
        rl_buffer:ding()
        return
    end

    local str = r:read('*line')
    str = str and str:gsub('[\r\n]+', ' ') or ''
    str = str:gsub(' +$', '')
    r:close()

    if #str > 0 then
        insert_match(rl_buffer, first, last, has_quote, str, 2)
    end

    rl_buffer:refreshline()
end

--------------------------------------------------------------------------------
-- Shows git status in the current repository.
function fzf_git_status(rl_buffer, line_state)
    local command = 'git -c color.status=always status --short'

    local dir = get_script_dir()
    local preview = path.join(dir, "fzf_git-status-file.cmd")..' {+2..}'

    local fzf_command = get_fzf('horizontal', '🏠 Git status', 'CTRL-A (Select All) / ALT-A (Add) / ALT-E (Edit) / ALT-R (Restore)', preview)
    local select_all_bind = ' --bind="ctrl-a:select-all"'
    local open_bind = ' --bind="alt-e:execute-silent(code {+2..})"'
    local add_bind = ' --bind="alt-a:execute-silent(git add {+2..})+down+reload('..command..')"'
    local restore_bind = ' --bind="alt-r:execute-silent(git restore {+2..})+down+reload('..command..')"'
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..select_all_bind..open_bind..add_bind..restore_bind..' --multi')
    if not r then
        rl_buffer:ding()
        return
    end

    local str = r:read('*line')
    str = str and str:gsub('[\r\n]+', ' ') or ''
    str = str:gsub('^%a+%s+', '')
    r:close()

    if #str > 0 then
        insert_match(rl_buffer, first, last, has_quote, str)
    end

    rl_buffer:refreshline()
end

--------------------------------------------------------------------------------
-- Shows git stashes in the current repository, and allows to remove them.
function fzf_git_stashes(rl_buffer, line_state)
    local command = 'git stash list --color=always'
    local preview = 'git show --color=always {1}'

    local fzf_command = get_fzf('horizontal', '📦 Git stashes', 'ALT-D (Drop stash)', preview)
    local drop_bind = ' --bind="alt-d:execute-silent(git stash drop {1})+reload('..command..')"'
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..drop_bind..' -d: ')
    if not r then
        rl_buffer:ding()
        return
    end

    local str = r:read('*line')
    r:close()

    rl_buffer:refreshline()
end

--------------------------------------------------------------------------------
-- Shows git hashes in the current repository.
function fzf_git_hashes(rl_buffer, line_state)
    local command = 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative --color=always'
    local preview = 'git show --color=always {2}'

    local fzf_command = get_fzf('vertical', '🍒 Git history', '', preview)
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..' --no-sort')
    if not r then
        rl_buffer:ding()
        return
    end

    local str = r:read('*line')
    str = str and str:gsub('[\r\n]+', ' ') or ''
    str = str:sub(3, 9)
    r:close()

    if #str > 0 then
        insert_match(rl_buffer, first, last, has_quote, str)
    end

    rl_buffer:refreshline()
end

--------------------------------------------------------------------------------
-- Shows git branches in the current repository.
function fzf_git_branches(rl_buffer, line_state)
    local dir = get_script_dir()
    local git_command = 'git branch --format="%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))~~%(color:white)%(subject)%(color:reset)" --color=always'
    local column_command = '%USERPROFILE%\\scoop\\apps\\git\\current\\usr\\bin\\column.exe -ts$\'~~\''
    local command = git_command..' | '..column_command
    local command_all = git_command..' --all | '..column_command

    local preview = path.join(dir, "fzf_git-log-helper.cmd")..' {1}'

    local fzf_command = get_fzf('vertical', '🌳 Git branches', 'CTRL-A (Show all branches) / ALT-C (Checkout) / ALT-D (Drop)', preview)
    local select_all_bind = ' --bind="ctrl-a:change-border-label(🌳 Git all branches)+reload('..command_all:gsub('"', '"""')..')"'
    local drop_bind = ' --bind="alt-d:execute-silent(git branch -D {1})+reload('..command:gsub('"', '"""')..')"'
    local checkout_bind = ' --bind="alt-c:execute-silent(git chekout {1})+reload('..command:gsub('"', '"""')..')"'
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..select_all_bind..drop_bind..checkout_bind..' --multi --no-sort')
    if not r then
        rl_buffer:ding()
        return
    end

    local str = r:read('*line')
    str = str and str:gsub('[\r\n]+', ' ') or ''
    str = str:sub(3)
    str = str:gsub('%s.*$', '')
    r:close()

    if #str > 0 then
        insert_match(rl_buffer, first, last, has_quote, str)
    end

    rl_buffer:refreshline()
end
