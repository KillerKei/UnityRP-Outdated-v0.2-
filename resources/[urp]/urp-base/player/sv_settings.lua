RegisterServerEvent("urp-base:sv:player_settings_set")
AddEventHandler("urp-base:sv:player_settings_set", function(settingsTable)
    local src = source
    URP.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
        if UpdateSettings then
            -- we are good here.
        else
            TriggerClientEvent("DoLongHudText", src, "Settings Failed to Save to data for some reason.", 2)
        end
    end)
end)

RegisterServerEvent("urp-base:sv:player_settings")
AddEventHandler("urp-base:sv:player_settings", function()
    local src = source
    URP.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then TriggerClientEvent("urp-base:cl:player_settings", src, loadedSettings) else TriggerClientEvent("urp-base:cl:player_settings",src, nil) end
    end)
end)
