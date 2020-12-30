local cachedData = {}

RegisterServerEvent('garage:getVehicles')
AddEventHandler('garage:getVehicles', function(cid)
	local source = source
	local vehicles = {}
	exports.ghmattimysql:execute('SELECT * FROM __vehicles WHERE cid= ?', {cid}, function(data)
		for k, v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicles, {vehicle = vehicle, model = v.model, plate = v.plate, garage = v.garage})
		end
		TriggerClientEvent('garage:getVehicles', source, vehicles)
	end)
end)

RegisterServerEvent('urp-garage:modifystate')
AddEventHandler('urp-garage:modifystate', function(vehicleProps, state, garage)
	local _source = source
	local plate = vehicleProps.plate

	if garage == nil then
	else 

		exports.ghmattimysql:execute("UPDATE __vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
		exports.ghmattimysql:execute("UPDATE __vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})

	end
end)

RegisterServerEvent('urp-garage:modifyHouse')
AddEventHandler('urp-garage:modifyHouse', function(vehicleProps)
	local _source = source
	local plate = vehicleProps.plate

	--MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = vehicleProps , ['@plate'] = plate})

	
end)

RegisterServerEvent("urp-garage:sacarometer")
AddEventHandler("urp-garage:sacarometer", function(vehicle,state,src1)
	local src = source
	if src1 then
		src = src1
	end
	local plate = all_trim(vehicle)
	local state = state
	MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
end)

function all_trim(s)
	return s:match( "^%s*(.-)%s*$" )
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end