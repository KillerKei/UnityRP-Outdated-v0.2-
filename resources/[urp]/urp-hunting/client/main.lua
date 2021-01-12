local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local timer = 0
local GunQuantity = 0


function ScriptLoaded()
	--print("Called script")
	Citizen.Wait(1000)
	LoadMarkers()
end


function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end


local subLocations = {
	[1] = {
		[1] = { ['x'] = -540.72589111328, ['y'] = 4195.6079101563, ['z'] = 192.39360046387}, 
		[2] = { ['x'] = -768.52105712891, ['y'] = 4175.1088867188, ['z'] = 181.7467956543 },
		[3] = { ['x'] = -904.63568115234, ['y'] = 4123.1171875, ['z'] = 156.63125610352},
		[4] = { ['x'] = -446.9983215332, ['y'] = 4007.2255859375, ['z'] = 79.916641235352 },
		[5] = { ['x'] = -368.38534545898, ['y'] = 4364.9624023438, ['z'] = 53.351547241211 },
		[6] = { ['x'] = -752.255859375, ['y'] = 4316.6538085938, ['z'] = 143.18984985352 },
	},
	[2] = {
		[1] = { ['x'] = -1522.7199707031, ['y'] = 4645.2299804688, ['z'] = 28.690996170044 },
		[2] = { ['x'] = -1405.845703125, ['y'] = 4632.3461914063, ['z'] = 69.577896118164 },
		[3] = { ['x'] = -1613.5083007813, ['y'] = 4702.775390625, ['z'] = 40.114791870117 },
		[4] = { ['x'] = -1637.5766601563, ['y'] = 4570.2666015625, ['z'] = 43.978805541992 },
		[5] = { ['x'] = -1381.4167480469, ['y'] = 4384.0971679688, ['z'] = 42.529800415039 },
		[6] = { ['x'] = -1445.3332519531, ['y'] = 4344.12109375, ['z'] = 2.4407758712769 },
	},
	[3] = {
		[1] = { ['x'] = -395.1819152832, ['y'] = 2553.6938476563, ['z'] = 91.255447387695 },
		[2] = { ['x'] = -256.0146484375, ['y'] = 2334.9499511719, ['z'] = 110.57551574707 },
		[3] = { ['x'] = -124.99950408936, ['y'] = 2120.6198730469, ['z'] = 170.95072937012 },
		[4] = { ['x'] = -297.80108642578, ['y'] = 1763.6588134766, ['z'] = 207.8477935791 },
		[5] = { ['x'] = -478.99801635742, ['y'] = 1922.8776855469, ['z'] = 227.90258789063 },
		[6] = { ['x'] = -509.54653930664, ['y'] = 2454.4877929688, ['z'] = 57.192977905273 },
	},
	[4] = {
		 [1] = { ['x'] = -568.20001220703, ['y'] = 4858.1899414063, ['z'] = 173.46475219727 },
		 [2] = { ['x'] = -554.20153808594, ['y'] = 4737.0405273438, ['z'] = 220.1468963623 },
		 [3] = { ['x'] = -761.88372802734, ['y'] = 4803.6220703125, ['z'] = 231.61268615723 },
		 [4] = { ['x'] = -739.10400390625, ['y'] = 5021.2470703125, ['z'] = 154.62809753418 },
		 [5] = { ['x'] = -790.43383789063, ['y'] = 4732.6860351563, ['z'] = 219.60090637207 },
		 [6] = { ['x'] = -315.52798461914, ['y'] = 4977.8471679688, ['z'] = 237.91227722168 },
	}
}



local animals = {
	'a_c_deer',
}
function RandomLoc()
	local rand = math.random(1, 4)
	TriggerEvent("phone:addnotification", "Hunter Hagrid","I've got some critters ready to meet their maker! It should be marked on your GPS - <b>Hunter Hagrid</b>")
end


local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '[E] Start Hunting', ['x'] = -769.23773193359, ['y'] = 5595.6215820313, ['z'] = 33.48571395874 },
	['Sell'] = { ['hint'] = '[E] Sell', ['x'] = 961.7893, ['y'] = -2111.507, ['z'] = 31.94839 },
	['SpawnATV'] = { ['x'] = -769.63067626953, ['y'] = 5592.7573242188, ['z'] = 33.48571395874 }
}

local OnGoingHuntSession = false
local HuntCar = nil
local deer = false
local canAfford = false
local lol = 0

local blips = {
	{title="Hunting", colour=31, id=141, scale=0.7, x = -769.23773193359, y = 5595.6215820313, z = 33.48571395874},
	{title="Slaughter House", colour=41, id=273, scale=0.7, x = 969.16375732422, y = -2107.9033203125, z = 31.475671768188}
 }
	 
Citizen.CreateThread(function()
	Citizen.Wait(6)
   for _, info in pairs(blips) do
	 info.blip = AddBlipForCoord(info.x, info.y, info.z)
	 SetBlipSprite(info.blip, info.id)
	 SetBlipDisplay(info.blip, 4)
	 SetBlipScale(info.blip, info.scale)
	 SetBlipColour(info.blip, info.colour)
	 SetBlipAsShortRange(info.blip, true)
	 BeginTextCommandSetBlipName("STRING")
	 AddTextComponentString(info.title)
	 EndTextCommandSetBlipName(info.blip)
   end
end)

function LoadMarkers()
	Citizen.CreateThread(function()
		for index, v in ipairs(Positions) do
			if index == 'SpawnATV' then
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hunting Spot')
				EndTextCommandSetBlipName(StartBlip)
				break
			end
		end
	end)


	LoadModel('blazer')
	LoadModel('a_c_deer')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')


end


	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			local plyCoords = GetEntityCoords(PlayerPedId())
			local hint = nil
			--print("Running thread")
				--if hint == nil then

					local distance = GetDistanceBetweenCoords(plyCoords, -769.23773193359, 5595.6215820313, 33.48571395874, true)

					if distance < 5.0 then
						--print("In dist")
						if OnGoingHuntSession then
							hint = '[E] Stop Hunting ($500 refund)'
						elseif not OnGoingHuntSession then
							--print("Not ongoing")
							hint = '[E] Start Hunting ($1,000 deposit)'
						end
						sleep = 5
						DrawM(hint, 27, -769.23773193359, 5595.6215820313, 33.48571395874 - 0.945, 255, 255, 255, 1.5, 15)
						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if OnGoingHuntSession then
									--print("Ongoing hunting session started")
									StartHuntingSession()
								else
									local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
									local Player = LocalPlayer:getCurrentCharacter()
									if Player.cash > 1000 then
										TriggerEvent('cash:remove', 1000)
										StartHuntingSession()
									elseif Player.cash < 1000 then
										TriggerEvent('DoLongHudText', 'You need at least $1,000', 2)
									end
								end
							end
						end
					end

				--end
				
			Citizen.Wait(sleep)
		end
	end)

local ply2
local canHunt = true

function StartHuntingSession()
	if canHunt == true then
		--timeout()
		ply2 = PlayerPedId()
		if OnGoingHuntSession then
			OnGoingHuntSession = false
			--print("Ongoing hunt set to false")
			if exports["urp-inventory"]:getQuantity(100416529) then
				TriggerServerEvent('urp-hunting:removeloadout')
				if DoesEntityExist(HuntCar) then
				DeleteEntity(HuntCar)
				end
				--print("Deleted loadout")
				for index, value in pairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						DeleteEntity(value.id)
					end
				end
			end
			TriggerEvent('cash:add', 500)
				--print("Started del")
				StartDelay()
				
			else
				OnGoingHuntSession = true
				--Car
				Citizen.CreateThread(function()
				vehiclehash = GetHashKey('blazer')
				RandomLoc()
				RequestModel(vehiclehash)
				CreateVehicle(vehiclehash, -769.6, 5592.7, 33.4, 169.7)
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				TriggerServerEvent('urp-hunting:giveloadout')
				Citizen.Wait(500)
				local plate = GetVehicleNumberPlateText(vehicle)
				TriggerServerEvent("flagcar",plate)
				SetVehicleHasBeenOwnedByPlayer(vehicle,true)
				Citizen.Wait(100)
				TriggerServerEvent('garage:addKeys', plate)
				TaskWarpPedIntoVehicle(PlayerPedId() , vehicle, -1)
				Citizen.Wait(3000)



				--Animals

				Citizen.CreateThread(function()
				AddRelationshipGroup('deer')
				local rand = math.random(1,4)
				for index, value in pairs(subLocations) do
					if value[index] == value[rand] then
						for k, v in pairs(value) do
							local rando = math.random(1,4)
							local Animal = nil
							if rando == 1 then
								Animal = CreatePed(5, GetHashKey('a_c_deer'), v['x'], v['y'], v['z'], 0.0, false, true)
							elseif rando == 2 then
								Animal = CreatePed(5, GetHashKey('a_c_deer'), v['x'], v['y'], v['z'], 0.0, false, true)
							elseif rando == 3 then
								Animal = CreatePed(5, GetHashKey('a_c_deer'), v['x'], v['y'], v['z'], 0.0, false, true)
							elseif rando == 4 then
								Animal = CreatePed(5, GetHashKey('a_c_deer'), v['x'], v['y'], v['z'], 0.0, false, true)
							end
							
							
							if rando == 1 then
								TaskWanderStandard(Animal, true, true)
								SetPedCanSwitchWeapon(Animal, true)
								SetPedAccuracy(Animal, 60)
								SetEntityInvincible(Animal, false)
								SetEntityVisible(Animal, true)
								SetEntityAsMissionEntity(Animal)
								SetPedFleeAttributes(Animal, 0, true)	
								SetPedRelationshipGroupHash(Animal, GetHashKey("deer"))
								SetRelationshipBetweenGroups(0, GetHashKey("deer"), GetHashKey("deer"))
								SetRelationshipBetweenGroups(5, GetHashKey("deer"), GetHashKey("PLAYER"))
								SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("deer"))
								--TaskSmartFleePed(ply2, Animal, 25, -1)
								--Blips
								local AnimalBlip = AddBlipForEntity(Animal)
								SetBlipSprite(AnimalBlip, 153)
								SetBlipColour(AnimalBlip, 1)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Deer')
								EndTextCommandSetBlipName(AnimalBlip)
								table.insert(AnimalsInSession, {id = Animal, x = v['x'], y = v['y'], z = v['z'], Blipid = AnimalBlip})
							elseif rando == 2 then
								TaskWanderStandard(Animal, true, true)
								SetPedCanSwitchWeapon(Animal, true)
								SetPedAccuracy(Animal, 60)
								SetEntityInvincible(Animal, false)
								SetEntityVisible(Animal, true)
								SetEntityAsMissionEntity(Animal)
								SetPedFleeAttributes(Animal, 0, true)	
								SetPedRelationshipGroupHash(Animal, GetHashKey("deer"))
								SetRelationshipBetweenGroups(0, GetHashKey("deer"), GetHashKey("deer"))
								SetRelationshipBetweenGroups(5, GetHashKey("deer"), GetHashKey("PLAYER"))
								SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("deer"))
								--TaskSmartFleePed(ply2, Animal, 25, -1)
								--Blips
								local AnimalBlip = AddBlipForEntity(Animal)
								SetBlipSprite(AnimalBlip, 153)
								SetBlipColour(AnimalBlip, 1)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Deer')
								EndTextCommandSetBlipName(AnimalBlip)
								table.insert(AnimalsInSession, {id = Animal, x = v['x'], y = v['y'], z = v['z'], Blipid = AnimalBlip})
							elseif rando == 3 then
								TaskWanderStandard(Animal, true, true)
								SetPedCanSwitchWeapon(Animal, true)
								SetPedAccuracy(Animal, 60)
								SetEntityInvincible(Animal, false)
								SetEntityVisible(Animal, true)
								SetEntityAsMissionEntity(Animal)
								SetPedFleeAttributes(Animal, 0, true)	
								SetPedRelationshipGroupHash(Animal, GetHashKey("deer"))
								SetRelationshipBetweenGroups(0, GetHashKey("deer"), GetHashKey("deer"))
								SetRelationshipBetweenGroups(5, GetHashKey("deer"), GetHashKey("PLAYER"))
								SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("deer"))
								--TaskSmartFleePed(ply2, Animal, 25, -1)
								--Blips
								local AnimalBlip = AddBlipForEntity(Animal)
								SetBlipSprite(AnimalBlip, 153)
								SetBlipColour(AnimalBlip, 1)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Deer')
								EndTextCommandSetBlipName(AnimalBlip)
								table.insert(AnimalsInSession, {id = Animal, x = v['x'], y = v['y'], z = v['z'], Blipid = AnimalBlip})
							elseif rando == 4 then
								TaskWanderStandard(Animal, true, true)
								SetPedCanSwitchWeapon(Animal, true)
								SetPedAccuracy(Animal, 60)
								SetEntityInvincible(Animal, false)
								SetEntityVisible(Animal, true)
								SetEntityAsMissionEntity(Animal)
								SetPedFleeAttributes(Animal, 0, true)	
								SetPedRelationshipGroupHash(Animal, GetHashKey("deer"))
								SetRelationshipBetweenGroups(0, GetHashKey("deer"), GetHashKey("deer"))
								SetRelationshipBetweenGroups(5, GetHashKey("deer"), GetHashKey("PLAYER"))
								SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("deer"))
								--TaskSmartFleePed(ply2, Animal, 25, -1)
								--Blips
								local AnimalBlip = AddBlipForEntity(Animal)
								SetBlipSprite(AnimalBlip, 153)
								SetBlipColour(AnimalBlip, 1)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString('Deer')
								EndTextCommandSetBlipName(AnimalBlip)
								table.insert(AnimalsInSession, {id = Animal, x = v['x'], y = v['y'], z = v['z'], Blipid = AnimalBlip})
							end
						end
					end
				end
			end)
				while OnGoingHuntSession do
					local sleep = 500
					for index, value in ipairs(AnimalsInSession) do
						if IsPedFleeing(value.id) then
							Citizen.Wait(10000)
							TaskSetBlockingOfNonTemporaryEvents(value.id, true)
							SetPedFleeAttributes(value.id, 0, 0)
							SetPedCombatAttributes(value.id, 17, 1)
							SetBlockingOfNonTemporaryEvents(value.id, 1)
							SetPedFleeAttributes(value.id, 0, 0)
							SetPedCombatAttributes(value.id, 17, 1)
							Citizen.Wait(500)
							SetPedFleeAttributes(value.id, 0, true)
							TaskSetBlockingOfNonTemporaryEvents(value.id, false)
							SetBlockingOfNonTemporaryEvents(value.id, 0)
							SetPedCombatAttributes(value.id, 17, 0)
							TaskWanderStandard(value.id, true, true)

							
							end

						if DoesEntityExist(value.id) then
							local AnimalCoords = GetEntityCoords(value.id)
							local PlyCoords = GetEntityCoords(PlayerPedId())
							local AnimalHealth = GetEntityHealth(value.id)
							local male = GetPedDrawableVariation(value.id, 8)
							local type = GetEntityModel(value.id)
							


							local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

							if AnimalHealth <= 0 then
								SetBlipColour(value.Blipid, 3)
								if PlyToAnimal < 2.0 then
									sleep = 5
									DrawText3Ds(AnimalCoords.x, AnimalCoords.y, AnimalCoords.z + 1, '[E] Slaughter Animal')
								
									if IsControlJustReleased(0, Keys['E']) then
										if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
											if DoesEntityExist(value.id) then
												table.remove(AnimalsInSession, index)
												TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
												TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
												local finished = exports["urp-taskbar"]:taskBar(10000,"Skinning")
												TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
												TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
													if finished == 100 then
													Citizen.Wait(5000)
													SlaughterAnimal(value.id, male, type)
												end
											else
												TriggerEvent('DoLongHudText', "You need to use a knife!", 2)
											end
										end
									end
								end
							end
						end
					end

					Citizen.Wait(sleep)
				end
			end)
		end
	end
end

function timeout()
	OnGoingHuntSession = true
	Citizen.Wait(5000)
	OnGoingHuntSession = false
end

function StartDelay()
	canHunt = false
	Citizen.Wait(6000) --30
	canHunt = true
end

function SlaughterAnimal(AnimalId, male, type)
	local deer = -664053099
	ClearPedTasksImmediately(PlayerPedId())
	if type == deer then
		local AnimalWeight = math.random(5, 15)
		TriggerEvent('player:receiveItem', 'deer', math.floor(AnimalWeight))
	end
	DeleteEntity(AnimalId)
end

function DrawM(hint, type, x, y, z)
	DrawText3Ds(x, y, z + 1, tostring(hint))
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end


function DrawText3Ds(x,y,z, text)
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

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if OnGoingHuntSession then
		if IsPlayerFreeAiming(PlayerId()) == false and HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE')) then 
		   		DisablePlayerFiring(PlayerPedId(), true)
			if IsPlayerFreeAiming(PlayerId()) == 1 and HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE')) then
				DisablePlayerFiring(PlayerPedId(), false)
			end
		end
			local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if IsPedAPlayer(targetPed) and HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE')) then
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE'))
				
				TriggerEvent('DoLongHudText', 'Hunting Humans is illegal!', 2)
				Citizen.Wait(1000)
			end
			
			sleep = 0
			timer = timer + 1
			SetAmmoInClip(PlayerPedId(), 'WEAPON_SNIPERRIFLE', 10)
			SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey('WEAPON_SNIPERRIFLE'))
		if timer > 180000 then 
			TriggerServerEvent('urp-hunting:removeloadout')
			TriggerEvent('DoLongHudText', 'Uh oh! you ran out of time, yoink!', 2)
			timer = 0
			OnGoingHuntSession = false
            if HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE'), false) then
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE'))
				SetPedInfiniteAmmo(PlayerPedId(), false, GetHashKey('WEAPON_SNIPERRIFLE'))
			end
		end
		else
			OnGoingHuntSession = false
            if HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE'), false) then
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_SNIPERRIFLE'))
				SetPedInfiniteAmmo(PlayerPedId(), false, GetHashKey('WEAPON_SNIPERRIFLE'))
				TriggerEvent('DoLongHudText', 'This weapon may only be used for hunting!', 2)
				TriggerServerEvent('urp-hunting:removeloadout')
            end
        end
        Wait(sleep)
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

Citizen.CreateThread(
    function()
        while true do
            local sleep = 500
            local plyCoords = GetEntityCoords(PlayerPedId())	
            local distance =
                GetDistanceBetweenCoords(plyCoords, 961.7893, -2111.507, 31.94839, true)

            if distance < 5.0 then
                sleep = 5
                DrawM("[E] Sell", 27, 961.7893, -2111.507, 31.94839 - 0.945, 255, 255, 255, 1.5, 15)
                if distance < 1.0 then
					if IsControlJustReleased(0, Keys["E"]) then
						if exports["urp-inventory"]:getQuantity("deer") >= 2 then
								playerAnim()
								local finished = exports["urp-taskbar"]:taskBar(4000,"Selling Goods",true,false,playerVeh)
								if finished == 100 then
									ClearPedTasksImmediately(PlayerPedId())
									TriggerEvent('inventory:removeItem', 'deer', 2)
									Citizen.Wait(1000)
									TriggerEvent('loopUpdateItems')
									TriggerEvent('cash:add', math.random(35,90))
							end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
)