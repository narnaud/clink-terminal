-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.charset = "unicode"
flexprompt.settings.connection = "solid"
flexprompt.settings.flow = "concise"
flexprompt.settings.frame_color = "darkest"
flexprompt.settings.heads = "slant"
flexprompt.settings.left_frame = "none"
flexprompt.settings.left_prompt = "{admin}{battery:levelicon:onlyicon}{histlabel}{cwd:type=smart}{env:label=󱁤::var=USE_PROMPT:color=black}{scm}"
flexprompt.settings.lines = "two"
flexprompt.settings.nerdfonts_version = 3
flexprompt.settings.nerdfonts_width = 2
flexprompt.settings.powerline_font = true
flexprompt.settings.right_frame = "none"
flexprompt.settings.right_prompt = "{overtype}{exit}{duration}{time:format=%H:%M:%S}"
flexprompt.settings.separators = "slant"
flexprompt.settings.spacing = "sparse"
flexprompt.settings.style = "classic"
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.tails = "flat"
flexprompt.settings.use_8bit_color = true
flexprompt.settings.use_icons = false
