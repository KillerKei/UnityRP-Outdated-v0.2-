dragStatus = {}
local IsShackles = false
dragStatus.isDragged = false
local IsShackles = false
local isHandcuffed = false
local blipsCops = {}

local signOnPoint = {
	{x = 440.4243, y = -976.4591, z = 30.68958} -- MRPD
}

local fixPoints = {
	{428.05,-1020.76,28.92}, -- mrpd
	{1861.26,3672.54,33.88}, -- sandypd
	{-442.02,6033.25,31.34}, -- paleto
	{532.48,-28.83,70.62},
	{545.67,-50.01,70.97},
	{364.7,-591.16,28.69},

	{828.62, -1271.24, 26.27}, -- tunerpd
	{1203.08, -1478.53, 34.86,}, -- mirrorfirestation
	{388.61, -1616.85, 29.3}, -- sspd
	{204.21, -1653.58, 29.81}, -- ssfire
	{-1079.67, -860.32, 5.05}, -- vesppd
	{-570.73, -145.25, 37.73}, -- rockfordpd
	{539.22, -40.58, 70.78}, -- vinewoodpd
	{1803.64, 2606.87, 45.57}, -- prison
}

local isCuffed = false
local isDead = false

function isCop()
	local uJob = exports['isPed']:isPed('job')
	if uJob == "Police" then return true end
	return false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function giveDutyRadio()
	if (not exports['urp-inventory']:hasEnoughOfItem('radio', 1, false)) then
		print('dick')
		TriggerEvent('player:receiveItem', 'radio', 1)
	end
end

function removeDutyRadio()
	if (exports['urp-inventory']:hasEnoughOfItem('radio', 1, false)) then
		print('dick')
		TriggerEvent("inventory:removeItem", 'radio', 1)
	end
end

function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function createBlip(id) -- PD
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour (blip, 38)
		ShowHeadingIndicatorOnBlip(blip, true)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
		SetBlipNameToPlayerName(blip, id)
		SetBlipScale(blip, 0.85)
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip)
	end
end

function createBlip2(id) -- EMS
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour (blip, 8)
		ShowHeadingIndicatorOnBlip(blip, true)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
		SetBlipNameToPlayerName(blip, id)
		SetBlipScale(blip, 0.85)
		SetBlipAsShortRange(blip, true)
		table.insert(blipsCops, blip)
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

RegisterNetEvent('urp-policejob:updateBlip') -- BLIPS FOR POLICE & EMS
AddEventHandler('urp-policejob:updateBlip', function()
	local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
	local Player = LocalPlayer:getCurrentCharacter()
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	blipsCops = {}
	-- Is the player a cop? In that case show all the blips for other cops
	if Player.job == 'Police' or Player.job == 'EMS' then
		local players = GetPlayers()
		for _,playerId in ipairs(players) do
			if Player.job == 'Police' then
				if NetworkIsPlayerActive(playerId) and GetPlayerPed(playerId) ~= PlayerPedId() then
					createBlip(playerId)
				end
			elseif Player.job == "EMS" then
				if NetworkIsPlayerActive(playerId) and GetPlayerPed(playerId) ~= PlayerPedId() then
					createBlip2(playerId)
				end
			end
		end
	end

end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k, v in ipairs(signOnPoint) do
			local pX, pY, pZ = table.unpack(GetEntityCoords(PlayerPedId()))
			local distance = Vdist2(v.x, v.y, v.z, pX, pY, pZ)
		
			if distance <= 5 then
				if isCop() then
					DrawText3DTest(v.x, v.y, v.z,"[E] - Sign Off Duty")
		
					if IsControlJustReleased(1, 38) then
						TriggerEvent("DoLongHudText","10-42, thank you for your service.")
						removeDutyRadio()
					end
		
				else
					DrawText3DTest(v.x, v.y, v.z,"[E] - Sign On Duty")
		
					if IsControlJustReleased(1, 38) then
						TriggerEvent("DoLongHudText","10-41 and restocked.")
						giveDutyRadio()
					end
				end
			end
		end
		local plyX, plyY, plyZ = table.unpack(GetEntityCoords(PlayerPedId()))
		local aDistance = Vdist2(452.1969, -980.0229, 30.68958, plyX, plyY, plyZ)

		if aDistance <= 5 then
			if isCop() then
				DrawText3DTest(452.1969, -980.0229, 30.6896, "[E] - Open Police Armory")

				if IsControlJustReleased(1, 38) then
					TriggerEvent('server-inventory-open', 10, "Shop")
				end

			end
		end

		local lDistance = Vdist2(459.1117, -982.3354, 30.68961, plyX, plyY, plyZ)

		if lDistance <= 5 then
			if isCop() then
				DrawText3DTest(459.186, -982.9637, 30.68961, "[E] - Open Personal Locker")

				if IsControlJustReleased(1, 38) then
					local cid = exports['isPed']:isPed('cid')
					TriggerEvent('server-inventory-open', 1, "policeLocker-" .. cid)
				end

			end
		end
	end
end)

RegisterCommand('openlocker', function(source, args)
	local rank = exports['isPed']:GroupRank('Police')
	local plyX, plyY, plyZ = table.unpack(GetEntityCoords(PlayerPedId()))
	local lDistance = Vdist2(459.1117, -982.3354, 30.68961, plyX, plyY, plyZ)

	if lDistance <= 5 then
		if not rank then return end
		if #args <= 0 or #args > 1 then return end
		local lockerId = tonumber(args[1])

		if rank >= 4 then
			TriggerEvent('server-inventory-open', 1, "policeLocker-" .. lockerId)
		else
			TriggerEvent("DoLongHudText","You cannot open this locker!",2)
		end
	else
		TriggerEvent("DoLongHudText","Sorry fuckface, you can't open lockers in the middle on nowhere!",2)
	end

end)

function GetPlayers() -- function to get players
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

RegisterCommand('hc', function()
	if exports['isPed']:isPed('job') == 'Police' then
		local target, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			playerheading = GetEntityHeading(GetPlayerPed(-1))
			playerlocation = GetEntityForwardVector(PlayerPedId())
			playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requesthard', target_id, playerheading, playerCoords, playerlocation)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	  	end
	end
  end)


RegisterNetEvent('hardcuff')
AddEventHandler('hardcuff', function()
	if exports['isPed']:isPed('job') == 'Police' then
		local target, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
		  	playerheading = GetEntityHeading(GetPlayerPed(-1))
		  	playerlocation = GetEntityForwardVector(PlayerPedId())
		  	playerCoords = GetEntityCoords(GetPlayerPed(-1))
		  	local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requesthard', target_id, playerheading, playerCoords, playerlocation)
			Citizen.Wait(1800)
			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'cuff', 1.0)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
		end
	end
end)

RegisterCommand('sc', function()
	if exports['isPed']:isPed('job') == 'Police' then
	  	local target, distance = GetClosestPlayer()
	  	if distance ~= -1 and distance <= 3.0 then
			playerheading = GetEntityHeading(GetPlayerPed(-1))
			playerlocation = GetEntityForwardVector(PlayerPedId())
			playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	  	end
    end
end)


RegisterNetEvent('softcuff')
AddEventHandler('softcuff', function()
	if exports['isPed']:isPed('job') == 'Police' then
	  	local target, distance = GetClosestPlayer()
	  	if distance ~= -1 and distance <= 3.0 then
			playerheading = GetEntityHeading(GetPlayerPed(-1))
			playerlocation = GetEntityForwardVector(PlayerPedId())
			playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
			Citizen.Wait(1800)
			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'cuff', 1.0)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	  	end
    end
end)

RegisterNetEvent("tp:pdrevive")
AddEventHandler("tp:pdrevive", function()
	local closestPlayer, closestDistance = GetClosestPlayer()
	local playerPed = GetPlayerPed(-1)
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerEvent('DoLongHudText', 'Revive In Progress')
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Wait(10000)
        ClearPedTasks(playerPed)
		TriggerServerEvent('urp-ambulancejob:revivePD', GetPlayerServerId(closestPlayer))
		TriggerEvent('urp-hospital:client:RemoveBleed')
        TriggerEvent('DoLongHudText', 'Revive was successful please head to pillbox to have them fully treated!')
    else
		TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
    end
end)

RegisterCommand('uc', function()
	if exports['isPed']:isPed('job') == 'Police' then
	  	local target, distance = GetClosestPlayer()
	  	if distance ~= -1 and distance <= 3.0 then
			playerheading = GetEntityHeading(GetPlayerPed(-1))
			playerlocation = GetEntityForwardVector(PlayerPedId())
			playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	  	end
	end
  end)

RegisterNetEvent('uncuff')
AddEventHandler('uncuff', function()
	if exports['isPed']:isPed('job') == 'Police' or exports['urp-inventory']:hasEnoughOfItem('shitlockpick', 1, false) then
		local target, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
		  playerheading = GetEntityHeading(GetPlayerPed(-1))
		  playerlocation = GetEntityForwardVector(PlayerPedId())
		  playerCoords = GetEntityCoords(GetPlayerPed(-1))
		  local target_id = GetPlayerServerId(target)
			TriggerServerEvent('urp-policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
			Citizen.Wait(1200)
			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'uncuff', 0.5)
		else
			TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
		end
	end
end)

RegisterNetEvent('urp-policejob:drag')
AddEventHandler('urp-policejob:drag', function(copId)
	if not isHandcuffed then
		return
	end

	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if isHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('urp-policejob:putInVehicle')
AddEventHandler('urp-policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not isHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('urp-policejob:OutVehicle')
AddEventHandler('urp-policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent('urp-policejob:getarrested')
AddEventHandler('urp-policejob:getarrested', function(playerheading, playercoords, playerlocation)
    playerPed = GetPlayerPed(-1)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
    SetEntityCoords(GetPlayerPed(-1), x, y, z)
    SetEntityHeading(GetPlayerPed(-1), playerheading)
    Citizen.Wait(250)
    loadAnimDict('mp_arrest_paired')
    TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
    Citizen.Wait(3760)
	isHandcuffed = true
	IsShackles = false
    TriggerEvent('urp-policejob:handcuff')
    loadAnimDict('mp_arresting')
    TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('urp-policejob:getarrestedhard')
AddEventHandler('urp-policejob:getarrestedhard', function(playerheading, playercoords, playerlocation)
    playerPed = GetPlayerPed(-1)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
    SetEntityCoords(GetPlayerPed(-1), x, y, z)
    SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	local finished = exports["urp-taskbarskill"]:taskBar(1200,7)
	if (finished ~= 100) then
		isHandcuffed = true
		IsShackles = true
		TriggerEvent('urp-policejob:handcuff2')
		loadAnimDict('mp_arresting')
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	elseif (finished == 100) then
		TriggerEvent("DoLongHudText", "You escaped cuffs, Run!")
	end
    loadAnimDict('mp_arrest_paired')
    TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
end)

RegisterNetEvent('urp-policejob:doarrested')
AddEventHandler('urp-policejob:doarrested', function()
	Citizen.Wait(250)
	loadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 

RegisterNetEvent('urp-policejob:douncuffing')
AddEventHandler('urp-policejob:douncuffing', function()
	Citizen.Wait(250)
	loadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	isHandcuffed = false
	IsShackles = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('urp-policejob:getuncuffed')
AddEventHandler('urp-policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	isHandcuffed = false
	IsShackles = false
	TriggerEvent('urp-policejob:handcuff')
	TriggerEvent('urp-policejob:handcuff2')
	ClearPedTasks(GetPlayerPed(-1))
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsShackles then
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job
			DisableControlAction(2, Keys['CAPS'], true) -- Disable pause screen

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				loadAnimDict('mp_arresting')
				TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 25, true)
			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job
			DisableControlAction(2, Keys['CAPS'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				loadAnimDict('mp_arresting')
				TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


