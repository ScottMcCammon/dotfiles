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
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"alt"}, "5", function()
  hs.application.launchOrFocus("Amplify Mail")
end)

hs.loadSpoon("Calendar")
hs.loadSpoon("HCalendar")
spoon.HCalendar:start()

