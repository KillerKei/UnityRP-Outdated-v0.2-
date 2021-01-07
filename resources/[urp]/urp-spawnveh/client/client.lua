RegisterNetEvent('VehSpawn')
AddEventHandler('VehSpawn', function(vehicle)

	local model = GetHashKey('CHGR')
	local playerPed = PlayerPedId()
	local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)

	SpawnVehicle(model, coords + 3, heading, function(vehicle)
	end)

end)

RegisterCommand('svems', function(source, args, user)
	local job = exports['isPed']:isPed('job')
	if (job == 'EMS') then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		for k,v in pairs(Config.EMSGarage) do 
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then

		if tostring(args[1]) == nil then
			return
		else
			if tostring(args[1]) ~= nil then
				local argh = args[1]

				if argh == '1' then
					local model = GetHashKey(Config.Vehlist[1])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '2' then
					local model = GetHashKey(Config.Vehlist[2])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '3' then
					local model = GetHashKey(Config.Vehlist[3])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '4' then
					local model = GetHashKey(Config.Vehlist[4])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '5' then
					local model = GetHashKey(Config.Vehlist[5])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '6' then
					local model = GetHashKey(Config.Vehlist[6])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '7' then
					local model = GetHashKey(Config.Vehlist[7])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				end
			end
		end

	end
end
end
end)


RegisterCommand('sv', function(source, args, user)
	local job = exports['isPed']:isPed('job')
if job == 'Police' then
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	for k,v in pairs(Config.PoliceGarage) do 
		if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then

		if tostring(args[1]) == nil then
			return
		else
			if tostring(args[1]) ~= nil then
				local argh = args[1]

				if argh == '1' then
					local model = GetHashKey(Config.VehList[1])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '2' then
					local model = GetHashKey(Config.VehList[2])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '3' then
					local model = GetHashKey(Config.VehList[3])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '4' then
					local model = GetHashKey(Config.VehList[4])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '5' then
					local model = GetHashKey(Config.VehList[5])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '6' then
					local model = GetHashKey(Config.VehList[6])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '7' then
					local model = GetHashKey(Config.VehList[7])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '8' then -- Boat
					local model = GetHashKey(Config.VehList[8])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '9' then -- Heli
					local model = GetHashKey(Config.VehList[9])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '10' then -- Heli
					local model = GetHashKey(Config.VehList[10])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '11' then -- Heli
					local model = GetHashKey(Config.VehList[11])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '12' then -- Heli
				local model = GetHashKey(Config.VehList[12])
				local playerPed = PlayerPedId()
				local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
				local heading = GetEntityHeading(playerPed)

				SpawnVehicle(model, coords, heading, function(vehicle)
				local plate = GetVehicleNumberPlateText(vehicle)
				exports["carandplayerhud"]:SetFuel(vehicle, 100)
				TriggerServerEvent('garage:addKeys', plate)
				TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '13' then -- Heli
					local model = GetHashKey(Config.VehList[13])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '14' then -- Heli
					local model = GetHashKey(Config.VehList[14])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '15' then -- Heli
					local model = GetHashKey(Config.VehList[15])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '16' then -- Heli
					local model = GetHashKey(Config.VehList[16])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '17' then -- Heli
					local model = GetHashKey(Config.VehList[17])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
			elseif argh == '18' then -- Heli
					local model = GetHashKey(Config.VehList[18])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '19' then -- Heli
					local model = GetHashKey(Config.VehList[19])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["carandplayerhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				end
			end
		end
	end
end
end
end)

RegisterCommand('impound', function(source)
	local job = exports['isPed']:isPed('job')
	if job == 'Police' or job == 'Mechanic' or job == 'EMS' then
		TriggerEvent('impoundVeh', source)
	end
end)

-- Create blips


RegisterCommand("extra", function(source, args, rawCommand)
  local job = exports['isPed']:isPed('job')
  if job == 'Police' then
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local extraID = tonumber(args[1])
    local extra = args[1]
	local toggle = tostring(args[2])
	for k,v in pairs(Config.PoliceGarage) do 
	if IsPedInAnyVehicle(ped, true) then
	local veh = GetVehiclePedIsIn(ped, false)
		if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
    	if toggle == "true" then
			toggle = 0
			exports["urp-taskbar"]:taskBar(800, "Adding Extra")
    		end
		if veh ~= nil and veh ~= 0 and veh ~= 1 then
			exports["urp-taskbar"]:taskBar(800, "Removing Extra")
			TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
      
        if extra == "all" then
          SetVehicleExtra(veh, 1, toggle)
          SetVehicleExtra(veh, 2, toggle)
          SetVehicleExtra(veh, 3, toggle)
          SetVehicleExtra(veh, 4, toggle)
          SetVehicleExtra(veh, 5, toggle)       
          SetVehicleExtra(veh, 6, toggle)
          SetVehicleExtra(veh, 7, toggle)
          SetVehicleExtra(veh, 8, toggle)
          SetVehicleExtra(veh, 9, toggle)               
          SetVehicleExtra(veh, 10, toggle)
          SetVehicleExtra(veh, 11, toggle)
          SetVehicleExtra(veh, 12, toggle)
          SetVehicleExtra(veh, 13, toggle)
          SetVehicleExtra(veh, 14, toggle)
          SetVehicleExtra(veh, 15, toggle)
          SetVehicleExtra(veh, 16, toggle)
          SetVehicleExtra(veh, 17, toggle)
          SetVehicleExtra(veh, 18, toggle)
          SetVehicleExtra(veh, 19, toggle)
          SetVehicleExtra(veh, 20, toggle)
		  TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
        elseif extraID == extraID then
          SetVehicleExtra(veh, extraID, toggle)
		 end
	    end
	  end
	 end
	end
  end
end, false)

RegisterCommand("emsextra", function(source, args, rawCommand)
	local job = exports['isPed']:isPed('job')
	if job == 'EMS' then
	  local ped = PlayerPedId()
	  local veh = GetVehiclePedIsIn(ped, false)
	  local extraID = tonumber(args[1])
	  local extra = args[1]
	  local toggle = tostring(args[2])
	  for k,v in pairs(Config.EMSGarage) do 
	  if IsPedInAnyVehicle(ped, true) then
	  local veh = GetVehiclePedIsIn(ped, false)
		if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
		if toggle == "true" then
			toggle = 0
			exports["urp-taskbar"]:taskBar(800, "Adding Extra")
			end
		if veh ~= nil and veh ~= 0 and veh ~= 1 then
			exports["urp-taskbar"]:taskBar(800, "Removing Extra")
			TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
			
		  if extra == "all" then
			SetVehicleExtra(veh, 1, toggle)
			SetVehicleExtra(veh, 2, toggle)
			SetVehicleExtra(veh, 3, toggle)
			SetVehicleExtra(veh, 4, toggle)
			SetVehicleExtra(veh, 5, toggle)       
			SetVehicleExtra(veh, 6, toggle)
			SetVehicleExtra(veh, 7, toggle)
			SetVehicleExtra(veh, 8, toggle)
			SetVehicleExtra(veh, 9, toggle)               
			SetVehicleExtra(veh, 10, toggle)
			SetVehicleExtra(veh, 11, toggle)
			SetVehicleExtra(veh, 12, toggle)
			SetVehicleExtra(veh, 13, toggle)
			SetVehicleExtra(veh, 14, toggle)
			SetVehicleExtra(veh, 15, toggle)
			SetVehicleExtra(veh, 16, toggle)
			SetVehicleExtra(veh, 17, toggle)
			SetVehicleExtra(veh, 18, toggle)
			SetVehicleExtra(veh, 19, toggle)
			SetVehicleExtra(veh, 20, toggle)
			TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
		  elseif extraID == extraID then
			SetVehicleExtra(veh, extraID, toggle)
		   end
		  end
		end
	   end
	  end
	end
  end, false)
  


RegisterCommand('fix', function(source)
	local job = exports['isPed']:isPed('job')
	if job == 'Police' then
		policeFix()
	end
end,false)


function policeFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				FreezeEntityPosition(veh, true)
				exports["urp-taskbar"]:taskBar(5000, "Completing Task")
				TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
				SetVehicleFixed(veh)
				SetVehicleDirtLevel(veh, 0.0)
				exports["urp-carhud"]:SetFuel(veh, 100)
				FreezeEntityPosition(veh, false)
			end
		end
	end
end

RegisterCommand('emsfix', function(source)
	local job = exports['isPed']:isPed('job')
	if job == 'EMS' then
		EMSFix()
	end
end,false)


function EMSFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.EMSGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				FreezeEntityPosition(veh, true)
				exports["urp-taskbar"]:taskBar(5000, "Completing Task")
				TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
				SetVehicleFixed(veh)
				SetVehicleDirtLevel(veh, 0.0)
				exports["urp-carhud"]:SetFuel(veh, 100)
				FreezeEntityPosition(veh, false)
			end
		end
	end
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('impoundVeh')
AddEventHandler('impoundVeh', function()
	coordA = GetEntityCoords(playerped, 1)
	coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	local vehicle, attempt = getVehicleInDirection(coordA, coordB), 0


	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		exports["urp-taskbar"]:taskBar(3000, "Impounding")
		DeleteVehicle(vehicle)
		TriggerEvent('DoLongHudText', 'Vehicle Successfully Impounded', 1)
	end
end)


RegisterCommand('tint', function(source, args, raw)
	local job = exports['isPed']:isPed('job')
	if job == 'Police' or job == 'EMS' then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		exports["urp-taskbar"]:taskBar(800, "Tinting Vehicle")
		TriggerEvent('DoLongHudText', 'Vehicle Has Been Tinted', 1)
		SetVehicleModKit(vehicle, 0)
		SetVehicleWindowTint(vehicle, tonumber(args[1]))
	end
end)

RegisterCommand('livery', function(source, args, raw)
	local job = exports['isPed']:isPed('job')
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
    if tonumber(args[1]) ~= nil and job == 'Police' or job == 'EMS' and GetVehicleLiveryCount(vehicle) - 1 >= tonumber(args[1]) then
		exports["urp-taskbar"]:taskBar(900, "Changing Livery")
		SetVehicleLivery(vehicle, tonumber(args[1]))
		TriggerEvent('DoLongHudText', 'Livery Set', 1)
    else
		TriggerEvent('DoLongHudText', 'No such Livery for Vehicle', 2)
    end
end)

RegisterCommand("svlist", function(source, args, rawCommand)
	local job = exports['isPed']:isPed('job')
	if job == 'Police' then
	TriggerEvent("customNotification", " \n [1] Crown Vic \n [3] Taurus \n [4] Tahoe \n [5] Ranger \n [6] Charger \n [8] Prison Bus \n [9] Transport Van \n [10] Mustang \n [12] Maverick Helicopter")
	end
end)

RegisterCommand("svemslist", function(source, args, rawCommand)
	local job = exports['isPed']:isPed('job')
	if job == 'EMS' then
	TriggerEvent("customNotification", " \n [1] Ambulance \n [2] Medical Examiner Van \n [3] Charger \n [4] F-350 \n [5] Tahoe \n [6] Helicopter")
	end
end)