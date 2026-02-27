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

hs.loadSpoon("ModalMgr")
spoon.ModalMgr:init()
spoon.ModalMgr:new("apps")
local cmodal = spoon.ModalMgr.modal_list["apps"]
for _, v in ipairs(global_apps) do
    cmodal:bind("", v.key, v.name, function()
        hs.application.launchOrFocus(v.name)
        spoon.ModalMgr:deactivate({ "apps" })
    end)
end

-- show cheat sheet if bound key held for 1s
local hyperCheatTimer = hs.timer.delayed.new(1.0, function()
    spoon.ModalMgr:toggleCheatsheet()
end)

hs.hotkey.bind({}, "F18", -- F18 bound to CAPS-LOCK in Karabiner
    function()
        spoon.ModalMgr.supervisor:enter()
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr:activate({ "apps" }, "#FFBD2E", false)
        hyperCheatTimer:start()
    end,
    function()
        hyperCheatTimer:stop()
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr.supervisor:exit()
    end
)
