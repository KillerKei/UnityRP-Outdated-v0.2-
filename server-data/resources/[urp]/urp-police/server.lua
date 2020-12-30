RegisterServerEvent('urp-policejob:handcuff')
AddEventHandler('urp-policejob:handcuff', function(target)
	TriggerClientEvent('urp-policejob:handcuff', target)
end)

RegisterServerEvent('urp-policejob:drag')
AddEventHandler('urp-policejob:drag', function(target)
	TriggerClientEvent('urp-policejob:drag', target, source)
end)

RegisterServerEvent('urp-policejob:putInVehicle')
AddEventHandler('urp-policejob:putInVehicle', function(target)
	TriggerClientEvent('urp-policejob:putInVehicle', target)
end)

RegisterServerEvent('urp-policejob:OutVehicle')
AddEventHandler('urp-policejob:OutVehicle', function(target)
	TriggerClientEvent('urp-policejob:OutVehicle', target)
end)

RegisterServerEvent('urp-policejob:requestarrest')
AddEventHandler('urp-policejob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('urp-policejob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('urp-policejob:doarrested', _source)
end)

RegisterServerEvent('urp-policejob:requestrelease')
AddEventHandler('urp-policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('urp-policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('urp-policejob:douncuffing', _source)
end)

RegisterServerEvent('urp-policejob:requesthard')
AddEventHandler('urp-policejob:requesthard', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('urp-policejob:getarrestedhard', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('urp-policejob:doarrested', _source)
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
    local _source = source
    local steam = GetPlayerIdentifiers(_source)[1]
    local userData = promise:new()

    exports.ghmattimysql:execute('SELECT uid FROM __users WHERE steam = ?', {steam}, function(data)
        userData:resolve(data)
    end)

    local uid = Citizen.Await(userData)
    local user = exports['urp-base']:getModule("Player")
    local char = user:getCurrentCharacter(uid[1].uid)
	if char.job == 'Police' then
		Citizen.Wait(5000)
        TriggerClientEvent('urp-policejob:updateBlip', -1)
    end
end)

RegisterServerEvent('urp-policejob:spawned')
AddEventHandler('urp-policejob:spawned', function()
	local _source = source
    local steam = GetPlayerIdentifiers(_source)[1]
    local userData = promise:new()

    exports.ghmattimysql:execute('SELECT uid FROM __users WHERE steam = ?', {steam}, function(data)
        userData:resolve(data)
    end)

    local uid = Citizen.Await(userData)
    local user = exports['urp-base']:getModule("Player")
    local char = user:getCurrentCharacter(uid[1].uid)
	if char.job == 'Police' then
		Citizen.Wait(5000)
        TriggerClientEvent('urp-policejob:updateBlip', -1)
    end
end)

RegisterServerEvent('urp-policejob:forceBlip')
AddEventHandler('urp-policejob:forceBlip', function()
	TriggerClientEvent('urp-policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('urp-policejob:updateBlip', -1)
	end
end)