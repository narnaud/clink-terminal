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
        command = command..'--preview-window="down,50%,border-top" --bind="ctrl-/:change-preview-window(down,70%,border-top|hidden|)"'
    end
    return command
end

--------------------------------------------------------------------------------
-- Shows an "explorer" like view, with preview of directories and files.
-- Requires both dirx and bat to be installed and in the PATH.
function fzf_explorer(rl_buffer, line_state)
    local command = 'dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8'
    local preview = 'if exist {-1}\\* (echo [94mDirectory:[0m {-1} & echo. & dirx.exe /b /X:d /a:-s-h --bare-relative --level=3 --tree --icons=always --escape-codes=always --utf8 {-1}) else (echo [33mFile:[0m {-1} & echo. & bat --color=always --style=changes,numbers --line-range :500 {-1})'

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
    local preview = 'git diff --no-ext-diff --color=always {-1}'

    local fzf_command = get_fzf('horizontal', '🏠 Git status', 'CTRL-A (Select all) / ALT-E (Edit) / ALT-S (Git add) / ALT-R (Git reset)', preview)
    local select_all_bind = ' --bind="ctrl-a:select-all"'
    local open_bind = ' --bind="alt-e:execute-silent(code {+2..})"'
    local add_bind = ' --bind="alt-s:execute-silent(git add {+2..})+down+reload('..command..')"'
    local reset_bind = ' --bind="alt-r:execute-silent(git reset {+2..})+down+reload('..command..')"'
    local first, last, has_quote, delimit = get_word_insert_bounds(line_state) -- luacheck: no unused

    local r = io.popen(command..' 2>nul | '..fzf_command..select_all_bind..open_bind..add_bind..reset_bind..' --multi')
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