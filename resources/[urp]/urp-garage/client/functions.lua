
DeleteActualVeh = function()
    if DoesEntityExist(cachedData["vehicle"]) then
		DeleteEntity(cachedData["vehicle"])
	end
end

SpawnVehicle = function(data,recuperar)
    local vehicleProps = data[1]
    local spawnpoint = Config.Garages[cachedData["currentGarage"]]["positions"]["vehicle"]
    if vehicleProps.garage == cachedData["currentGarage"] then

	    WaitForModel(vehicleProps.model)

	    if DoesEntityExist(cachedData["vehicle"]) then
		    DeleteEntity(cachedData["vehicle"])
	    end
        local veh = GetClosestVehicle(spawnpoint["position"], 3.000, 0, 70)

        if DoesEntityExist(veh) then
		    TriggerEvent('DoLongHudText', 'Please move the vehicle off the road', 2)
		    return
	    end
	    CloseMenu()
	    local gameVehicles = exports["urp-base"]:GetVehicles()

	    for i = 1, #gameVehicles do
		    local vehicle = gameVehicles[i]

            if DoesEntityExist(vehicle) then
			    if Config.Trim(GetVehicleNumberPlateText(vehicle)) == Config.Trim(vehicleProps["plate"]) then
                    TriggerEvent('DoLongHudText', 'Your vehicle is already in the city streets', 2)

				    return HandleCamera(cachedData["currentGarage"])
			    end
		    end
	    end
        local veh = CreateVehicle(vehicleProps.model,spawnpoint["position"],spawnpoint["heading"],false,false)
		SetModelAsNoLongerNeeded(vehicleProps.model)
		SetVehicleOnGroundProperly(veh)
		SetVehicleProperties(veh, vehicleProps.vehicle)
        
        --NetworkFadeInEntity(yourVehicle, true, true)

        SetVehicleNumberPlateText(vehicleProps.model, vehicleProps.plate)

		SetModelAsNoLongerNeeded(vehicleProps.model)

        SetEntityAsMissionEntity(vehicleProps.model, true, true)

        local plate = GetVehicleNumberPlateText(vehicleProps.model)
        TriggerServerEvent('garage:addKeys', plate)
        Citizen.Wait(100)
        TriggerServerEvent('urp-garage:modifystate', vehicleProps.vehicle, 0, nil)
        HandleCamera(cachedData["currentGarage"])
        if recuperar then
            TriggerEvent('DoLongHudText', 'You paid $200 to recover your vehicle!')
            TriggerServerEvent('urp-garage:pay')
        end
        ClearMenu()
    else
        TriggerEvent('DoLongHudText', 'Not in Garage: ' ..cachedData["currentGarage"])
    end
end

function deleteCar( entity )
    SetEntityAsMissionEntity(entity, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

SaveInGarage = function(garage)
    ClearMenu()
    coordA = GetEntityCoords(PlayerPedId(), 1)
    coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local vehicle = getVehicleInDirection(coordA, coordB)
    local vehicleProps = GetVehicleProperties(vehicle)
    if vehicle == 0 then
        TriggerEvent('DoLongHudText', 'No vehicle')
        CloseMenu()
    else
        --local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        local vehicleProps = GetVehicleProperties(vehicle)
        SetVehicleProperties(vehicle, vehicleProps)
        Citizen.Wait(300)

        --NetworkFadeOutEntity(vehicle, true, true)
        TriggerEvent('DoLongHudText', 'You saved your vehicle in garage '..garage)
        Citizen.Wait(500)

        deleteCar(vehicle)
        TriggerServerEvent('urp-garage:modifystate', vehicleProps, 1, garage)
        CloseMenu()
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
    
    if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

SetVehicleProperties = function(vehicle, vehicleProps)
    exports['urp-base']:SetVehProps(vehicle, vehicleProps)

    SetVehicleEngineHealth(vehicle, vehicleProps["engineHealth"] and vehicleProps["engineHealth"] + 0.0 or 1000.0)
    SetVehicleBodyHealth(vehicle, vehicleProps["bodyHealth"] and vehicleProps["bodyHealth"] + 0.0 or 1000.0)
    exports["urp-oGasStations"]:SetFuel(vehicle, round(vehicleProps.fuelLevel))

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = exports['urp-base']:FetchVehProps(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"] [#vehicleProps["tyres"]  + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"] [ #vehicleProps["tyres"] ] = tyreId
                end
            else
                vehicleProps["tyres"] [#vehicleProps["tyres"]  + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps.fuelLevel = exports['urp-oGasStations']:GetFuel(vehicle)

        return vehicleProps
    end
end

HandleAction = function(action)
    if action == "menu" then
        OpenGarageMenu()
    end
end

HandleCamera = function(garage, toggle)
    if not garage then return; end
    local Camerapos = Config.Garages[garage]["camera"]

    if not Camerapos then return end

	if not toggle then
		if cachedData["cam"] then
			DestroyCam(cachedData["cam"])
		end
		
		if DoesEntityExist(cachedData["vehicle"]) then
			DeleteEntity(cachedData["vehicle"])
		end

		RenderScriptCams(0, 1, 750, 1, 0)

		return
	end

	if cachedData["cam"] then
		DestroyCam(cachedData["cam"])
	end

	cachedData["cam"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

	SetCamCoord(cachedData["cam"], Camerapos["x"], Camerapos["y"], Camerapos["z"])
	SetCamRot(cachedData["cam"], Camerapos["rotationX"], Camerapos["rotationY"], Camerapos["rotationZ"])
	SetCamActive(cachedData["cam"], true)

	RenderScriptCams(1, 1, 750, 1, 1)

	Citizen.Wait(500)
end

--[[ DrawMarker(20,backdooroutside["x"],backdooroutside["y"],backdooroutside["z"]-0.3,0,0,0,0,0,0,0.701,1.0001,0.3001,markerColor.Red,markerColor.Green, markerColor.Blue,11,0,0,0,0) ["Red"] = 222,
			["Green"] = 50,
			["Blue"] = 50 ]]

--DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)

DrawScriptMarker = function(markerData)
    --DrawMarker(20, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, false, 2, false, false, false, false)
    DrawMarker(20, markerData["pos"],0,0,0,0,0,0,0.701,1.0001,0.3001,222, 50, 50, 0.05,0, 0,0,0,0,0,0)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

    if not IsModelValid(model) then
        TriggerEvent('DoLongHudText', 'This model does not exist in the game, send a report!')
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)

		DrawScreenText("Looking for you " .. GetDisplayNameFromVehicleModel(model) .. "...", 255, 255, 255, 150)
	end
end