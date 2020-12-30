RegisterServerEvent('urp-interactions:putInVehicle')
AddEventHandler('urp-interactions:putInVehicle', function(target)
    TriggerClientEvent('urp-interactions:putInVehicle', target)
end)

RegisterServerEvent('urp-interactions:outOfVehicle')
AddEventHandler('urp-interactions:outOfVehicle', function(target)
    TriggerClientEvent('urp-interactions:outOfVehicle', target)
end)

RegisterServerEvent('urp-policejob:drag')
AddEventHandler('urp-policejob:drag', function(target)
    local src = source
	TriggerClientEvent('urp-policejob:drag', target, src)
end)
