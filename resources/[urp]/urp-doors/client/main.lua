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
local doorCoordsOffset = {}

Citizen.CreateThread(function()
	-- Update the door list
	TriggerServerEvent('urp-doors:getDoorInfo')
end)

RegisterNetEvent('urp-doors:getDoorInfo')
AddEventHandler('urp-doors:getDoorInfo', function(doorInfo, count)
	for localID = 1, count, 1 do
		if doorInfo[localID] ~= nil then
			Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
		end
	end
end)

RegisterNetEvent('urp-doors:currentlyhacking')
AddEventHandler('urp-doors:currentlyhacking', function(mycb)
			mycb = true
			TriggerEvent("mhacking:show") --This line is where the hacking even starts
			TriggerEvent("mhacking:start",7,19,mycb1) --This line is the difficulty and tells it to start. First number is how long the blocks will be the second is how much time they have is.
end)

function DrawText3DTest(x,y,z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropshadow(0, 0, 0, 0, 155)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText3D(x, y, z, text) 
    local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropshadow(0, 0, 0, 0, 155)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function isKeyDoor(num)
    if num == 0 then
        return false
    end
    if doorID.objName == "prop_gate_prison_01" then
        return false
    end
    if doorTypes[num]["doorType"] == "v_ilev_fin_vaultdoor" then
        return false
    end
    if doorTypes[num]["doorType"] == "hei_prop_station_gate" then
        return false
    end
    return true
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local letSleep = true
		local playerCoords = GetEntityCoords(PlayerPedId())

		for i=1, #Config.DoorList do
			local doorID   = Config.DoorList[i]
			local distance = GetDistanceBetweenCoords(playerCoords, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)

			local maxDistance = 1.25
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < maxDistance then
				letSleep = false
				objFound = GetClosestObjectOfType(doorID.objCoords["x"], doorID.objCoords["y"], doorID.objCoords["z"], 20.0, GetHashKey(doorID.objName), 0, 0, 0)
					if GetHashKey(GetHashKey(doorID.objName)) == -2023754432 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.05, 0.0, 0.0)  
					elseif GetHashKey(GetHashKey(doorID.objName)) == -1156020871 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.55, 0.0, -0.1)  
					elseif GetHashKey(GetHashKey(doorID.objName)) == -222270721 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.0)     
					elseif GetHashKey(GetHashKey(doorID.objName)) == 746855201 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.19, 0.0, 0.08)    
					elseif GetHashKey(GetHashKey(doorID.objName)) == 1309269072 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.45, 0.0, 0.02)        
					elseif GetHashKey(GetHashKey(doorID.objName)) == -1023447729 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.45, 0.0, 0.02)  
					elseif GetHashKey(GetHashKey(doorID.objName)) == `v_ilev_fingate` then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.37, 0.0, 0.05)
					elseif GetHashKey(GetHashKey(doorID.objName)) == `prop_fnclink_02gate7` then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.37, 0.0, 0.05)
					elseif GetHashKey(doorID.objName) == -495720969 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.25, 0.0, 0.02)
					elseif GetHashKey(doorID.objName) == -1612152164 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.15, 0.0, 1.10)
					elseif GetHashKey(doorID.objName) == 464151082 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.3)  
					elseif GetHashKey(doorID.objName) == -543497392 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1770281453 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1173348778 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 479144380 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1242124150 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 2088680867 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == -320876379 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 631614199 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == -1320876379 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)  
					elseif GetHashKey(doorID.objName) == -1437850419  then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)  
					elseif GetHashKey(doorID.objName) == -681066206 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 245182344 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) ==  -1167410167 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 1.2)                              
					elseif GetHashKey(doorID.objName) == -642608865 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.32, 0.0, -0.23)
					elseif GetHashKey(doorID.objName) == 749848321 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
					elseif GetHashKey(doorID.objName) == 933053701 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
					elseif GetHashKey(doorID.objName) == 185711165 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
					elseif GetHashKey(doorID.objName) == -1726331785 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)                                                                                    
					elseif GetHashKey(doorID.objName) == 551491569 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.23)  
					elseif GetHashKey(doorID.objName) == -710818483 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.3, 0.0, -0.23)  
					elseif GetHashKey(doorID.objName) == -543490328 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, 0.0)  
					elseif GetHashKey(doorID.objName) == -1417290930 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.0, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == -574290911 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1773345779 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1971752884 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1641293839 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.07, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1507503102 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.10, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 1888438146 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.9, 0.0, 0.0)  
					elseif GetHashKey(doorID.objName) == 272205552 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.1, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 9467943 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
					elseif GetHashKey(doorID.objName) == 534758478 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
					elseif GetHashKey(doorID.objName) == 988364535 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.4, 0.0, 0.1)
					elseif GetHashKey(doorID.objName) == -1141522158 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -0.4, 0.0, 0.1)
					elseif GetHashKey(doorID.objName) == 430324891 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 1.0)
					elseif GetHashKey(doorID.objName) == 262839150 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
					elseif GetHashKey(doorID.objName) == 1645000677 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
					elseif GetHashKey(doorID.objName) == -131296141 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
					elseif GetHashKey(doorID.objName) == 1557126584 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.1)
					elseif GetHashKey(doorID.objName) == 320433149 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
					elseif GetHashKey(doorID.objName) == 1417577297 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -0.8, 0.0, 0.0)
					elseif GetHashKey(doorID.objName) == 2059227086 then
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.8, 0.0, 0.0)
					else
						doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1) 
					end
				local closestString = "None"
				ApplyDoorState(doorID)
				if doorID.locked then 
					closestString = "[E] - Locked"
					DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], closestString) 
				elseif doorID.locked == false then 
					closestString = "[E] - Unlocked"
					DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], closestString) 
				end
				if  IsControlJustReleased(1,  38) then
					local isAuthorized = IsAuthorized(doorID)
					if isAuthorized then
						if doorID.locked == false then
							local active = true
							local swingcount = 0
							TriggerEvent("dooranim")
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
							doorID.locked = true
							while active do
								Citizen.Wait(1)
								DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Locking")
								locked, heading = GetStateOfClosestDoorOfType(GetHashKey(doorID.objName), doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z) 
								heading = math.ceil(heading * 100)
								
								local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)
								local dst2 = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1830.45, 2607.56, 45.59,true)

								if heading < 1.5 and heading > -1.5 then
									swingcount = swingcount + 1
								end             
								if dist > 150.0 or swingcount > 100 or dst2 < 200.0 then
									active = false
								end
							end
						elseif doorID.locked == true then

							local active = true
							local swingcount = 0
							TriggerEvent("dooranim")
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors',0.4)
							doorID.locked = false
							while active do
								Citizen.Wait(1)
								if GetHashKey(GetHashKey(doorID.objName)) == -2023754432 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.05, 0.0, 0.0)  
								elseif GetHashKey(GetHashKey(doorID.objName)) == -1156020871 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.55, 0.0, -0.1)  
								elseif GetHashKey(GetHashKey(doorID.objName)) == -222270721 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.0)     
								elseif GetHashKey(GetHashKey(doorID.objName)) == 746855201 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.19, 0.0, 0.08)    
								elseif GetHashKey(GetHashKey(doorID.objName)) == 1309269072 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.45, 0.0, 0.02)        
								elseif GetHashKey(GetHashKey(doorID.objName)) == -1023447729 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.45, 0.0, 0.02)  
								elseif GetHashKey(GetHashKey(doorID.objName)) == `v_ilev_fingate` then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.37, 0.0, 0.05)
								elseif GetHashKey(GetHashKey(doorID.objName)) == `prop_fnclink_02gate7` then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.37, 0.0, 0.05)
								elseif GetHashKey(doorID.objName) == -495720969 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.25, 0.0, 0.02)
								elseif GetHashKey(doorID.objName) == -1612152164 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.15, 0.0, 1.10)
								elseif GetHashKey(doorID.objName) == 464151082 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.3)  
								elseif GetHashKey(doorID.objName) == -543497392 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1770281453 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1173348778 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 479144380 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1242124150 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 2088680867 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == -320876379 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 631614199 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == -1320876379 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)  
								elseif GetHashKey(doorID.objName) == -1437850419  then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)  
								elseif GetHashKey(doorID.objName) == -681066206 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 245182344 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) ==  -1167410167 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 1.2)                              
								elseif GetHashKey(doorID.objName) == -642608865 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.32, 0.0, -0.23)
								elseif GetHashKey(doorID.objName) == 749848321 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
								elseif GetHashKey(doorID.objName) == 933053701 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
								elseif GetHashKey(doorID.objName) == 185711165 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)
								elseif GetHashKey(doorID.objName) == -1726331785 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.08, 0.0, 0.2)                                                                                    
								elseif GetHashKey(doorID.objName) == 551491569 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.23)  
								elseif GetHashKey(doorID.objName) == -710818483 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.3, 0.0, -0.23)  
								elseif GetHashKey(doorID.objName) == -543490328 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, 0.0)  
								elseif GetHashKey(doorID.objName) == -1417290930 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.0, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == -574290911 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1773345779 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1971752884 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.14, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1641293839 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.07, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 1507503102 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.10, 0.0, 0.0)
			
								
								
			
								elseif GetHashKey(doorID.objName) == 1888438146 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.9, 0.0, 0.0)  
								elseif GetHashKey(doorID.objName) == 272205552 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.1, 0.0, 0.0)
			
								elseif GetHashKey(doorID.objName) == 9467943 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
								elseif GetHashKey(doorID.objName) == 534758478 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
			
								elseif GetHashKey(doorID.objName) == 988364535 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.4, 0.0, 0.1)
								elseif GetHashKey(doorID.objName) == -1141522158 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -0.4, 0.0, 0.1)
								elseif GetHashKey(doorID.objName) == 430324891 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 1.0)
								elseif GetHashKey(doorID.objName) == 262839150 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
								elseif GetHashKey(doorID.objName) == 1645000677 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
								elseif GetHashKey(doorID.objName) == -131296141 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.0, 0.0, -0.1)
								elseif GetHashKey(doorID.objName) == 1557126584 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.1)
								elseif GetHashKey(doorID.objName) == 320433149 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, 0.1)
								elseif GetHashKey(doorID.objName) == 1417577297 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -0.8, 0.0, 0.0)
								elseif GetHashKey(doorID.objName) == 2059227086 then
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 0.8, 0.0, 0.0)
			
			
								else
									doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1) 
								end

								DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Unlocking")
								swingcount = swingcount + 1
								if swingcount > 100 then
									active = false
								end

							end

						end
					end
					TriggerServerEvent('urp-doors:updateState', i, doorID.locked)
				end
			end
		end
		if letSleep == true then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('urp-doors:UseRedKeycard')
AddEventHandler('urp-doors:UseRedKeycard', function()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1779.3, 2595.94,50.68, true)
	if distance < 1 then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
		FreezeEntityPosition(PlayerPedId(), true)
--		exports["urp_taskbar"]:StartDelayedFunction('Inserting Red Key Card', 5000, function()
			local finished = exports["urp-taskbar"]:taskBar(5000,"Inserting Red Key Card")
			if finished == 100 then
			TriggerServerEvent('urp-doors:updateState', 5, false)
			FreezeEntityPosition(PlayerPedId(), false)
			ClearPedTasks(PlayerPedId())
		end
	 end
end)

RegisterNetEvent('urp-doors:UseRedKeycard2')
AddEventHandler('urp-doors:UseRedKeycard2', function()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1846.598, 2604.773, 45.57809, true)
	if distance < 1 then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
		FreezeEntityPosition(PlayerPedId(), true)
--		exports["urp_taskbar"]:StartDelayedFunction('Hacking', 10000, function()

			local finished = exports["urp-taskbar"]:taskBar(10000,"Hacking")
			if finished == 100 then
			
			TriggerServerEvent('urp-doors:updateState', 104, false)
			FreezeEntityPosition(PlayerPedId(), false)
			ClearPedTasks(PlayerPedId())
		end
	end
end)

RegisterNetEvent('urp-doors:UseRedKeycard3')
AddEventHandler('urp-doors:UseRedKeycard3', function()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1819.976, 2604.677, 45.57671, true)
	if distance < 1 then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
		FreezeEntityPosition(PlayerPedId(), true)
--		exports["urp_taskbar"]:StartDelayedFunction('Hacking', 5000, function()

			local finished = exports["urp-taskbar"]:taskBar(5000,"Hacking")
			if finished == 100 then


			TriggerServerEvent('urp-doors:updateState', 105, false)
			FreezeEntityPosition(PlayerPedId(), false)
			ClearPedTasks(PlayerPedId())
		end
	end
end)

RegisterNetEvent('urp-doors:UseRedKeycard4')
AddEventHandler('urp-doors:UseRedKeycard4', function()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1804.749, 2615.767, 45.5513, true)
	if distance < 1 then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
		FreezeEntityPosition(PlayerPedId(), true)
--		exports["urp_taskbar"]:StartDelayedFunction('Hacking', 5000, function()
			local finished = exports["urp-taskbar"]:taskBar(5000,"Hacking")
			if finished == 100 then
			TriggerServerEvent('urp-doors:updateState', 25, false)
			FreezeEntityPosition(PlayerPedId(), false)
			ClearPedTasks(PlayerPedId())
		end
	end
end)


Citizen.CreateThread(function()
	 while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local dst = GetDistanceBetweenCoords(coords, 1846.598, 2604.773, 45.57809, true)
		if dst <= 1 then
			DrawText3D(1846.598, 2604.773, 45.57809, "[E] - (Stage 1) Jail Break")
			if dst <= 1 and IsControlJustReleased(0, 38) then
				if exports['urp-inventory']:hasEnoughOfItem('thermite', 1) then
					TriggerEvent('inventory:removeItem', 'thermite', 1)
					FreezeEntityPosition(PlayerPedId(), true)
					local outcome = exports['urp-thermite']:startGame(10,1,8,400)
					if outcome then
						FreezeEntityPosition(PlayerPedId(), false)
						TriggerServerEvent("urp-doors:jailbreak")
					else
						local coords = GetEntityCoords(PlayerPedId())
						exports['urp-thermite']:startFireAtLocation(coords.x, coords.y, coords.z - 1, 10000)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	   Citizen.Wait(0)
	   local coords = GetEntityCoords(PlayerPedId())
	   local dst = GetDistanceBetweenCoords(coords, 1819.976, 2604.677, 45.57671, true)
	   if dst <= 1 then
		   DrawText3D(1819.976, 2604.677, 45.57671, "[E] - (Stage 2) Jail Break")
		   if dst <= 1 and IsControlJustReleased(0, 38) then
			if exports['urp-inventory']:hasEnoughOfItem('thermite', 1) then
				TriggerEvent('inventory:removeItem', 'thermite', 1)
				FreezeEntityPosition(PlayerPedId(), true)
				local outcome = exports['urp-thermite']:startGame(15,1,10,300)
				if outcome then
					FreezeEntityPosition(PlayerPedId(), false)
					TriggerServerEvent("urp-doors:jailbreak2")
				else
					local coords = GetEntityCoords(PlayerPedId())
					exports['urp-thermite']:startFireAtLocation(coords.x, coords.y, coords.z - 1, 10000)
				end
			end
		   end
	   end
   end
end)

Citizen.CreateThread(function()
	while true do
	   Citizen.Wait(0)
	   local coords = GetEntityCoords(PlayerPedId())
	   local dst = GetDistanceBetweenCoords(coords, 1804.749, 2615.767, 45.5513, true)
	   if dst <= 1 then
		   DrawText3D(1804.749, 2615.767, 45.5513, "[E] - (Stage 3) Jail Break")
		   if dst <= 1 and IsControlJustReleased(0, 38) then
				if exports['urp-inventory']:hasEnoughOfItem('thermite', 1) then
					TriggerEvent('inventory:removeItem', 'thermite', 1)
					FreezeEntityPosition(PlayerPedId(), true)
					local outcome = exports['urp-thermite']:startGame(10,1,7,500)
					if outcome then
						FreezeEntityPosition(PlayerPedId(), false)
						TriggerServerEvent("urp-doors:jailbreak3")
					else
						local coords = GetEntityCoords(PlayerPedId())
						exports['urp-thermite']:startFireAtLocation(coords.x, coords.y, coords.z - 1, 10000)
					end
				end
		   end
	   end
   end
end)


RegisterCommand('lockdoors', function()
	local job = exports['urp-base']:getModule("LocalPlayer"):getCurrentCharacter().job
	if job == 'Police' then
		local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
		local finished = exports["urp-taskbar"]:taskBar(5000,"Re-Locking All Doors",false,false,playerVeh)
		if finished == 100 then
			for i=1, #Config.PrisonDoors do
				TriggerServerEvent('urp-doors:updateState', i, true)
			end
			exports['mythic_notify']:DoHudText('inform', "All doors re-locked")
		end
	end
end)

RegisterNetEvent('urp-jailbreak:UnlockAll')
AddEventHandler('urp-jailbreak:UnlockAll', function()
	Citizen.Wait(300000)
	for i=1, #Config.PrisonDoors do
		TriggerServerEvent('urp-doors:updateState', i, false)
	end
end)

function ApplyDoorState(doorID)
	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, GetHashKey(doorID.objName), false, false, false)
	FreezeEntityPosition(closeDoor, doorID.locked)
end

function IsAuthorized(doorID)
	local job = exports['urp-base']:getModule("LocalPlayer"):getCurrentCharacter().job
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == job then
			return true
		end
	end

	return false
end


-- Set state for a door
RegisterNetEvent('urp-doors:setState')
AddEventHandler('urp-doors:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)

RegisterNetEvent('urp-doors:setState2')
AddEventHandler('urp-doors:setState2', function(doorID, state)
	Config.PrisonDoors2[doorID].locked = false
end)





