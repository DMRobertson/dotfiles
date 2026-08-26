-- Credit for this goes to Goo Goo Gemini: https://gemini.google.com/app/9d80d5cea171ef45

-- Function to get the bundle ID of the Nth app on the Dock
local function getDockAppBundleID(index)
    local cmd = [[defaults read com.apple.dock persistent-apps | grep '"bundle-identifier"' | awk -F'"' '{print $4}']]
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    local bundleIDs = {}
    for id in string.gmatch(result, "[^\r\n]+") do
        table.insert(bundleIDs, id)
    end

    return bundleIDs[index]
end

-- Loop to bind Cmd + 1 through Cmd + 9
for i = 1, 9 do
    hs.hotkey.bind({"cmd"}, tostring(i), function()
        local bundleID = getDockAppBundleID(i)
        
        if not bundleID then
            hs.alert.show("No app at Dock position " .. i)
            return
        end

        local frontApp = hs.application.frontmostApplication()
        
        -- Check if our target app is ALREADY the frontmost app
        if frontApp and frontApp:bundleID() == bundleID then
            local windows = frontApp:allWindows()
            
            if #windows == 0 then
                -- Edge case: The app is active but has no windows at all (or they are hidden).
                -- Firing the launch command again triggers macOS's default "open new window" behavior.
                hs.application.launchOrFocusByBundleID(bundleID)
            
            elseif #windows == 1 then
                -- Only one window exists. If it's minimized, unminimize it.
                if windows[1]:isMinimized() then
                    windows[1]:unminimize()
                end
                windows[1]:focus()
            
            else
                -- Multiple windows exist. Pull the bottom window to the top.
                local targetWindow = windows[#windows]
                
                -- Explicitly unminimize it if it happens to be minimized in the Dock
                if targetWindow:isMinimized() then
                    targetWindow:unminimize()
                end
                
                targetWindow:focus()
            end
        else
            -- The app is NOT active. Launch or bring its main window to the front.
            hs.application.launchOrFocusByBundleID(bundleID)
        end
    end)
end
