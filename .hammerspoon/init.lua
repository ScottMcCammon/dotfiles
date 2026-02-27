--
-- global hotkeys for most frequently used apps
--
local global_apps = {
    { key = "1", name = "Zed" },
    { key = "2", name = "Firefox" },
    { key = "3", name = "kitty" },
    { key = "4", name = "Simulator" },
    { key = "5", name = "Reminders" },
    { key = "6", name = "Notes" },
    { key = "7", name = "Finder" },
    { key = "8", name = "Calendar" },
    { key = "9", name = "Gmail" },
    { key = "0", name = "Messages" },
    { key = "C", name = "Comet" },
    { key = "X", name = "Xcode" },
}
local more_apps = {
    { key = "A", name = "Activity Monitor" },
    { key = "S", name = "System Settings" },
    { key = "F", name = "Safari" },
    { key = "C", name = "Claude" },
    { key = "M", name = "Maps" },
    { key = "N", name = "News" },
}

for _, v in ipairs(global_apps) do
    hs.hotkey.bind({ "alt" }, v.key, function()
        hs.application.launchOrFocus(v.name)
    end)
end

hs.loadSpoon("ModalMgr")
spoon.ModalMgr:init()
spoon.ModalMgr:new("apps")
local cmodal = spoon.ModalMgr.modal_list["apps"]
cmodal:bind("", "escape", "Cancel", function()
    spoon.ModalMgr:deactivate({ "apps" })
end)
for _, v in ipairs(global_apps) do
    cmodal:bind("", v.key, v.name, function()
        hs.application.launchOrFocus(v.name)
        spoon.ModalMgr:deactivateAll()
    end)
end
cmodal:bind("", "H", "More >>", function()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({ "moreapps" }, "#FFBD2E", true)
end)

spoon.ModalMgr:new("moreapps")
local mmodal = spoon.ModalMgr.modal_list["moreapps"]
mmodal:bind("", "escape", "Cancel", function()
    spoon.ModalMgr:deactivate({ "moreapps" })
end)
for _, v in ipairs(more_apps) do
    mmodal:bind("", v.key, v.name, function()
        hs.application.launchOrFocus(v.name)
        spoon.ModalMgr:deactivateAll()
    end)
end

hs.hotkey.bind({ "alt" }, "H", function()
    spoon.ModalMgr.supervisor:enter()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({ "apps" }, "#FFBD2E", true)
    spoon.ModalMgr.supervisor:exit()
end)

-- ~~~ VimMode setup ~~~
local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

-- sometimes you need to check Activity Monitor to get the app's real name
vim:disableForApp('Code')
vim:disableForApp('iTerm')
vim:disableForApp('MacVim')
vim:disableForApp('Terminal')
vim:disableForApp('kitty')
vim:disableForApp('Zed')

-- vim:shouldShowAlertInNormalMode(false)
vim:shouldDimScreenInNormalMode(true)
-- vim:enableBetaFeature('block_cursor_overlay')
vim:enterWithSequence('jk')
-- ~~~ VimMode setup ~~~
