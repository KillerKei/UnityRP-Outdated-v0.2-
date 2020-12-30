function URP.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("urp-base:playerSessionStarted")
                --TriggerServerEvent("urp-base:playerSessionStarted")
                break
            end
        end
    end)
end
URP.Core:Initialize()

AddEventHandler("urp-base:playerSessionStarted", function()
    URP.SpawnManager:Initialize()
end)

RegisterNetEvent("urp-base:waitForExports")
AddEventHandler("urp-base:waitForExports", function()
    if not URP.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["urp-base"] then
            TriggerEvent("urp-base:exportsReady")
            return
        end
    end
end)
 
function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)