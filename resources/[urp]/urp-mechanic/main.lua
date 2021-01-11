local degHealth = {
	["breaks"] = 0,-- has neg effect
	["axle"] = 0,	-- has neg effect
	["radiator"] = 0, -- has neg effect
	["clutch"] = 0,	-- has neg effect
	["transmission"] = 0, -- has neg effect
	["electronics"] = 0, -- has neg effect
	["fuel_injector"] = 0, -- has neg effect
	["fuel_tank"] = 0 
}
local engineHealth = 0
local bodyHealth = 0
Job = nil

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-339.2438,-136.6063,38.55546)
	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Bad Boy Customs')
	EndTextCommandSetBlipName(blip)
end)
-- #MarkedForMarker
Citizen.CreateThread(function()
      while true do
       Citizen.Wait(5)
       local plyId = PlayerPedId()
       local plyCoords = GetEntityCoords(plyId)
       local dstStorage = #(plyCoords - vector3(-347.0924, -133.5083, 39.00967))
       local dstRepair = #(plyCoords - vector3(-339.2438,-136.6063,38.55546))
       local dstRepair2 = #(plyCoords - vector3(-339.2438,-136.6063,38.55546))
       
       if Job == "Mechanic" then
       if dstStorage < 2.0  then
        DrawMarker(22,-347.0924, -133.5083, 39.00967, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 
        RegisterCommand('mech', function(source, args)
            TriggerEvent("mech:tools", args)
        end)
       elseif dstRepair < 10.0 then
        RegisterCommand('repair', function(source, args)
            repairVeh(args)
        end)
    elseif dstRepair2 < 25.0 then
        RegisterCommand('repair', function(source, args)
            repairVeh(args)
        end)
       else
         if dstStorage > 10.0 and dstRepair > 10.0 then
           Citizen.Wait(2000)
         end
       end
     end
    end
end)

RegisterNetEvent("mech:tools")
AddEventHandler("mech:tools", function(args)
    if args[1] == "check" then
        TriggerServerEvent("mech:check:materials")
    elseif args[1] == "add" then
        if exports["urp-inventory"]:hasEnoughOfItem(args[2],1,false) then
            TriggerServerEvent("mech:add:materials", args[2],tonumber(args[3]))
        else
            TriggerEvent("DoShortHudText", "You don't have the materials",2)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if Job == "Mechanic" then
        TriggerEvent('chat:addSuggestion', '/mech', 'Use by mechanic!')
        TriggerEvent('chat:addSuggestion', '/mech add', '/mech add [materials] [amount]')
        TriggerEvent('chat:addSuggestion', '/repair', '/repair [parts] [amount]')
        end
    end
end)

function repairVeh(args)
    if Job == "Mechanic" then
        local degname = string.lower(args[1])
        local amount = tonumber(args[2])
        if amount == nil then
            TriggerEvent("DoShortHudText", "No amount? KEKW", 2)
            return
        end
        playerped = PlayerPedId()
        coordA = GetEntityCoords(playerped, 1)
        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        veh = getVehicleInDirection(coordA, coordB)
        local itemname = "Scrap"
        local itemid = 26
        local garagename = "NAME"
        local notfucked = false
        local current = 100

        if degname == "body" or degname == "Body" then
            itemid = 28
            itemname = "Glass"
            degname = "body"
            notfucked = false
            current = bodyHealth
        end

        if degname == "Engine" or degname == "engine" then
            degname = "engine"
            notfucked = false
            current = engineHealth
        end

        if degname == "brakes" or degname == "Brakes" then
            itemid = 33
            itemname = "Rubber"
            degname = "breaks"
            notfucked = true
            current = degHealth["breaks"]
        end

        if degname == "Axle" or degname == "axle" then
            degname = "axle"
            notfucked = true
            current = degHealth["axle"]
        end

        if degname == "Radiator" or degname == "radiator" then
            degname = "radiator"
            notfucked = true
            current = degHealth["radiator"]
        end

        if degname == "Clutch" or degname == "clutch" then
            degname = "clutch"
            notfucked = true
            current = degHealth["clutch"]
        end

        if degname == "electronics" or degname == "Electronics" then
            degname = "electronics"
            itemid = 27
            itemname = "Plastic"
            notfucked = true
            current = degHealth["electronics"]
        end

        if degname == "fuel" or degname == "Fuel" then
            itemid = 30
            itemname = "Steel"
            degname = "fuel_tank"
            notfucked = true
            current = degHealth["fuel_tank"]
        end

        if degname == "transmission" or degname == "Transmission" then
            itemid = 31
            itemname = "Aluminium"
            degname = "transmission"
            notfucked = true
            current = degHealth["transmission"]
        end

        if degname == "Injector" or degname == "injector" then
            itemid = 34
            itemname = "Copper"
            degname = "fuel_injector"
            notfucked = true
            current = degHealth["fuel_injector"]
        end

        if not notfucked then
            TriggerEvent("DoShortHudText","Only mechanics can repair this or not exist",2)
        else

            
            local playerped = PlayerPedId()
            RequestAnimDict("mp_car_bomb")
            TaskPlayAnim(playerped,"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(playerped,"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)

                local finished = exports["urp-taskbar"]:taskBar(15000,"Repairing")
                local coordA = GetEntityCoords(playerped, 1)
                local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
                local targetVehicle = getVehicleInDirection(coordA, coordB)

                if finished == 100 then
                    local plate = GetVehicleNumberPlateText(targetVehicle)
                    ---print(degname,string.lower(itemname),amount,current,plate)
                    if targetVehicle ~= nil  and targetVehicle ~= 0 then
                        TriggerServerEvent('scrap:towTake',degname,string.lower(itemname),amount,current,plate)
                    else
                        TriggerEvent("DoShortHudText","No Vehicle")
                    end
                else
                    --print("REPAIR: 12")
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
    
    if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
  end
  
  RegisterCommand('clean', function()
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if Job == 'Mechanic' then
  
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
  
        local vehicle = nil
  
        if IsPedInAnyVehicle(playerPed, false) then
          vehicle = GetVehiclePedIsIn(playerPed, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
  
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
          Citizen.CreateThread(function()
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            TriggerEvent('DoLongHudText', 'Vehicle Cleaned', 1)
          end)
        end
      end
    end
  end)  

Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        Job = exports['isPed']:isPed('job')
    end
end)

-- chopshop
local HasAlreadyEnteredMarker = false

local CurrentActionMsg        = nil

local beingchopped            = false
choppingcd = false
carpick = nil

carpick2 = nil

carpick3 = nil

local chopshop_mechanic
Citizen.CreateThread(function()

    local hashkey = GetHashKey(Config.NPCName)

	RequestModel(hashkey)
	while not HasModelLoaded(hashkey) do Wait(1) end

	chopshop_mechanic = CreatePed(1, hashkey, Config.NPCLocation.x, Config.NPCLocation.y, Config.NPCLocation.z, Config.NPCLocation.h, false, true)
	SetBlockingOfNonTemporaryEvents(chopshop_mechanic, true)
	SetPedDiesWhenInjured(chopshop_mechanic, false)
	SetPedCanPlayAmbientAnims(chopshop_mechanic, true)
	SetPedCanRagdollFromPlayerImpact(chopshop_mechanic, false)
	SetEntityInvincible(chopshop_mechanic, true)
	FreezeEntityPosition(chopshop_mechanic, true)
    TaskStartScenarioInPlace(chopshop_mechanic, Config.NPCScenerioCurrent, 0, true);

end)

function Draw3dText(x,y,z, text)
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


Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false

		if(GetDistanceBetweenCoords(coords, Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z, true) < 5.0) then
			isInMarker  = true
		end

		if (isInMarker) then
            HasAlreadyEnteredMarker = true
            if beingchopped == false then
                TriggerEvent('urp-chopshop:entered')
            end
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and beingchopped == false then
                Draw3dText(Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z + 1.0, "[E] - Start Chopping")
            elseif not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and beingchopped == false then
                Draw3dText(Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z + 1.0, "Not in vehicle")
            end
		end

		if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
			TriggerEvent('urp-chopshop:exited')
        end

        if beingchopped then
            DisableActions()
        end
	end
end)

RegisterCommand('choplist', function()
    if choppingcd == false then
        carchoice1 = math.random(1,5)
        carchoice2 = math.random(6,10)
        carchoice3 = math.random(11,15)
        if carchoice1 == 1 then
            carpick = 'rebel'
        end
        if carchoice1 == 2 then
            carpick = 'sadler'
        end
        if carchoice1 == 3 then
            carpick = 'sandking'
        end
        if carchoice1 == 4 then
            carpick = 'sultan'
        end
        if carchoice1 == 5 then
            carpick = 'sanchez'
        end
        -----------------------
        if carchoice2 == 6 then
            carpick2 = 'emperor'
        end
        if carchoice2 == 7 then
            carpick2 = 'voodoo2'
        end
        if carchoice2 == 8 then
            carpick2 = 'surfer2'
        end
        if carchoice2 == 9 then
            carpick2 = 'bison'
        end
        if carchoice2 == 10 then
            carpick2 = 'blazer'
        end
        -----------------------
        if carchoice3 == 11 then
            carpick3 = 'regina'
        end
        if carchoice3 == 12 then
            carpick3 = 'phoenix'
        end
        if carchoice3 == 13 then
            carpick3 = 'bfinjection'
        end
        if carchoice3 == 14 then
            carpick3 = 'patriot'
        end
        if carchoice3 == 15 then
            carpick3 = 'buccaneer2'
        end
        TriggerEvent("phone:addnotification", "Chopper Kian","<b>Required List:</b> <p>".. carpick.. '<p>'.. carpick2.. '<p>' ..carpick3.. '<p> <b>Get Choppin!</b>')
        choppingcd = true
        Citizen.Wait(3600000)
        TriggerEvent('Removehehe')
    else
        TriggerEvent('DoLongHudText', 'ERROR: Come back later!', 2)
    end
end)

RegisterNetEvent('Removehehe')
AddEventHandler('Removehehe', function()
    choppingcd = false
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        if CurrentActionMsg == nil then
            Citizen.Wait(500)
        else
            if not beingchopped then
                if IsControlJustReleased(0, Config.ActionButton) then
                    ClearPedTasksImmediately(chopshop_mechanic)
                    TaskStartScenarioInPlace(chopshop_mechanic, Config.NPCScenerioInProg, 0, true)
                    SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), false, false, true)
                    TriggerEvent('urp-chopshop:startchop')
                end
            end
        end
    end
end)

function OpenParts()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsUsing(ped)
    Citizen.Wait(10)
    exports["urp-taskbar"]:taskBar(3000, "Opening Driver Door")
    Citizen.Wait(10)
    SetVehicleDoorOpen(vehicle, 0, false, false)
    Citizen.Wait(10)
    exports["urp-taskbar"]:taskBar(3000, "Opening Passenger Door")
    Citizen.Wait(10)
    SetVehicleDoorOpen(vehicle, 1, false, false)
    Citizen.Wait(10)
    if GetEntityBoneIndexByName(vehicle, 'door_dside_r') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Opening Back Left Door")
        Citizen.Wait(10)
        SetVehicleDoorOpen(vehicle, 2, false, false)
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Opening Back Right Door")
        Citizen.Wait(10)
        SetVehicleDoorOpen(vehicle, 3, false, false)
        Citizen.Wait(10)
    end
    if GetEntityBoneIndexByName(vehicle, 'bonnet') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Opening Hood")
        Citizen.Wait(10)
        SetVehicleDoorOpen(vehicle, 4, false, false)
        Citizen.Wait(10)
    end
    if GetEntityBoneIndexByName(vehicle, 'boot') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Opening Trunk")
        Citizen.Wait(10)
        SetVehicleDoorOpen(vehicle, 5, false, false)
        Citizen.Wait(10)
    end
end

function ShutParts()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsUsing(ped)
    SetVehicleUndriveable(vehicle, false)
    Citizen.Wait(1000)
    SetVehicleDoorsShut(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true, true)
end
function RemoveParts()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsUsing(ped)
    Citizen.Wait(10)
    exports["urp-taskbar"]:taskBar(3000, "Removing Driver Door")
    Citizen.Wait(10)
    SetVehicleDoorBroken(vehicle,0, true)
    Citizen.Wait(10)
    exports["urp-taskbar"]:taskBar(3000, "Removing Passenger Door")
    Citizen.Wait(10)
    SetVehicleDoorBroken(vehicle,1, true)
    if GetEntityBoneIndexByName(vehicle, 'door_dside_r') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Removing Back Left Door")
        Citizen.Wait(10)
        SetVehicleDoorBroken(vehicle,2, true)
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Removing Back Right Door")
        Citizen.Wait(10)
        SetVehicleDoorBroken(vehicle,3, true)
        Citizen.Wait(10)
    end
    if GetEntityBoneIndexByName(vehicle, 'bonnet') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Removing Hood")
        Citizen.Wait(10)
        SetVehicleDoorBroken(vehicle,4, true)
        Citizen.Wait(10)
    end
    if GetEntityBoneIndexByName(vehicle, 'boot') ~= -1 then
        Citizen.Wait(10)
        exports["urp-taskbar"]:taskBar(3000, "Removing Trunk")
        Citizen.Wait(10)
        SetVehicleDoorBroken(vehicle,5, true)
    end
end

RegisterNetEvent('urp-chopshop:startchop')
AddEventHandler('urp-chopshop:startchop', function ()
    beingchopped = true
    CurrentActionMsg = nil
    local ped = GetPlayerPed( -1 )
    for i = 1, #Config.Progress, 1 do
        local table2 = Config.Progress[i]
        if IsPedInAnyVehicle(ped, true) then

            for key, value in pairs(table2) do
                if IsPedInAnyVehicle(ped, true) then
                    exports["urp-taskbar"]:taskBar(2000, value)
                    Citizen.Wait(key*200)
                else
                    break
                end
            end
        else
            break
        end
    end
    if IsPedInAnyVehicle(ped, true) then
        local vehicle = GetVehiclePedIsIn( ped, true )
        local vehicle2 = GetVehiclePedIsIn(ped, false)
        local vehicleproper = GetEntityModel(vehicle2)
        print(vehicleproper)
        print(carpick)
        local vehiclehash1 = GetHashKey(carpick)
        local vehiclehash2 = GetHashKey(carpick2)
        local vehiclehash3 = GetHashKey(carpick3)
        print(vehiclehash1)
        print('------')
        print(vehicleproper)
        print(vehicle)
        local carnamepedin = ''
        OpenParts()
        local ssstring = ''
        if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
            SetEntityAsMissionEntity( vehicle, true, true )
            canchop = false
            if vehicleproper == vehiclehash1 then
                canchop = true
            end
            if vehicleproper == vehiclehash2 then
                canchop = true
            end
            if vehicleproper == vehiclehash3 then
                canchop = true
            end            
            -- for key, value in pairs(Config.Cars) do
            --     if IsVehicleModel(vehicle, key) then
            --         canchop = true
            --     end
            -- end
            carnamepedin = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
            if vehicleproper == vehiclehash1 then
                RemoveParts()

                TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
				while IsPedInVehicle(PlayerPedId(), vehicle, true) do Citizen.Wait(0) end
				Citizen.Wait(500)
                NetworkFadeOutEntity(vehicle, true, true)
				Citizen.Wait(100)
                DeleteVehicle(vehicle)
                                
                ssstring = Config.Success
                ShutParts()
                ssstring = ssstring:gsub('%%car%%',carnamepedin)
                -- ssstring = ssstring:gsub('%%plate%%',plate)
                TriggerServerEvent('urp-chopshop:addCash', source)
                TriggerEvent('DoLongHudText', 'You got scraps and money for the vehicle.', 1)
                local luck = math.random(1,4)
                if luck == 4 then
                    TriggerEvent('cash:add', math.random(20,60))
                end
                beingchopped = false
                return
            elseif vehicleproper == vehiclehash2 then
                RemoveParts()

                TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
				while IsPedInVehicle(PlayerPedId(), vehicle, true) do Citizen.Wait(0) end
				Citizen.Wait(500)
                NetworkFadeOutEntity(vehicle, true, true)
				Citizen.Wait(100)
                DeleteVehicle(vehicle)
                                
                ssstring = Config.Success
                ShutParts()
                ssstring = ssstring:gsub('%%car%%',carnamepedin)
                -- ssstring = ssstring:gsub('%%plate%%',plate)
                TriggerServerEvent('urp-chopshop:addCash', source)
                TriggerEvent('DoLongHudText', 'You got scraps and money for the vehicle.', 1)
                local luck = math.random(1,4)
                if luck == 4 then
                    TriggerEvent('cash:add', math.random(20,60))
                end
                beingchopped = false
                return
            elseif vehicleproper == vehiclehash3 then
                RemoveParts()

                TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
				while IsPedInVehicle(PlayerPedId(), vehicle, true) do Citizen.Wait(0) end
				Citizen.Wait(500)
                NetworkFadeOutEntity(vehicle, true, true)
				Citizen.Wait(100)
                DeleteVehicle(vehicle)
                                
                ssstring = Config.Success
                ShutParts()
                ssstring = ssstring:gsub('%%car%%',carnamepedin)
                -- ssstring = ssstring:gsub('%%plate%%',plate)
                TriggerServerEvent('urp-chopshop:addCash', source)
                TriggerEvent('DoLongHudText', 'You got scraps and money for the vehicle.', 1)
                local luck = math.random(1,4)
                if luck == 4 then
                    TriggerEvent('cash:add', math.random(20,60))
                end
                beingchopped = false
                return
            else
                ssstring = Config.FailChop
            end
        else
            ssstring = Config.FailSeat
        end
        ShutParts()
        ssstring = ssstring:gsub('%%car%%',carnamepedin)
        -- ssstring = ssstring:gsub('%%plate%%',plate)
        TriggerEvent('DoLongHudText', 'Come back in a different vehicle.', 1)
    else
        TriggerEvent('DoLongHudText', Config.FailLeft, 2)
        ShutParts()
    end
    beingchopped = false
    ClearPedTasksImmediately(chopshop_mechanic)
	TaskStartScenarioInPlace(chopshop_mechanic, Config.NPCScenerioCurrent, 0, true);
end)

-- we can create these later if needed
--[[Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z)

	SetBlipSprite (blip, Config.BlipSprite)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, Config.BlipScale)
	SetBlipColour (blip, Config.BlipColor)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Blipname)
	EndTextCommandSetBlipName(blip)
end)]]--

AddEventHandler('urp-chopshop:entered', function ()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, true) then
        CurrentActionMsg = Config.ActionMsg
    end
end)

AddEventHandler('urp-chopshop:exited', function ()
	CurrentActionMsg = nil
end)

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function convertcolor(from, to)
    fade = Config.MarkerFadeTimer
    if from.r ~= to.r then
        if from.r < to.r then
            to.r = to.r - fade
            if from.r > to.r then
                to.r = to.r + 1
            end
        else
            to.r = to.r + fade
            if from.r > to.r then
                to.r = to.r - 1
            end
        end
    end
    if from.g ~= to.g then
        if from.g < to.g then
            to.g = to.g - fade
            if from.g > to.g then
                to.g = to.g + 1
            end
        else
            to.g = to.g + fade
            if from.g > to.g then
                to.g = to.g - 1
            end
        end
    end
    if from.b ~= to.b then
        if from.b < to.b then
            to.b = to.b - fade
            if from.b > to.b then
                to.b = to.b + 1
            end
        else
            to.b = to.b + fade
            if from.b > to.b then
                to.b = to.b - 1
            end
        end
    end
    if from.a ~= to.a then
        if from.a < to.a then
            to.a = to.a - fade
            if from.a > to.a then
                to.a = to.a + 1
            end
        else
            to.a = to.a + fade
            if from.a > to.a then
                to.a = to.a - 1
            end
        end
    end
    return to
end

function DisableActions()
    if Config.DisableMouse then
        DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    end

    if Config.DisableMovement then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end

    if Config.DisableCarMovement then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if Config.DisableCombat then
        DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
    end
end
