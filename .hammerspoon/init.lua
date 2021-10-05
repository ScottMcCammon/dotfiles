-- speed-dial for the most commonly used apps
-- sadly there is no "poison control" key for vim

hs.hotkey.bind({"alt"}, "1", function()
  hs.application.launchOrFocus("MacVim")
end)

hs.hotkey.bind({"alt"}, "2", function()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"alt"}, "3", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"alt"}, "4", function()
  hs.application.launchOrFocus("Sequel Ace")
end)

hs.hotkey.bind({"alt"}, "0", function()
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"alt"}, "9", function()
  hs.application.launchOrFocus("Amplify Mail")
end)

hs.hotkey.bind({"alt"}, "8", function()
  hs.application.launchOrFocus("Google Calendar")
end)

hs.hotkey.bind({"alt"}, "7", function()
  hs.application.launchOrFocus("Google Meet")
end)

-- can never have too many calendars?
hs.loadSpoon("Calendar")
hs.loadSpoon("HCalendar")
spoon.HCalendar:start()
