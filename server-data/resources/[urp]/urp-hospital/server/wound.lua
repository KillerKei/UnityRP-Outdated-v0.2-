local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('urp-hospital:server:SyncInjuries')
AddEventHandler('urp-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)