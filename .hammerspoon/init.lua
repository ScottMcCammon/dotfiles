-- speed-dial for the most commonly used apps
-- sadly there is no "poison control" key for vim

hs.hotkey.bind({"alt"}, "1", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind({"alt"}, "2", function()
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"alt"}, "3", function()
  hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind({"alt"}, "4", function()
  hs.application.launchOrFocus("Sequel Ace")
end)

hs.hotkey.bind({"alt"}, "5", function()
  hs.application.launchOrFocus("Checkvist")
end)

hs.hotkey.bind({"alt"}, "0", function()
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"alt"}, "9", function()
  hs.application.launchOrFocus("Gmail")
end)

hs.hotkey.bind({"alt"}, "8", function()
  hs.application.launchOrFocus("Google Calendar")
end)

hs.hotkey.bind({"alt"}, "7", function()
  hs.application.launchOrFocus("Google Meet")
end)

-- toggle mute
hs.hotkey.bind({"alt"}, "d", function()
  app = hs.appfinder.appFromName("Google Meet")
  if app and app:activate() then
    hs.eventtap.keyStroke({"cmd"}, "d", 200, app)
  end
end)

-- can never have too many calendars?
hs.loadSpoon("Calendar")
hs.loadSpoon("HCalendar")
spoon.HCalendar:start()
