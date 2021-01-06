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

-- gas filling
DecorRegister("CurrentFuel", 3)
Fuel = 0
local gasStations = {
    {49.41872, 2778.793, 58.04395,600},
    {263.8949, 2606.463, 44.98339,600},
    {1039.958, 2671.134, 39.55091,900},
    {1207.26, 2660.175, 37.89996,900},
    {2539.685, 2594.192, 37.94488,1500},
    {2679.858, 3263.946, 55.24057,1500},
    {2005.055, 3773.887, 32.40393,1200},
    {1687.156, 4929.392, 42.07809,900},
    {1701.314, 6416.028, 32.76395,1200},
    {179.8573, 6602.839, 31.86817,600},
    {-94.46199, 6419.594, 31.48952,600},
    {-2554.996, 2334.402, 33.07803,600},
    {-1800.375, 803.6619, 138.6512,600},
    {-1437.622, -276.7476, 46.20771,600},
    {-2096.243, -320.2867, 13.16857,600},
    {-724.6192, -935.1631, 19.21386,600},
    {-526.0198, -1211.003, 18.18483,600},
    {-70.21484, -1761.792, 29.53402,600},
    {265.6484,-1261.309, 29.29294,600},
    {819.6538,-1028.846, 26.40342,780},
    {1208.951,-1402.567, 35.22419,900},
    {1181.381,-330.8471, 69.31651,900},
    {620.8434, 269.1009, 103.0895,780},
    {2581.321, 362.0393, 108.4688,1500},
    {1785.363, 3330.372, 41.38188,1200},
    {-319.537, -1471.5116, 30.54118,600},
    {-66.58, -2532.56, 6.14, 400}
}

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
local showGasStations = false

RegisterNetEvent('CarPlayerHud:ToggleGas')
AddEventHandler('CarPlayerHud:ToggleGas', function()
    showGasStations = not showGasStations
   for _, item in pairs(gasStations) do
        if not showGasStations then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 361)
            SetBlipScale(item.blip, 0.7)
            SetBlipColour(item.blip, 1)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gas")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    showGasStations = true
    TriggerEvent('CarPlayerHud:ToggleGas')
end)

SetFuel = function(vehicle, fuel)

    DecorSetInt(vehicle, "CurrentFuel", fuel)
end

function GetFuel(vehicle)
	return DecorGetInt(vehicle, "CurrentFuel")
end


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end




function TargetVehicle()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end

function IsNearGasStations()
    local location = {}
    local hasFound = false
    local pos = GetEntityCoords(PlayerPedId(), false)
    for k,v in ipairs(gasStations) do
        if(Vdist(v[1], v[2], v[3], pos.x, pos.y, pos.z) < 22.0)then
            location = {v[1], v[2], v[3],v[4]}
            hasFound = true
        end
    end


    if hasFound then return location,true end
    return {},false
end


RegisterNetEvent("RefuelCar")
AddEventHandler("RefuelCar",function()
    local w = `WEAPON_PetrolCan` 
    local curw = GetSelectedPedWeapon(PlayerPedId())
    if curw == w then
        coordA = GetEntityCoords(PlayerPedId(), 1)
        coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
        if DoesEntityExist(targetVehicle) then
            SetPedAmmo( PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0 )

            if DecorExistOn(targetVehicle, "CurrentFuel") then 
                curFuel = DecorGetInt(targetVehicle, "CurrentFuel")
                
                curFuel = curFuel + 30
                if curFuel > 100 then
                    curFuel = 100
                end
                DecorSetInt(targetVehicle, "CurrentFuel", curFuel)
            else
                DecorSetInt(targetVehicle, "CurrentFuel", 50)
            end

            DecorSetInt(targetVehicle, "CurrentFuel", 100)
            TriggerEvent('DoLongHudText', 'Refueled')
        else
            TriggerEvent('DoLongHudText', 'No Target', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'Need a Gas Can', 2)
    end
end)

RegisterNetEvent("RefuelCarServerReturn")
AddEventHandler("RefuelCarServerReturn",function()


    local timer = (100 - curFuel) * 400
    refillVehicle()
    local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    local finished = exports["urp-taskbar"]:taskBar(timer,"Refueling",false,false,playerVeh)
    if (finished == 100) then
        local veh = TargetVehicle()

        DecorSetInt(veh, "CurrentFuel", 100)

        local curFuel = DecorGetInt(veh, "CurrentFuel")
        local endFuel = (100 - curFuel) 
        endFuel = math.ceil(endFuel + curFuel)
        DecorSetInt(veh, "CurrentFuel", endFuel)
    
        endanimation()
    end
end)


local petrolCan = {title = "Petrol Can", name = "PetrolCan", costs = 100, description = {}, model = "WEAPON_PetrolCan"}



function refillVehicle()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "weapon@w_sp_jerrycan" ) 
    TaskPlayAnim( PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    
end

function endanimation()
    shiftheld = false
    ctrlheld = false
    tabheld = false
    ClearPedTasksImmediately(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function TargetVehicle()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end




function round( n )
    return math.floor( n + 0.5 )
end

Fuel = 45
DrivingSet = false
LastVehicle = nil
lastupdate = 0
local fuelMulti = 0

RegisterNetEvent("carHud:FuelMulti")
AddEventHandler("carHud:FuelMulti",function(multi)
    fuelMulti = multi
end)


alarmset = false

RegisterNetEvent("CarFuelAlarm")
AddEventHandler("CarFuelAlarm",function()
    if not alarmset then
        alarmset = true
        local i = 5
        TriggerEvent("DoLongHudText", "Low fuel.",1)
        while i > 0 do
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            i = i - 1
            Citizen.Wait(300)
        end
        Citizen.Wait(60000)
        alarmset = false
    end
end)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

-- CONFIG --
local showCompass = true
-- CODE --
local compass = "Loading GPS"

local lastStreet = nil
local lastStreetName = ""
local zone = "Unknown";

function playerLocation()
    return lastStreetName
end

function playerZone()
    return zone
end

-- Thanks @marxy
function getCardinalDirectionFromHeading(heading)
    if heading >= 315 or heading < 45 then
        return "North Bound"
    elseif heading >= 45 and heading < 135 then
        return "West Bound"
    elseif heading >=135 and heading < 225 then
        return "South Bound"
    elseif heading >= 225 and heading < 315 then
        return "East Bound"
    end
end

local seatbelt = false
RegisterNetEvent("seatbelt")
AddEventHandler("seatbelt", function(belt)
    seatbelt = belt
end)

 --SEATBELT--
Citizen.CreateThread(function()
    if IsControlJustReleased(0, 348) then -- Middle Mouse
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsVehicleEngineOn(veh) then
            SetVehicleEngineOn(veh,0,0,1)
            SetVehicleUndriveable(veh,true)
            TriggerEvent('DoLongHudText', "Ignition halted", 2)
        else
            SetVehicleEngineOn(veh,1,0,1)
            SetVehicleUndriveable(veh,false)
            TriggerEvent('DoLongHudText', "Ignition started")
        end
    end
end)

 local speedBuffer  = {}
 local velBuffer    = {}
 local wasInCar     = false
 local carspeed = 0
 local speed = 0
 
 Citizen.CreateThread(function()
  Citizen.Wait(500)
   while true do
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    if not IsPedInAnyVehicle(ped, false) then
         cruiseIsOn = false
    end
    if car ~= 0 and (wasInCar or IsCar(car)) then
     wasInCar = true
 
     if seatbelt then 
         DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
         DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
     end
 
     speedBuffer[2] = speedBuffer[1]
     speedBuffer[1] = GetEntitySpeed(car)
     if speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[2] > 18.00 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[2] * 0.465) and seatbelt == false then
     local co = GetEntityCoords(ped, true)
     local fw = Fwv(ped)
     SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
     SetEntityVelocity(ped, velBuffer[2].x-10/2, velBuffer[2].y-10/2, velBuffer[2].z-10/4)
     Citizen.Wait(1)
     SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
    end
     velBuffer[2] = velBuffer[1]
     velBuffer[1] = GetEntityVelocity(car)
 
     if IsControlJustPressed(0, 29) then
       if seatbelt == false then
         seatbelt = true
         TriggerEvent('DoLongHudText', 'Seat Belt Enabled')
         TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
       else
         seatbelt = false
         TriggerEvent('DoLongHudText', 'Seat Belt Disabled')
        TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
       end
     end
     if (GetPedInVehicleSeat(car, -1) == ped) then
         -- Check if cruise control button pressed, toggle state and set maximum speed appropriately
         if IsControlJustReleased(0, Keys['M']) then
             if cruiseIsOn then
                 TriggerEvent('DoLongHudText', 'Cruise Disabled')
             else
                 TriggerEvent('DoLongHudText', 'Cruise Activated')
             end
 
             cruiseIsOn = not cruiseIsOn
             cruiseSpeed = GetEntitySpeed(car)
         end
         local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(car, "CHandlingData", "fInitialDriveMaxFlatVel")
         SetEntityMaxSpeed(car, maxSpeed)
     end
 
 
    elseif wasInCar then
     wasInCar = false
     seatbelt = false
     speedBuffer[1], speedBuffer[2] = 0.0, 0.0
    end
    Citizen.Wait(5)
    speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
   end
 end)
 
 function IsCar(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
 end
 
 function Fwv(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
 end
 
local harness = false
local harnessDur = 0
RegisterNetEvent("harness")
AddEventHandler("harness", function(belt, dur)
    harness = belt
    harnessDur = dur
end)

local nos = 0
local nosEnabled = false
RegisterNetEvent("noshud")
AddEventHandler("noshud", function(_nos, _nosEnabled)
    if _nos == nil then
        nos = 0
    else
        nos = _nos
    end
    nosEnabled = _nosEnabled
end)


RegisterNetEvent("urp-jobmanager:playerBecameJob")
AddEventHandler("urp-jobmanager:playerBecameJob", function(job, name)
    if job ~= "police" then isCop = false else isCop = true end
end)



local counter = 0
local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
local uiopen = false
local colorblind = false
local compass_on = false

RegisterNetEvent('option:colorblind')
AddEventHandler('option:colorblind',function()
    colorblind = not colorblind
end)

Citizen.CreateThread(function()
    
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    local area = GetLabelText(zone)
    playerStreetsLocation = area

    if not zone then
        zone = "UNKNOWN"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [" .. area .. "]"
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | [" .. area .. "]"
    else
        playerStreetsLocation = "[" .. area .. "]"
    end

    while true do
        Citizen.Wait(500)
        local player = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(player, true))
        local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
        local time = CalculateTimeToDisplay()
        currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
        zone = tostring(GetNameOfZone(x, y, z))
        local area = GetLabelText(zone)
        playerStreetsLocation = area

        if not zone then
            zone = "UNKNOWN"
        end

        if intersectStreetName ~= nil and intersectStreetName ~= "" then
            playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [" .. area .. "]"
        elseif currentStreetName ~= nil and currentStreetName ~= "" then
            playerStreetsLocation = currentStreetName .. " | [" .. area .. "]"
        else
            playerStreetsLocation = "[".. area .. "]"
        end
        -- compass = getCardinalDirectionFromHeading(math.floor(GetEntityHeading(player) + 0.5))
        -- street = compass .. " | " .. playerStreetsLocation
        street = playerStreetsLocation
        local veh = GetVehiclePedIsIn(player, false)
        if IsVehicleEngineOn(veh) then          

            if not uiopen then
                uiopen = true
                SendNUIMessage({
                  open = 1,
                }) 
            end

            Mph = math.ceil(GetEntitySpeed(veh) * 2.236936)
            local atl = false
            if IsPedInAnyPlane(player) or IsPedInAnyHeli(player) then
                atl = string.format("%.1f", GetEntityHeightAboveGround(veh) * 3.28084)
            end
            local engine = false
            if GetVehicleEngineHealth(veh) < 400.0 then
                engine = true
            end
            local GasTank = false
            if GetVehiclePetrolTankHealth(veh) < 3002.0 then
                GasTank = true
            end
            SendNUIMessage({
              open = 2,
              mph = Mph,
              fuel = math.ceil(Fuel),
              street = street,
              belt = seatbelt,
              harness = harness,
              harnessDur = harnessDur,
              nos = nos,
              nosEnabled = nosEnabled,
              time = time.hour .. ':' .. time.minute,
              colorblind = colorblind,
              atl = atl,
              engine = engine,
              GasTank = GasTank,
            }) 
        else

            if uiopen and not compass_on then
                SendNUIMessage({
                  open = 3,
                }) 

                uiopen = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if exports['urp-inventory']:hasEnoughOfItem('watch', 1, false) then
            compass_on = true
        else
            compass_on = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        local player = PlayerPedId()
        local time = CalculateTimeToDisplay()
        if IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) then
            -- in vehicle
            SendNUIMessage({
                open = 2,
                direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
            })
        elseif compass_on == true then
            -- has compass toggled
            if not uiopen then
                uiopen = true
                SendNUIMessage({
                  open = 1,
                })
            end

            SendNUIMessage({
                open = 4,
                time = time.hour .. ':' .. time.minute,
                direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
            })
            
        else
            Citizen.Wait(1000)
        end
    end
end)


function CalculateTimeToDisplay()
    hour = GetClockHours()
    minute = GetClockMinutes()

    local obj = {}

    if hour <= 12 then
        obj.ampm = 'AM'
    elseif hour >= 13 then
        obj.ampm = 'PM'
        hour = hour - 12
    end

    if minute <= 9 then
        minute = "0" .. minute
    end

    obj.hour = hour
    obj.minute = minute

    return obj
end

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(250)
        local player = PlayerPedId()

        if (IsPedInAnyVehicle(player, false)) then

            local veh = GetVehiclePedIsIn(player,false)

            if GetPedInVehicleSeat(veh, -1) == player then

                if not DrivingSet then


                    if LastVehicle ~= veh then
                        if not DecorExistOn(veh, "CurrentFuel") then
                            Fuel = math.random(80,100)
                        else
                            Fuel = DecorGetInt(veh, "CurrentFuel")
                        end
                    else
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end

                    DrivingSet = true
                    LastVehicle = veh
                    lastupdate = 0

                    if not DecorExistOn(veh, "CurrentFuel") then 
                        Fuel = math.random(80,100)
                        DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    end

                else

                    if Fuel > 105 then
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end                     
                    if Fuel == 101 then
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end

                end

                if ( lastupdate > 300) then
                    DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    lasteupdate = 0
                end

                lastupdate = lastupdate + 1

                if Fuel > 0 then
                    if IsVehicleEngineOn(veh) then
                        local fueltankhealth = GetVehiclePetrolTankHealth(veh)
                        if fueltankhealth == 1000.0 then
                            SetVehiclePetrolTankHealth(veh, 4000.0)
                        end
                        local algofuel = GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6
                        if algofuel > 160 then
                            algofuel = algofuel * 1.8
                        else
                            algofuel = algofuel / 2.0
                        end
                        algofuel = algofuel / 15000

                        if algofuel == 0 then
                            algofuel = 0.0001
                        end

                        --TriggerEvent('chatMessage', '', { 0, 0, 0 }, '' .. algofuel .. '')
                        if IsPedInAnyBoat(PlayerPedId()) then
                            algofuel = 0.0090
                        end
                        if fuelMulti == 0 then fuelMulti = 1 end
                        local missingTankHealth = (4000 - fueltankhealth) / 1000

                        if missingTankHealth > 1 then
                            missingTankHealth = missingTankHealth * (missingTankHealth * missingTankHealth * 12)
                        end

                        local factorFuel = (algofuel + fuelMulti / 10000) * (missingTankHealth+1)
                        Fuel = Fuel - factorFuel
                        
                    end
                end



                if Fuel <= 4 and Fuel > 0 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        local decayChance = math.random(20,100)
                        if decayChance > 90 then
                            SetVehicleEngineOn(veh,0,0,1)
                            SetVehicleUndriveable(veh,true)
                            Citizen.Wait(100)
                            SetVehicleEngineOn(veh,1,0,1)
                            SetVehicleUndriveable(veh,false)
                        end
                    end
                     
                end

                if Fuel < 15 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        TriggerEvent("CarFuelAlarm")
                    end
                end

                if Fuel < 1 then

                    if Fuel ~= 0 then
                        Fuel = 0
                        DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    end

                    if IsVehicleEngineOn(veh) or IsThisModelAHeli(GetEntityModel(veh)) then
                        SetVehicleEngineOn(veh,0,0,1)
                        SetVehicleUndriveable(veh,false)
                    end

                end

            end

        else

            if DrivingSet then
                DrivingSet = false
                DecorSetInt(LastVehicle, "CurrentFuel", round(Fuel))
            end
            Citizen.Wait(1500)
        end
    end

end)

Controlkey = {["generalUse"] = {38,"E"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalUse"] = table["generalUse"]
end)



Citizen.CreateThread(function()
    local bool = false
    local counter = 0
    while true do

        if counter == 0 then
            loc,bool = IsNearGasStations()
            counter = 5
        end
        counter = counter - 1
        if bool == true then

            local veh = TargetVehicle()

            if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then

                curFuel = DecorGetInt(veh, "CurrentFuel")
                costs = (100 - curFuel)
                if costs < 0 then
                    costs = 0
                end
                info = string.format("Press ~g~E~s~ to refuel your vehicle | ~g~$%s + tax", costs)
                local crd = GetEntityCoords(veh)
                DrawMarker(2,crd["x"],crd["y"],crd["z"]+1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 15, 15, 130, 0, 0, 0, 0)
                DisplayHelpText(info)
                if IsControlJustPressed(1, 38) then
                    local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
                    local Player = LocalPlayer:getCurrentCharacter()
                    costs = math.ceil(costs)
                    if curFuel >= 100 then
                        PlaySound(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
                        TriggerEvent('DoLongHudText', "You are already full!", 2) 
                    elseif Player.cash > costs then
                        TriggerEvent("RefuelCarServerReturn")
                        LocalPlayer:removeCash(Player.id, costs)
                    else
                        TriggerEvent('DoLongHudText', 'Not enough money', 2)
                    end
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(500)
        end

    end
end)




---------------------------------
-- Compass shit
---------------------------------

--[[
    Heavy Math Calcs
 ]]--

 local imageWidth = 100 -- leave this variable, related to pixel size of the directions
 local containerWidth = 100 -- width of the image container
 
 -- local width =  (imageWidth / containerWidth) * 100; -- used to convert image width if changed
 local width =  0;
 local south = (-imageWidth) + width
 local west = (-imageWidth * 2) + width
 local north = (-imageWidth * 3) + width
 local east = (-imageWidth * 4) + width
 local south2 = (-imageWidth * 5) + width
 
 function calcHeading(direction)
     if (direction < 90) then
         return lerp(north, east, direction / 90)
     elseif (direction < 180) then
         return lerp(east, south2, rangePercent(90, 180, direction))
     elseif (direction < 270) then
         return lerp(south, west, rangePercent(180, 270, direction))
     elseif (direction <= 360) then
         return lerp(west, north, rangePercent(270, 360, direction))
     end
 end
 
 
 function rangePercent(min, max, amt)
     return (((amt - min) * 100) / (max - min)) / 100
 end
 
 function lerp(min, max, amt)
     return (1 - amt) * min + amt * max
 end