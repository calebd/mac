hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Up", function()
    local window = hs.window.focusedWindow()
    local screen = window:screen():frame()
    local frame = hs.geometry.rect(screen.x + 10, screen.y + 10, screen.w - 20, screen.h - 20)
    window:setFrame(frame)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Left", function()
    local window = hs.window.focusedWindow()
    local screen = window:screen():frame()
    local frame = hs.geometry.rect(screen.x + 10, screen.y + 10, (screen.w / 2) - 15, screen.h - 20)
    window:setFrame(frame)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Right", function()
    local window = hs.window.focusedWindow()
    local screen = window:screen():frame()
    local frame = hs.geometry.rect(screen.w / 2 + 5, screen.y + 10, (screen.w / 2) - 15, screen.h - 20)
    window:setFrame(frame)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Down", function()
    local window = hs.window.focusedWindow()

    local frame = window:frame()
    frame.w = 1000
    frame.h = 800

    window:setFrame(frame)
end)
