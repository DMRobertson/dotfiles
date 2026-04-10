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

        -- Get the currently active application
        local frontApp = hs.application.frontmostApplication()
        
        -- Check if our target app is ALREADY the frontmost app
        if frontApp and frontApp:bundleID() == bundleID then
            -- The app is already active. Let's handle window cycling.
            local windows = frontApp:allWindows()
            
            -- Only cycle if there is more than one window open
            if #windows > 1 then
                -- allWindows() returns windows in z-order (front to back).
                -- By focusing the last window in the array, we pull the bottom
                -- window to the top, creating a smooth cycle through the stack.
                windows[#windows]:focus()
            else
                -- Optional: Brief alert if you tap it but there's nothing to cycle to
                hs.alert.show("No other windows")
            end
        else
            -- The app is NOT active. Launch or bring its main window to the front.
            hs.application.launchOrFocusByBundleID(bundleID)
        end
    end)
end

