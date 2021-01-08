RegisterServerEvent("dispatch:svNotify")
AddEventHandler("dispatch:svNotify", function(data, pCallSign)
    --print(json.encode(data))
    --local name = getIdentity(source)
    --currentCallSign = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('police:setCallSign', -1, currentCallSign)
    TriggerClientEvent('dispatch:clNotify', -1, data)
end)

RegisterCommand('togglealerts', function(source, args, user)
    if Job == 'police' or Job == 'ambulance' then
        TriggerClientEvent('dispatch:toggleNotifications', source, args[1])
    end
end)

