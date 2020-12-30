local playersHealing = {}

RegisterServerEvent('urp-ambulancejob:revive')
AddEventHandler('urp-ambulancejob:revive', function(data, target)

	if Player.job == 'EMS' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('admin:revivePlayerClient', target)
	else
	end
end)

RegisterServerEvent('urp-ambulancejob:revivePD')
AddEventHandler('urp-ambulancejob:revivePD', function(data, target)
	local Player = data

	if Player.job == 'Police' then
		TriggerClientEvent('admin:revivePlayerClient', target)
	else
	end
end)

RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('urp-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('urp-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('admin:healPlayer')
AddEventHandler('admin:healPlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('urp_basicneeds:healPlayer', target)
	end
end)

RegisterServerEvent('urp-ambulancejob:heal')
AddEventHandler('urp-ambulancejob:heal', function(data, target, type)

	if Player.job == 'EMS' and type == 'small' then
		TriggerClientEvent('urp-ambulancejob:heal', target, type)

		TriggerClientEvent('urp-hospital:client:RemoveBleed', target) 	
	elseif
	Player.job == 'EMS' and type == 'big' then
		TriggerClientEvent('urp-ambulancejob:heal', target, type)
		--TriggerClientEvent('MF_SkeletalSystem:HealBones', target, "all")
		TriggerClientEvent('urp-hospital:client:RemoveBleed', target) 
		TriggerClientEvent('urp-hospital:client:ResetLimbs', target)
	else
	end
end)

RegisterServerEvent('urp-ambulancejob:putInVehicle')
AddEventHandler('urp-ambulancejob:putInVehicle', function(data, target)

	if Player.job == 'EMS' then
		TriggerClientEvent('urp-ambulancejob:putInVehicle', target)
	else
	end
end)

RegisterServerEvent('urp-ambulancejob:pullOutVehicle')
AddEventHandler('urp-ambulancejob:pullOutVehicle', function(data, target)

	if Player.job == 'EMS' then
		TriggerClientEvent('urp-ambulancejob:pullOutVehicle', target)
	end
end)

RegisterServerEvent('urp-ambulancejob:drag')
AddEventHandler('urp-ambulancejob:drag', function(data, target)
	_source = source
	if Player.job == 'EMS' then
		TriggerClientEvent('urp-ambulancejob:drag', target, _source)
	else
	end
end)

RegisterServerEvent('urp-ambulancejob:undrag')
AddEventHandler('urp-ambulancejob:undrag', function(data, target)
	_source = source
	if Player.job == 'EMS' then
		TriggerClientEvent('urp-ambulancejob:un_drag', target, _source)
	else
	end
end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('urp-ambulancejob:drag')
AddEventHandler('urp-ambulancejob:drag', function(target)
	TriggerClientEvent('urp-ambulancejob:drag', target, source)
end)



