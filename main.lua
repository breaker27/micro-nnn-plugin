VERSION = "1.0.0"

local micro = import("micro")
local shell = import("micro/shell")
local config = import("micro/config")

function nnn(bp)
    local output, err = shell.RunInteractiveShell("sh -c \"nnn -o -H -p -|uniq\"", false, true)
    if err ~= nil then
        micro.InfoBar():Error(err)
    else
        nnnOutput(output, {bp})
    end
end

function nnnOutput(output, args)
    local bp = args[1]
    local strings = import("strings")
    if output ~= "" then
        for s in string.gmatch(output, "([^\r\n]+)") do
            bp:NewTabCmd({s})
        end
    end
end

function init()
    config.MakeCommand("nnn", nnn, config.NoComplete)
end
