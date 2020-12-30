RegisterServerEvent('urp:infinity:player:ready')
AddEventHandler('urp:infinity:player:ready', function()
    local sexinthetube = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('urp:infinity:player:coords', -1, sexinthetube)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local sexinthetube = GetEntityCoords(source)

        TriggerClientEvent('urp:infinity:player:coords', -1, sexinthetube)
        TriggerEvent("urp-core:updatecoords", sexinthetube.x, sexinthetube.y, sexinthetube.z)
        print("[^2urp-infinity^0]^3 Sync Successful.^0")
    end
end)