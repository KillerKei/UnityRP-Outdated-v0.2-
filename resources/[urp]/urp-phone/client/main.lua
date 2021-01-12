local guiEnabled = false
local hasOpened = false
local lstMsgs = {}
local lstContacts = {}
local inPhone = false
local radioChannel = math.random(1,999)
local usedFingers = false
local dead = false
local onhold = false
local YellowPageArray = {}
local YellowPages = {}
local PhoneBooth = GetEntityCoords(PlayerPedId())
local AnonCall = true
local phoneNotifications = true
local insideDelivers = false
local curhrs = 9
local curmins = 2
local allowpopups = true
local vehicles = {}
local isDead = false
local isNotInCall, isDialing, isReceivingCall, isCallInProgress = 0, 1, 2, 3
local callStatus = isNotInCall

RegisterNUICallback('btnNotifyToggle', function(data, cb)
    allowpopups = not allowpopups
    if allowpopups then
      TriggerEvent("DoLongHudText","Popups Enabled", 1)
    else
      TriggerEvent("DoLongHudText","Popups Disabled", 2)
    end
end)

activeNumbersClient = {}

RegisterNetEvent('phone:reset')
AddEventHandler('phone:reset', function(cidsent)
  if guiEnabled then
    closeGui2()
  end
  guiEnabled = false
  hasOpened = false
  lstMsgs = {}
  lstContacts = {}
  vehicles = {}
  radioChannel = math.random(1,999)
  dead = false
  onhold = false
  inPhone = false
end)

RegisterNetEvent('Yougotpaid')
AddEventHandler('Yougotpaid', function(cidsent)
    if tonumber(cid) == tonumber(cidsent) then
      TriggerEvent("DoLongHudText","Life Invader Payslip Generated.", 1)
    end
end)
           
RegisterNetEvent('Payment:Successful')
AddEventHandler('Payment:Successful', function()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Payment Processed.",
    })     
end)

RegisterNetEvent('warrants:AddInfo')
AddEventHandler('warrants:AddInfo', function(name, charges)

    openGuiNow()

    SendNUIMessage({
      openSection = "enableoutstanding",
    })
    for i = 1, #charges do

      SendNUIMessage({
        openSection = "inputoutstanding",
        textmessage = charges[i],
      })
    end
    
end)

RegisterNetEvent("phone:activeNumbers")
AddEventHandler("phone:activeNumbers", function(activePhoneNumbers)
  activeNumbersClient = activePhoneNumbers
  hasOpened = false
end)



RegisterNetEvent("gangTasks:updateClients")
AddEventHandler("gangTasks:updateClients", function(newTasks)
  activeTasks = newTasks
end)

TaskState = {
  [1] = "Ready For Pickup",
  [2] = "In Process",
  [3] = "Successful",
  [4] = "Failed",
  [5] = "Delivered with Damaged Goods",
}

TaskTitle = {
  [1] = "Ordering 'Take-Out'",
  [2] = "Ordering 'Disposal Service'",
  [3] = "Ordering 'Postal Delivery'",
  [4] = "Ordering 'Hot Food Room Service'",
}

function findTaskIdFromBlockChain(blockchain)
  local retnum = 1
  for i = 1, #activeTasks do
    if activeTasks[i]["BlockChain"] == blockchain then
      retnum = i
    end
  end
  return retnum
end

-- real estate nui app responses

function loading()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })  
end

RegisterNetEvent("phone:setServerTime")
AddEventHandler("phone:setServerTime", function(time)
  SendNUIMessage({
    openSection = "server-time",
    serverTime = time
  })
end)

RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(hrs,mins)

  curhrs = hrs
  curmins = mins

  local timesent = curhrs .. ":" .. curmins
  if guiEnabled then
    SendNUIMessage({
      openSection = "timeheader",
      timestamp = timesent,
    })   
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)
    if guiEnabled then
      CalculateTimeToDisplay()
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

  TriggerEvent('timeheader', hour, minute)

  return obj
end
RegisterNUICallback('btnGiveKey', function(data, cb)
  TriggerEvent("houses:GiveKey")
end)
RegisterNetEvent("returnPlayerKeys")
AddEventHandler("returnPlayerKeys", function(ownedkeys,sharedkeys)
  
      if not guiEnabled then
        return
      end

      SendNUIMessage({
        openSection = "keys",
        keys = {
          sharedKeys = sharedkeys,
          ownedKeys = ownedkeys
        }
      })
end)

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

local selfieMode = false
RegisterNUICallback('phone:selfie', function()
  selfieMode = not selfieMode
  if selfieMode then
    closeGui()
    DestroyMobilePhone()
    CreateMobilePhone(4)
    CellCamActivate(true, true)
    CellFrontCamActivate(true)
  else
    closeGui()
    CellCamActivate(false, false)
    CellFrontCamActivate(false)
    DestroyMobilePhone()
    selfieMode = false
  end
end)

RegisterNUICallback('trackTaskLocation', function(data, cb)
    local taskID = findTaskIdFromBlockChain(data.TaskIdentifier)
    TriggerEvent("DoLongHudText","Location Set", 1)

    SetNewWaypoint(activeTasks[taskID]["Location"]["x"],activeTasks[taskID]["Location"]["y"])
end)

function GroupRank(groupid)
  local rank = 0
  for i=1, #mypasses do
    if mypasses[i]["pass_type"] == groupid then
      rank = mypasses[i]["rank"]
    end 
  end
  return rank
end

RegisterNUICallback('bankGroup', function(data)
    local gangid = data.gangid
    local cashamount = data.cashamount

    local lPlayer = exports['urp-base']:getModule('LocalPlayer')
    local pBank = lPlayer:getCurrentCharacter().bank
    local pId = lPlayer:getCurrentCharacter().id

    if tonumber(cashamount) > tonumber(pBank) then
      TriggerEvent('DoLongHudText', 'You cannot afford to append this much.', 2)
    else
      TriggerServerEvent("server:gankGroup", gangid, cashamount, pId)
    end
    
end)

RegisterNUICallback('payGroup', function(data)
    local gangid = data.gangid
    local cid = data.cid
    local cashamount = data.cashamount

    TriggerServerEvent("server:givepayGroup", gangid, cashamount, cid)
end)

RegisterNUICallback('promoteGroup', function(data)
    local gangid = data.gangid
    local cid = data.cid
    local newrank = data.newrank
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })
    TriggerServerEvent("server:givepass", gangid,newrank,cid)
end)


RegisterNUICallback('callNumber', function(data)
    closeGui()
    local number = data.callnum
    local callTo = getContactName(number)
    TriggerServerEvent("phone:callContact", exports['isPed']:isPed('cid'), number,true)
    recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = number, ["name"] = callTo }
end)

function GroupRank(gId)
  local text = 'Failed to gather data.'
  local groups = exports['isPed']:isPed('business')

  for i=1, #groups do
    if groups[i]['id'] == gId then
      text = groups[i]['rank']
    end
  end 

  return text
end

RegisterNUICallback('manageGroup', function(data)
    local groupid = data.GroupID

    print(groupid)

    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    local jRank = LocalPlayer:getRank()

    if tonumber(jRank) < 4 then
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end

    SendNUIMessage({
      openSection = "error",
      textmessage = "Loading, please wait.",
    })

    TriggerServerEvent("group:pullinformation", groupid)
end)

RegisterNetEvent('duty:police')
AddEventHandler('duty:police', function()
  TriggerServerEvent('duty:police')
end)
RegisterNetEvent('duty:ambulance')
AddEventHandler('duty:ambulance', function()
  TriggerServerEvent('duty:ambulance')
end)

RegisterNetEvent("phone:error")
AddEventHandler("phone:error", function()
      SendNUIMessage({
        openSection = "error",
        textmessage = "<b>Network Error</b> <br><br> Please contact support if this error persists, thank you for using URP Phone Services.",
      })   
end)

RegisterNUICallback('btnProperty', function(data, cb)
  loading()
  local realEstateRank = exports['isPed']:isPed('job')
  if realEstateRank == "RealEstate" then
    SendNUIMessage({
        openSection = "RealEstate",
        RERank = realEstateRank
    })        
  end
end)

RegisterNUICallback('btnProperty2', function(data, cb)
  loading()
  TriggerServerEvent("ReturnHouseKeys", exports['isPed']:isPed('cid'))
end)

RegisterNUICallback('retrieveHouseKeys', function(data, cb)
  TriggerEvent("houses:retrieveHouseKeys")
  cb('ok')
end)

RegisterNUICallback('btnFurniture', function(data, cb)
  closeGui()
  TriggerEvent("DoLongHudText", "Coming soon.", 2)
  --TriggerEvent("openFurniture")
end)

RegisterNUICallback('btnPropertyModify', function(data, cb)
TriggerEvent("housing:info:realtor","modify")
end)

RegisterNUICallback('removeHouseKey', function(data, cb)
  TriggerEvent("houses:removeHouseKey", data.targetId)
  cb('ok')
end)

RegisterNUICallback('btnPropertyReset', function(data, cb)
TriggerEvent("housing:info:realtor","reset")
end)

RegisterNUICallback('btnPropertyClothing', function(data, cb)
TriggerEvent("housing:info:realtor","setclothing")
end)

RegisterNUICallback('btnPropertyStorage', function(data, cb)
TriggerEvent("housing:info:realtor","setstorage")
end)

RegisterNUICallback('btnPropertySetGarage', function(data, cb)
TriggerEvent("housing:info:realtor","setgarage")
end)

RegisterNUICallback('btnPropertyWipeGarages', function(data, cb)
TriggerEvent("housing:info:realtor","wipegarages")
end)

RegisterNUICallback('btnPropertySetBackdoorInside', function(data, cb)
TriggerEvent("housing:info:realtor","backdoorinside")
end)

RegisterNUICallback('btnPropertySetBackdoorOutside', function(data, cb)
TriggerEvent("housing:info:realtor","backdooroutside")
end)

RegisterNUICallback('btnPropertyUpdateHouse', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnRemoveSharedKey', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnPropertyUnlock', function(data, cb)
TriggerEvent("housing:info:realtor","unlock")
end)

RegisterNUICallback('btnPropertyHouseCreationPoint', function(data, cb)
TriggerEvent("housing:info:realtor","creationpoint")
end)
RegisterNUICallback('btnPropertyStopHouse', function(data, cb)
TriggerEvent("housing:info:realtor","stop")
end)
RegisterNUICallback('btnAttemptHouseSale', function(data, cb)
TriggerEvent("housing:sendPurchaseAttempt",data.cid,data.price)
end)
RegisterNUICallback('btnTransferHouse', function(data, cb)
TriggerEvent("housing:transferHouseAttempt", data.cid)
end)
RegisterNUICallback('btnEvictHouse', function(data, cb)
TriggerEvent("housing:evictHouseAttempt")
end)

-- real estate nui app responses end
function GroupName(gId)
  local text = 'Failed to gather data.'
  local groups = exports['isPed']:isPed('business')

  for i=1, #groups do
    if groups[i]['id'] == gId then
      text = groups[i]['name']
    end
  end 

  return text
end

RegisterNetEvent("group:fullList")
AddEventHandler("group:fullList", function(result, bank, groupid)

    local jName = exports['isPed']:isPed('job')


    SendNUIMessage({
      openSection = "groupManage",
      groupData = {
        groupName = jName,
        bank = bank,
        groupId = groupid,
        employees = result
      }
    })

end)

local recentcalls = {}

RegisterNUICallback('getCallHistory', function()
  SendNUIMessage({
    openSection = "callHistory",
    callHistory = recentcalls
  })
end)


RegisterNUICallback('btnTaskGroups', function()
    local jobs = exports['urp-base']:GetRanks()
    local pJob = exports['isPed']:isPed('job') 
    local groupObject = {}

    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    local jRank = LocalPlayer:getRank()
    local jId = 0

    for k, v in ipairs(jobs) do
      if v.name == pJob then jId = k end
    end
    if pJob == "None" then
      pJob = "Unemployed"
      jRank = ""
    end


    table.insert(groupObject, {
      namesent = pJob,
      ranksent = jRank,
      idsent = jId
    })

    SendNUIMessage({
      openSection = "groups",
      groups = groupObject
    })

end)






RegisterNUICallback('btnTaskGang', function()
  TriggerEvent("gangTasks:updated")
end)



local pcs = {
  [1] = 1333557690,
  [2] = -1524180747, 
}


function IsNearPC()
  for i = 1, #pcs do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 0.75, pcs[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
      return true
    end
  end

  if #(GetEntityCoords(PlayerPedId()) - vector3(1272.27, -1711.91, 54.78)) < 1.0 then
    SetEntityHeading(PlayerPedId(),14.0)
    return true
  end
  if #(GetEntityCoords(PlayerPedId()) - vector3(1275.4, -1710.52, 54.78)) < 5.0 then
    SetEntityHeading(PlayerPedId(),300.0)
    return true
  end


  return false
end

RegisterNetEvent("open:deepweb")
AddEventHandler("open:deepweb", function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
  guiEnabled = true
  SendNUIMessage({
    openSection = "deepweb" 
  })
end)

RegisterNetEvent("gangTasks:updated")
AddEventHandler("gangTasks:updated", function()
  local taskObject = {}
  for i = 1, #activeTasks do

    if activeTasks[i]["Gang"] ~= 0 and gang ~= 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then
      if gang == activeTasks[i]["Gang"] then
        taskObject[#taskObject + 1 ] = {
          name = TaskTitle[activeTasks[i]["TaskType"]],
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 0,
        }
      end
    elseif activeTasks[i]["Gang"] == 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then

      for z = 1, #passes do

        local passType = activeTasks[i]["Group"]
        if passes[z].pass_type == passType and (passes[z].rank == 2 or passes[z].rank > 3) then
          taskObject[#taskObject + 1 ] = {
            name = activeTasks[i]["TaskNameGroup"],
            assignedTo = activeTasks[i]["taskOwnerCid"],
            status = TaskState[activeTasks[i]["TaskState"]],
            identifier = activeTasks[i]["BlockChain"],
            groupId = passType,
            retrace = 0,
          }
        end

      end

    else
      if tonumber(activeTasks[i]["taskOwnerCid"]) == cid then

        local TaskName = ""
        if activeTasks[i]["Gang"] == 0 then
          TaskName = activeTasks[i]["TaskNameGroup"]
        else
          TaskName = TaskTitle[activeTasks[i]["TaskType"]]
        end
        taskObject[#taskObject + 1 ] = {
          name = TaskName,
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 1
        }
      end
    end
  end

  SendNUIMessage({
    openSection = "addTasks",
    tasks = taskObject
  })
end)

RegisterNetEvent("purchasePhone")
AddEventHandler("purchasePhone", function()
  TriggerServerEvent("purchasePhone")
end)

RegisterNUICallback('btnMute', function()
  if phoneNotifications then
    TriggerEvent("DoLongHudText","Notifications Disabled.", 2)
  else
    TriggerEvent("DoLongHudText","Notifications Enabled.", 1)
  end
  phoneNotifications = not phoneNotifications
end)

RegisterNetEvent("tryTweet")
AddEventHandler("tryTweet", function(tweetinfo,message,user)
  if hasPhone() then
    TriggerServerEvent("AllowTweet",tweetinfo,message)
  end
end)

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)



RegisterNUICallback('btnGarage', function()
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  TriggerServerEvent("garages:CheckGarageForVeh", Player.id)
end)

RegisterNUICallback('btnHelp', function()
  closeGui()
  TriggerEvent("openWiki")
end)

RegisterNUICallback('carpaymentsowed', function()
  TriggerEvent("car:carpaymentsowed")
end)

-- RegisterNUICallback('vehspawn', function(data)
--   findVehFromPlateAndSpawn(data.vehplate)
-- end)

RegisterNUICallback('vehtrack', function(data)
  findVehFromPlateAndLocate(data.vehplate)
end)

RegisterNUICallback('vehiclePay', function(data)
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  if data.amount then 
    if Player.bank >= math.ceil(data.amount/8) then 
      LocalPlayer:removeBank(Player.id, math.ceil(data.amount/8))
      TriggerEvent("DoLongHudText", "You payed $"..(math.ceil(data.amount/8)).." towards this vehicles loan.")
      TriggerServerEvent('phone:RemoveFromRepoList', data.vehiclePlate)
      return 
    else 
      TriggerEvent("DoLongHudText", "You don't have enough money.", 2)
      return
    end
  end
end)

function findVehFromPlateAndLocate(plate)

  for ind, value in pairs(chicken) do

    vehPlate = value.plate
  if vehPlate == plate then
    coordlocation = value.coords
    SetNewWaypoint(coordlocation[1], coordlocation[2])

  end
  end
end

function Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end


local recentspawnrequest = false
function findVehFromPlateAndSpawn(plate)

  if IsPedInAnyVehicle(PlayerPedId(), false) then
    return
  end

  for ind, value in pairs(vehicles) do

    vehPlate = value.license_plate
    if vehPlate == plate then
      state = value.vehicle_state
      coordlocation = value.coords

      if #(vector3(coordlocation[1],coordlocation[2],coordlocation[3]) - GetEntityCoords(PlayerPedId())) < 10.0 and state == "Out" then

        local DoesVehExistInProximity = CheckExistenceOfVehWithPlate(vehPlate)

        if not DoesVehExistInProximity and not recentspawnrequest then
          recentspawnrequest = true
          TriggerServerEvent("garages:phonespawn",vehPlate)
          Wait(10000)
          recentspawnrequest = false
        else
          print("Found vehicle already existing!")
        end

      end

    end

  end

end

RegisterNetEvent("phone:SpawnVehicle")
AddEventHandler('phone:SpawnVehicle', function(vehicle, plate, customized, state, Fuel, coordlocation)
  TriggerEvent("garages:SpawnVehicle", vehicle, plate, customized, state, Fuel, coordlocation)
end)



Citizen.CreateThread(function()
    local invehicle = false
    local plateupdate = "None"
    local vehobj = 0
    while true do
        Wait(1000)
        if not invehicle and IsPedInAnyVehicle(PlayerPedId(), false) then
          local playerPed = PlayerPedId()
          local veh = GetVehiclePedIsIn(playerPed, false)
            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
              vehobj = veh
              local checkplate = GetVehicleNumberPlateText(veh)
              invehicle = true
              plateupdate = checkplate
              local coords = GetEntityCoords(vehobj)
              coords = { coords["x"], coords["y"], coords["z"] }
              TriggerServerEvent("vehicle:coords",plateupdate,coords)
            end
        end
        if invehicle and not IsPedInAnyVehicle(PlayerPedId(), false) then
          local coords = GetEntityCoords(vehobj)
          coords = { coords["x"], coords["y"], coords["z"] }
          TriggerServerEvent("vehicle:coords",plateupdate,coords)
          invehicle = false
          plateupdate = "None"
          vehobj = 0
        end  
    end
end)


function CheckExistenceOfVehWithPlate(platesent)
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, scannedveh = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(scannedveh)
        local distance = #(playerCoords - pos)
          if distance < 50.0 then
            local checkplate = GetVehicleNumberPlateText(scannedveh)
            if checkplate == platesent then
              return true
            end
          end
        success, scannedveh = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return false
end

local currentVehicles = {}

RegisterNetEvent("phone:Garage")
AddEventHandler("phone:Garage", function(vehs)
  vehicles = vehs
  local showCarPayments = false

  local parsedVehicleData = {}
  for ind, value in pairs(vehs) do
    enginePercent = round(value.vehicle.engineHealth) / 10
    bodyPercent = round(value.vehicle.bodyHealth) / 10
    vehName = GetDisplayNameFromVehicleModel(value.vehicle.model)
    vehPlate = value.plate
    currentGarage = value.garage
    state = value.state

    table.insert(parsedVehicleData, {
      name = vehName,
      plate = vehPlate,
      garage = currentGarage,
      state = state,
      enginePercent = enginePercent,
      bodyPercent = bodyPercent,
      lastPayment = value.last_payment,
      amountDue = value.amount_due,
      canSpawn = false
    })
  end
  
  SendNUIMessage({ openSection = "Garage", showCarPaymentsOwed = showCarPayments, vehicleData = parsedVehicleData})
end)

function round(n)
  if not n then return 0; end
  return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end


local pickuppoints = {
  [1] =  { ['x'] = 923.94,['y'] = -3037.88,['z'] = 5.91,['h'] = 270.81, ['info'] = ' Shipping Container BMZU 822693' },
  [2] =  { ['x'] = 938.02,['y'] = -3026.28,['z'] = 5.91,['h'] = 265.85, ['info'] = ' Shipping Container BMZU 822693' },
  [3] =  { ['x'] = 1006.17,['y'] = -3028.94,['z'] = 5.91,['h'] = 269.31, ['info'] = ' Shipping Container BMZU 822693' },
  [4] =  { ['x'] = 1020.42,['y'] = -3044.91,['z'] = 5.91,['h'] = 87.37, ['info'] = ' Shipping Container BMZU 822693' },
  [5] =  { ['x'] = 1051.75,['y'] = -3045.09,['z'] = 5.91,['h'] = 268.37, ['info'] = ' Shipping Container BMZU 822693' },
  [6] =  { ['x'] = 1134.92,['y'] = -2992.22,['z'] = 5.91,['h'] = 87.9, ['info'] = ' Shipping Container BMZU 822693' },
  [7] =  { ['x'] = 1149.1,['y'] = -2976.06,['z'] = 5.91,['h'] = 93.23, ['info'] = ' Shipping Container BMZU 822693' },
  [8] =  { ['x'] = 1121.58,['y'] = -3042.39,['z'] = 5.91,['h'] = 88.49, ['info'] = ' Shipping Container BMZU 822693' },
  [9] =  { ['x'] = 830.58,['y'] = -3090.46,['z'] = 5.91,['h'] = 91.15, ['info'] = ' Shipping Container BMZU 822693' },
  [10] =  { ['x'] = 830.81,['y'] = -3082.63,['z'] = 5.91,['h'] = 271.61, ['info'] = ' Shipping Container BMZU 822693' },
  [11] =  { ['x'] = 909.91,['y'] = -2976.51,['z'] = 5.91,['h'] = 271.02, ['info'] = ' Shipping Container BMZU 822693' },
}


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
blip = 0

function CreateBlip(location)
    DeleteBlip()
    blip = AddBlipForCoord(location["x"],location["y"],location["z"])
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pick Up")
    EndTextCommandSetBlipName(blip)
end
function DeleteBlip()
  if DoesBlipExist(blip) then
    RemoveBlip(blip)
  end
end

function refreshmail()
    lstnotifications = {}
    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }
        lstnotifications[#lstnotifications+1]= message2
    end
    SendNUIMessage({openSection = "notifications", list = lstnotifications})
end


function rundropoff(boxcount,costs)
  local success = true
  local timer = 600000
  TriggerEvent("chatMessage", "EMAIL ", 8, "Yo, here are the coords for the drop off, you have 10 minutes - leave $" .. costs .. " in cash there!")
  refreshmail()
  local location = pickuppoints[math.random(#pickuppoints)]
  CreateBlip(location)
  while timer > 0 do
    Citizen.Wait(1000)
    local plycoords = GetEntityCoords(PlayerPedId())
    local dstcheck = #(plycoords - vector3(location["x"],location["y"],location["z"])) 
    if dstcheck < 5.0 then
      DrawText3Ds(location["x"],location["y"],location["z"], "Press E to pickup the dropoff.")
       if dstcheck < 3.0 and IsControlJustReleased(0,38) then
          success = true
          timer = 0
       end
    end
    timer = timer - 1
    if timer == 1 then
      success = false
    end
  end
  if success then
    TriggerServerEvent("weed:phone:buybox",boxcount,costs)
  end
  DeleteBlip()
end


-- turn this to false to re-enable weed purchases.
local waiting = false
RegisterNUICallback('btnBox1', function()
  if waiting then
    return
  end
  waiting = true
  
  Citizen.Wait(math.random(100000))
  rundropoff(1,1500)
  waiting = false
end)

RegisterNUICallback('btnBox2', function()
  if waiting then
    return
  end
  waiting = true
  
  Citizen.Wait(math.random(100000))
  rundropoff(5,4500)
  waiting = false
end)

RegisterNUICallback('btnBox3', function()
  if waiting then
    return
  end
  waiting = true
  
  Citizen.Wait(math.random(100000))
  rundropoff(10,8500)
  waiting = false
end)


RegisterNUICallback('btnBox6', function()
  closeGui()
  TriggerEvent("hacking:attemptHackCrypto","weapon")
end)

RegisterNUICallback('btnBox5', function()
  closeGui()
  TriggerEvent("hacking:attemptHackCrypto","crack")
end)

RegisterNUICallback('btnBox4', function()
  closeGui()
  TriggerEvent("hacking:attemptHackCrypto","bigweapon")
end)

local weaponList = {
  [1] = 324215364,
  [2] = 736523883,
  [3] = 4024951519,
  [4] = 1627465347,
}

local weaponListSmall = {
  [1] = 2017895192,
  [2] = 584646201,
  [3] = 3218215474,
}

local luckList = {
  [1] =  "extended_ap",
  [2] =  "extended_sns",
  [3] =  "extended_micro",
  [4] =  "rifleammo",
  [5] =  "heavyammo",
  [6] =  "lmgammo",
}

RegisterNetEvent("stocks:timedEvent")
AddEventHandler("stocks:timedEvent", function(typeSent)
  local success = true
  local timer = 600000
  TriggerEvent("chatMessage", "EMAIL ", 8, "Yo, here are the coords for the drop off, you have 10 minutes - I already zoinked your Pixerium Credits")
  refreshmail()
  local location = pickuppoints[math.random(#pickuppoints)]
  CreateBlip(location)
  while timer > 0 do
    Citizen.Wait(1)
    local plycoords = GetEntityCoords(PlayerPedId())
    local dstcheck = #(plycoords - vector3(location["x"],location["y"],location["z"])) 
    if dstcheck < 5.0 then
      DrawText3Ds(location["x"],location["y"],location["z"], "Press E to pickup the dropoff.")
       if dstcheck < 3.0 and IsControlJustReleased(0,38) then
          success = true
          timer = 0
       end
    end
    timer = timer - 1
    if timer == 1 then
      success = false
    end
  end

  if success then

    if math.random(1000) == 69 then
      TriggerEvent("player:receiveItem", "741814745", 1)
    end

    if math.random(10) == 1 then
      TriggerEvent("player:receiveItem", ""..luckList[math.random(6)].."", 1)
    end


    if typeSent == "bigweapon" then
      TriggerEvent("player:receiveItem", ""..weaponList[math.random(4)].."", 1)
    end

    if typeSent == "weapon" then
      TriggerEvent("player:receiveItem", ""..weaponListSmall[math.random(3)].."", 1)
    end

  end

  DeleteBlip()
 
end)


function buyItem(typeSent)
  local success = true
  local timer = 600000
  TriggerEvent("chatMessage", "EMAIL ", 8, "Yo, here are the coords for the drop off, you have 10 minutes - it will cost " .. costs .. " Pixerium")
  refreshmail()
  local location = pickuppoints[math.random(#pickuppoints)]
  CreateBlip(location)
  while timer > 0 do
    Citizen.Wait(1)
    local plycoords = GetEntityCoords(PlayerPedId())
    local dstcheck = #(plycoords - vector3(location["x"],location["y"],location["z"])) 
    if dstcheck < 5.0 then
      DrawText3Ds(location["x"],location["y"],location["z"], "Press E to pickup the dropoff.")
       if dstcheck < 3.0 and IsControlJustReleased(0,38) then
          success = true
          timer = 0
       end
    end
    timer = timer - 1
    if timer == 1 then
      success = false
    end
  end
  if success then
    TriggerEvent("crypto:buybox",typeSent,costs)
  end
  DeleteBlip()
end


RegisterNUICallback('btnDelivery', function()
  TriggerEvent("trucker:confirmation")
end)

RegisterNUICallback('btnPackages', function()
  insideDelivers = true
  TriggerEvent("Trucker:GetPackages")
end)

RegisterNUICallback('btnTrucker', function()
  TriggerEvent("Trucker:GetJobs")
end)

RegisterNUICallback('resetPackages', function()
  insideDelivers = false
end)


RegisterNetEvent("phone:trucker")
AddEventHandler("phone:trucker", function(jobList)

  local deliveryObjects = {}
  for i, v in pairs(jobList) do
    local nameTag = ""
    local itemTag
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(v.pickup[1], v.pickup[2], v.pickup[3], currentStreetHash, intersectStreetHash)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)

    local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
    local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
    local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)
    if v.active == 0 then
        table.insert(deliveryObjects, {
          targetStreet = currentStreetName2,
          jobId = v.id,
          jobType = v.JobType
        })
    end
  end 
  SendNUIMessage({
    openSection = "deliveryJob",
    deliveries = deliveryObjects
  })
    
end)

local requestHolder = 0

RegisterNetEvent("phone:packages")
AddEventHandler("phone:packages", function(packages)
  while insideDelivers do
    if requestHolder ~= 0 then
      SendNUIMessage({
        openSection = "packagesWith"
      })
    else
      SendNUIMessage({
        openSection = "packages"
      })
    end
    
    
    for i, v in pairs(packages) do
      if GetPlayerServerId(PlayerId()) == v.source then
        local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
        local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
        local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)

        SendNUIMessage({openSection = "addPackages", street2 = currentStreetName2, jobId = v.id ,distance = getDriverDistance(v.driver , v.drop)})
      end
    end 
    Wait(4000)
  end
end)


RegisterNetEvent("phone:OwnerRequest")
AddEventHandler("phone:OwnerRequest", function(holder)
  requestHolder = holder
end)

RegisterNUICallback('btnRequest', function()
  TriggerServerEvent("trucker:confirmRequest",requestHolder)
  requestHolder = 0
end)




function getDriverDistance(driver , drop)
  local dist = 0

  local ped = GetPlayerPed(value)
  if driver ~= 0 then
    local current = #(vector3(drop[1],drop[2],drop[3]) - GetEntityCoords(ped))
    if current < 15 then
      dist = "Driver at store"
    else
      dist = current
      dist = math.ceil(dist)
    end
    
  else
    dist = "Waiting for driver"
  end

  return dist
end

RegisterNUICallback('selectedJob', function(data, cb)
    TriggerEvent("Trucker:SelectJob",data)
end)

gurgleList = {}
RegisterNetEvent('websites:updateClient')
AddEventHandler('websites:updateClient', function(passedList)
  gurgleList = passedList

  local gurgleObjects = {}

  if not guiEnabled then
    return
  end

  for i = 1, #gurgleList do
    table.insert(gurgleObjects, {
      webTitle = gurgleList[i]["Title"], 
      webKeywords = gurgleList[i]["Keywords"], 
      webDescription = gurgleList[i]["Description"] 
    })
  end

  SendNUIMessage({ openSection = "gurgleEntries", gurgleData = gurgleObjects})
end)

function hasPhone()
  return true
end


function DrawRadioChatter(x,y,z, text,opacity)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if opacity > 215 then
      opacity = 215
    end
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, opacity)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
local activeMessages = 0

RegisterNetEvent('radiotalkcheck')
AddEventHandler('radiotalkcheck', function(args,senderid)

  if hasRadio() and radioChannel ~= 0 then
    randomStatic(true)

    local ped = GetPlayerPed( -1 )

      if ( DoesEntityExist( ped ) and not IsEntityDead( ped )) then

        loadAnimDict( "random@arrests" )

        TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )

        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
      end


    TriggerServerEvent("radiotalkconfirmed",args,senderid,radioChannel)
    Citizen.Wait(2500)
    ClearPedSecondaryTask(PlayerPedId())
  end

end)




function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function randomStatic(loud)
  local vol = 0.05
  if loud then
    vol = 0.9
  end
  local pickS = math.random(4)
  if pickS == 4 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic1",vol)
  elseif pickS == 3 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic2",vol)
  elseif pickS == 2 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic3",vol)
  else
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",vol)
  end

end

RegisterNetEvent('radiotalk')
AddEventHandler('radiotalk', function(args,senderid,channel)

    local senderid = tonumber(senderid)

    table.remove(args,1)
    local radioMessage = ""
    for i = 1, #args do
        radioMessage = radioMessage .. " " .. args[i]
    end

    if channel == radioChannel and hasRadio() and radioMessage ~= nil then
      -- play radio click sound locally.
      TriggerEvent('chatMessage', "RADIO #" .. channel, 3, radioMessage, 5000)
      randomStatic(true)

      local radioMessage = ""
      for i = 1, #args do
        if math.random(50) > 25 then
          radioMessage = radioMessage .. " " .. args[i]
        else
          radioMessage = radioMessage .. " **BZZZ** "
        end
      end
      TriggerServerEvent("radiochatter:server",radioMessage)
    end
end)
RegisterNetEvent('radiochatter:client')
AddEventHandler('radiochatter:client', function(radioMessage,senderid)

    local senderid = tonumber(senderid) 
    local location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
    local dst = #(GetEntityCoords(PlayerPedId()) - location)
    activeMessages = activeMessages + 0.1
    if dst < 5.0 then
      -- play radio static sound locally.
      local counter = 350
      local msgZ = location["z"]+activeMessages
      if PlayerPedId() ~= GetPlayerPed(GetPlayerFromServerId(senderid)) then
        randomStatic(false)
        while counter > 0 and dst < 5.0 do
          location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
          dst = #(GetEntityCoords(PlayerPedId()) - location)
          DrawRadioChatter(location["x"],location["y"],msgZ, "Radio Chatter: " .. radioMessage, counter)
          counter = counter - 1
          Citizen.Wait(1)
        end
      end
    end
    activeMessages = activeMessages - 0.1 
end)


RegisterNetEvent('radiochannel')
AddEventHandler('radiochannel', function(chan)
  local chan = tonumber(chan)
  if hasRadio() and chan < 1000 and chan > -1 then
    radioChannel = chan
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.4)
    -- TriggerEvent('chatMessage', "RADIO CHANNEL " .. radioChannel, 3, "Active", 5000)
  end
end)

RegisterNetEvent('canPing')
AddEventHandler('canPing', function(target)
  if hasPhone() and not isDead then
    local crds = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("requestPing", target, crds["x"],crds["y"],crds["z"] )
  else
    TriggerEvent("DoLongHudText","You need a phone to use GPS!",2)
  end
end)

local pingcount = 0
local currentblip = 0
local currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
RegisterNetEvent('allowedPing')
AddEventHandler('allowedPing', function(x,y,z,src,name)
  if pingcount > 0 then
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you already have one in process!",2)
    return
  end
  
  if hasPhone() and not isDead then
    pingcount = 5
    currentping = { ["x"] = x,["y"] = y,["z"] = z, ["src"] = src }
    while pingcount > 0 do
      TriggerEvent("DoLongHudText",name .. " has given you a ping location, type /pingaccept to accept",1)
      Citizen.Wait(5000)
      pingcount = pingcount - 1
    end
  else
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you have no phone!",2)
  end
  pingcount = 0
  currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
end)

RegisterNetEvent('acceptPing')
AddEventHandler('acceptPing', function()
  if pingcount > 0 then
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
    currentblip = AddBlipForCoord(currentping["x"], currentping["y"], currentping["z"])
    SetBlipSprite(currentblip, 280)
    SetBlipAsShortRange(currentblip, false)
    BeginTextCommandSetBlipName("STRING")
    SetBlipColour(currentblip, 4)
    SetBlipScale(currentblip, 1.2)
    AddTextComponentString("Accepted GPS Marker")
    EndTextCommandSetBlipName(currentblip)
    TriggerEvent("DoLongHudText","Their GPS ping has been marked on the map", 1)
    TriggerServerEvent("pingAccepted",currentping["src"])
    pingcount = 0
    Citizen.Wait(60000)
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsDisabledControlJustReleased(1, 199) then
      if exports['urp-inventory']:hasEnoughOfItem('mobilephone', 1) then
        TriggerEvent('tp:heHasPhone')
      end
    end
  end
end)

RegisterNetEvent('tp:heHasPhone')
AddEventHandler('tp:heHasPhone', function()
    GotPhone()
end)


function GotPhone()
  local dead = exports["urp-deathmanager"]:GetDeath()
      if not dead then
        openGuiNow()
      else
        TriggerEvent("DoLongHudText","You cant do this unconscious", 2)
      end
end

function isRealEstateAgent()
  if exports['isPed']:isPed('job') == "RealEstate" then
    return true
  else
    return false
  end
end


local recentopen = false
function openGuiNow()
 
  if hasPhone() then
    local isREAgent = false
    if isRealEstateAgent() then
      isREAgent = true
    end

    local decrypt = false
    if exports['urp-inventory']:hasEnoughOfItem('decrypterenzo', 1, false) then
      decrypt = true
    end
    
    GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
    guiEnabled = true
    SetNuiFocus(false,false)
    SetNuiFocus(true,true)
    SendNUIMessage({openPhone = true, hasDevice = device, hasDecrypt = decrypt, hasDecrypt2 = decrypt2,hasTrucker = trucker, isRealEstateAgent = isREAgent, playerId = GetPlayerServerId(PlayerId())})

    TriggerEvent('phoneEnabled',true)
    TriggerEvent('animation:sms',true)
    lstContacts = {}
    local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
    local Player = LocalPlayer:getCurrentCharacter()
    TriggerServerEvent('getContacts', Player.id)
  else
    closeGui()
  end
  recentopen = false
end

function openGui()

  if recentopen then
    return
  end
  if hasPhone() then
    GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
    guiEnabled = true
    SetNuiFocus(false,false)
    SetNuiFocus(true,true)
    TriggerServerEvent("websitesList")

    local isREAgent = false

    local hasDecrypt = false
    if exports['urp-inventory']:hasEnoughOfItem('decrypterenzo', 1, false) then
      hasDecrypt = true
    end

    SendNUIMessage({openPhone = true, hasDevice = device, hasDecrypt = decrypt, hasDecrypt2 = decrypt2,hasTrucker = trucker, isRealEstateAgent = isREAgent, playerId = GetPlayerServerId(PlayerId())})

    TriggerEvent('phoneEnabled',true)
    TriggerEvent('animation:sms',true)
    
    lstContacts = {}
    TriggerServerEvent('getContacts', exports['isPed']:isPed('cid'))
  else
    closeGui()
  end
  Citizen.Wait(3000)
  recentopen = false
end

RegisterNUICallback('btnPagerType', function(data, cb)
  TriggerServerEvent("secondaryjob:ServerReturnDate")
end)
local jobnames = {
  ["taxi"] = "Taxi Driver",
  ["towtruck"] = "Tow Truck Driver",
  ["trucker"] = "Delivery Driver",
}


RegisterNUICallback('newPostSubmit', function(data, cb)
  local myjob = miTrabajo()
  local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  if jobnames[myjob] == nil then
    TriggerServerEvent('phone:updatePhoneJob', Player.id, Player.first_name, Player.last_name, data.advert)
  else
    TriggerServerEvent('phone:updatePhoneJob', Player.id, Player.job .. " | " .. data.advert)
    TriggerEvent("DoLongHudText","You are already listed as a " .. myjob)
  end
end)

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)


function miTrabajo()
    return exports['isPed']:isPed('job')
end

RegisterNUICallback('deleteYP', function()
  local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  TriggerServerEvent('phone:RemovePhoneJob', Player.id, Player.first_name, Player.last_name)
end)

RegisterNetEvent("yellowPages:retrieveLawyersOnline")
AddEventHandler("yellowPages:retrieveLawyersOnline", function(command)
    local isFound = false
    local jsonparse = json.decode(YellowPages)
    TriggerEvent("DoLongHudText","Searching for a Lawyer", 1)
    Citizen.Wait(2000)
    for i = 1, #YellowPageArray do
      local job = jsonparse[tonumber(i)].advert
      if string.find(job, 'attorney') or string.find(job, 'lawyer') or string.find(job, 'Lawyer') or string.find(job, 'public defender') then
        local name = jsonparse[tonumber(i)].name
        local number = jsonparse[tonumber(i)].phoneNumber
        TriggerServerEvent('phone:foundLawyerC', name, number)
        isFound = true
      end
    end
    if not isFound then
      TriggerEvent('chatMessage', "", {255, 255, 255}, "There are no lawyers available right now.")
    end
    
end)


RegisterNUICallback('notificationsYP', function()
  TriggerServerEvent('getYP')
  Citizen.Wait(200)
  TriggerEvent("YPUpdatePhone")
end)


RegisterNetEvent('YPUpdatePhone')
AddEventHandler('YPUpdatePhone', function()

  lstnotifications = {}

  local jsonparse = json.decode(YellowPages)

  for i = 1, #YellowPageArray do
    lstnotifications[#lstnotifications + 1] = {
      id = tonumber(i),
      name = jsonparse[tonumber(i)].name,
      message = jsonparse[tonumber(i)].advert,
      phoneNumber = jsonparse[tonumber(i)].phoneNumber
    }
  end
  SendNUIMessage({openSection = "notificationsYP", list = lstnotifications})
end)

-- Close Gui and disable NUI
function closeGui()
  TriggerEvent("closeInventoryGui")
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  TriggerEvent('animation:sms',false)
  TriggerEvent('phoneEnabled',false)
  recentopen = true
  Citizen.Wait(3000)
  recentopen = false
  insideDelivers = false
end

function closeGui2()
  TriggerEvent("closeInventoryGui")
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  recentopen = true
  Citizen.Wait(3000)
  recentopen = false  
end
local mousenumbers = {
  [1] = 1,
  [2] = 2,
  [3] = 3, 
  [4] = 4, 
  [5] = 5, 
  [6] = 6, 
  [7] = 12, 
  [8] = 13, 
  [9] = 66, 
  [10] = 67, 
  [11] = 95, 
  [12] = 96,   
  [13] = 97,   
  [14] = 98,
  [15] = 169,
   [16] = 170,
}

RegisterNUICallback('racing:events:highscore', function()
  TriggerEvent('DoLongHudText', 'Coming Soon', 2)
end)

-- Callback when setting up new Event
RegisterNUICallback('racing:event:setup', function()
    ExecuteCommand('race record')
    TriggerEvent('DoLongHudText', "Checkpoint recording started, place your checkpoints on the map")
end)

local currentMap = {}
local customMaps = {}
local dst = 30.0
local creatingMap = false
local SetBlips = {}
local particleList = {}
local currentRaces = {}
local JoinedRaces = {}
local racing = false
local racesStarted = 0
local mylastid = "NA"


-- Disable controls while GUI open
Citizen.CreateThread(function()
  local focus = true
  
  while true do

    if guiEnabled then
      DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
      DisableControlAction(0, 2, guiEnabled) -- LookUpDown
      DisableControlAction(0, 14, guiEnabled) -- INPUT_WEAPON_WHEEL_NEXT
      DisableControlAction(0, 15, guiEnabled) -- INPUT_WEAPON_WHEEL_PREV
      DisableControlAction(0, 16, guiEnabled) -- INPUT_SELECT_NEXT_WEAPON
      DisableControlAction(0, 17, guiEnabled) -- INPUT_SELECT_PREV_WEAPON
      DisableControlAction(0, 99, guiEnabled) -- INPUT_VEH_SELECT_NEXT_WEAPON
      DisableControlAction(0, 100, guiEnabled) -- INPUT_VEH_SELECT_PREV_WEAPON
      DisableControlAction(0, 115, guiEnabled) -- INPUT_VEH_FLY_SELECT_NEXT_WEAPON
      DisableControlAction(0, 116, guiEnabled) -- INPUT_VEH_FLY_SELECT_PREV_WEAPON
      DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
      DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end

    else
      mousemovement = 0
    end

    if selfieMode then
        if IsControlJustPressed(0, 177) then
          selfieMode = false
          DestroyMobilePhone()
          CellCamActivate(false, false)
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
    else
      selfieMode = false
      DestroyMobilePhone()
      CellCamActivate(false, false)
    end

    if creatingMap then

      local plycoords = GetEntityCoords(GetPlayerPed(-1))

      DrawMarker(27,plycoords.x,plycoords.y,plycoords.z,0,0,0,0,0,0,dst,dst,0.3001,255,255,255,255,0,0,0,0)
      
      if #currentMap == 0 then
        DrawText3Ds(plycoords.x,plycoords.y,plycoords.z,"[E] to add start point, up/down for size, phone to save or cancel.")
      else
        DrawText3Ds(plycoords.x,plycoords.y,plycoords.z,"[E] to add check point, up/down for size, phone to save or cancel.")
      end

      if IsControlPressed(0,27) then
        dst = dst + 1
        if dst > 60.0 then
          dst = 60.0
        end
      end

      if IsControlPressed(0,173) then
        dst = dst - 1
        if dst < 4 then
          dst = 3.0
        end
      end

      if IsControlJustReleased(0,38) then
        if (IsControlPressed(0,21)) then
          PopLastCheckpoint()
        else
          AddCheckPoint()
        end
        Wait(1000)
      end

    end
    Citizen.Wait(1)
  end
end)
function StartMapCreation()
  currentMap = {}
  dst = 30.0;
  creatingMap = true
end

function CancelMap()
  -- get distance here between checkpoints
  creatingMap = false
end

function ClearBlips()
  for i = 1, #SetBlips do
    RemoveBlip(SetBlips[i])
  end
  SetBlips = {}
end

function AddCheckPoint()
  loadCheckpointModels()
  local plycoords = GetEntityCoords(GetPlayerPed(-1))
  local ballsdick = dst/2
  local fx,fy,fz = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1),  ballsdick, 0.0, -0.25))

  local fx2,fy2,fz2 = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0 - ballsdick, 0.0, -0.25))
  
  addCheckpointMarker(vector3(fx,fy,fz), vector3(fx2,fy2,fz2))

  local start = false

  if #currentMap == 0 then
    start = true
  end

  local checkcounter = #currentMap + 1
  currentMap[checkcounter] = { 
    ["flare1x"] = FUCKK(fx), ["flare1y"] = FUCKK(fy), ["flare1z"] = FUCKK(fz),
    ["flare2x"] = FUCKK(fx2), ["flare2y"] = FUCKK(fy2), ["flare2z"] = FUCKK(fz2),
    ["x"] = FUCKK(plycoords.x),  ["y"] = FUCKK(plycoords.y), ["z"] = FUCKK(plycoords.z-1.1), ["start"] = start, ["dist"] = ballsdick, 
  }

  local key = #SetBlips+1
  SetBlips[key] = AddBlipForCoord(plycoords.x,plycoords.y,plycoords.z)
  SetBlipAsFriendly(SetBlips[key], true)
  SetBlipSprite(SetBlips[key], 1)
  ShowNumberOnBlip(SetBlips[key], key)
  BeginTextCommandSetBlipName("STRING");
  AddTextComponentString(tostring("Checkpoint " .. key))
  EndTextCommandSetBlipName(SetBlips[key])

end

local checkpointMarkers = {}
local isModelsLoaded = false
function loadCheckpointModels()
  local models = {}
  models[1] = "prop_offroad_tyres02"
  models[2] = "prop_beachflag_01"
  for i = 1, #models do
    local checkpointModel = GetHashKey(models[i])
    RequestModel(checkpointModel)
    while not HasModelLoaded(checkpointModel) do
      Citizen.Wait(1)
    end
  end
  isModelsLoaded = true
end

function addCheckpointMarker(leftMarker, rightMarker)
  local model = #checkpointMarkers == 0 and 'prop_beachflag_01' or 'prop_offroad_tyres02'

  local checkpointLeft = CreateObject(GetHashKey(model), leftMarker, false, false, false)
  local checkpointRight = CreateObject(GetHashKey(model), rightMarker, false, false, false)
  checkpointMarkers[#checkpointMarkers+1] = {
    left = checkpointLeft,
    right = checkpointRight
  }
  PlaceObjectOnGroundProperly(checkpointLeft)
  SetEntityAsMissionEntity(checkpointLeft)
  PlaceObjectOnGroundProperly(checkpointRight)
  SetEntityAsMissionEntity(checkpointRight)
end

function LoadMapBlips(id)
  local id = tostring(id)
  ClearBlips()
  loadCheckpointModels()
  if(customMaps[id].checkpoints ~= nil) then
    for mId, map in pairs(customMaps[id].checkpoints) do
      local key = #SetBlips+1
      SetBlips[key] = AddBlipForCoord(map["x"],map["y"],map["z"])
      SetBlipAsFriendly(SetBlips[key], true)
      SetBlipAsShortRange(SetBlips[key], true)
      SetBlipSprite(SetBlips[key], 1)
      ShowNumberOnBlip(SetBlips[key], key)
      BeginTextCommandSetBlipName("STRING");
      AddTextComponentString(tostring("Checkpoint " .. key))
      EndTextCommandSetBlipName(SetBlips[key])

      addCheckpointMarker(vector3(map["flare1x"], map["flare1y"], map["flare1z"]), vector3(map["flare2x"], map["flare2y"], map["flare2z"]))
    end
  end
end

function PopLastCheckpoint()
  if #currentMap > 1 then
    local lastCheckpoint = #currentMap
    SetEntityAsNoLongerNeeded(checkpointMarkers[lastCheckpoint].left)
    DeleteObject(checkpointMarkers[lastCheckpoint].left)
    SetEntityAsNoLongerNeeded(checkpointMarkers[lastCheckpoint].right)
    DeleteObject(checkpointMarkers[lastCheckpoint].right)
    RemoveBlip(SetBlips[lastCheckpoint])
    table.remove(checkpointMarkers)
    table.remove(currentMap)
    table.remove(SetBlips)
  end
end

function ShowText(text)
  TriggerEvent("DoLongHudText",text)
end

function StartEvent(map,laps,counter,raceName, startTime, mapCreator, mapDistance, mapDescription)

  local map = tostring(map)
  local laps = tonumber(laps)
  local counter = tonumber(counter)
  local mapCreator = tostring(mapCreator)
  local mapDistance = tonumber(mapDistance)
  local mapDescription = tostring(mapDescription)

  if map == 0 then
    ShowText("Pick a map or use the old racing system.")
    return
  end

  local ped = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ped)
  local dist = Vdist(customMaps[map]["checkpoints"][1]["x"],customMaps[map]["checkpoints"][1]["y"],customMaps[map]["checkpoints"][1]["z"], plyCoords.x,plyCoords.y,plyCoords.z)

  if dist > 40.0 then
    ShowText("You are too far away!")
    return
  end

  ShowText("Race Starting on " .. customMaps[map]["track_name"] .. " with " .. laps .. " laps in " .. counter .. " seconds!")
  racesStarted = racesStarted + 1
  local cid = exports["isPed"]:isPed("cid")
  local uniqueid = cid .. "-" .. racesStarted

  local s1, s2 = GetStreetNameAtCoord(customMaps[map]["checkpoints"][1].x, customMaps[map]["checkpoints"][1].y, customMaps[map]["checkpoints"][1].z)
  local street1 = GetStreetNameFromHashKey(s1)
  zone = tostring(GetNameOfZone(customMaps[map]["checkpoints"][1].x, customMaps[map]["checkpoints"][1].y, customMaps[map]["checkpoints"][1].z))
  local playerStreetsLocation = zoneNames[tostring(zone)]
  local dir = getCardinalDirectionFromHeading()
  local street1 = street1 .. ", " .. playerStreetsLocation
  local street2 = GetStreetNameFromHashKey(s2) .. " " .. dir
  TriggerServerEvent("racing-global-race",map, laps, counter, uniqueid, cid, raceName, startTime, mapCreator, mapDistance, mapDescription, street1, street2)
end

function hudUpdate(pHudState, pHudData)
  pHudState = pHudState or 'finished'
  pHudData = pHudData or '{}'
  SendNUIMessage({
    openSection = "racing:hud:update",
    hudState = pHudState,
    hudData = pHudData
  })
end

function RunRace(identifier)

  local map = currentRaces[identifier].map
  local laps = currentRaces[identifier].laps
  local counter = currentRaces[identifier].counter
  local sprint = false

  if laps == 0 then
    laps = 1
    sprint = true
  end
  local myLap = 0
  
  local checkpoints = #customMaps[map]["checkpoints"]
  local mycheckpoint = 1
  local ped = GetPlayerPed(-1)

  SetBlipColour(SetBlips[1], 3)
  SetBlipScale(SetBlips[1], 1.6)

  TriggerEvent("DoLongHudText","Race Starts in 3",14)
  PlaySound(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  Citizen.Wait(1000)
  TriggerEvent("DoLongHudText","Race Starts in 2",14)
  PlaySound(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  Citizen.Wait(1000)
  TriggerEvent("DoLongHudText","Race Starts in 1",14)
  PlaySound(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  Citizen.Wait(1000)
  PlaySound(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  TriggerEvent("DoLongHudText","GO!",14)
  hudUpdate('start', {
    isSprint = sprint,
    maxLaps = laps,
    maxCheckpoints = checkpoints
  })

  while myLap < laps+1 and racing do

    Wait(1)
    local plyCoords = GetEntityCoords(ped)
    
    if ( Vdist(customMaps[map]["checkpoints"][mycheckpoint]["x"],customMaps[map]["checkpoints"][mycheckpoint]["y"],customMaps[map]["checkpoints"][mycheckpoint]["z"], plyCoords.x,plyCoords.y,plyCoords.z) ) < customMaps[map]["checkpoints"][mycheckpoint]["dist"] then

      SetBlipColour(SetBlips[mycheckpoint], 3)
      SetBlipScale(SetBlips[mycheckpoint], 1.0)

      
      --PlaySound(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
      mycheckpoint = mycheckpoint + 1

      SetBlipColour(SetBlips[mycheckpoint], 2)
      SetBlipScale(SetBlips[mycheckpoint], 1.6)
      SetBlipAsShortRange(SetBlips[mycheckpoint-1], true)
      SetBlipAsShortRange(SetBlips[mycheckpoint], false)



      if mycheckpoint > checkpoints then
        mycheckpoint = 1
      end

            SetNewWaypoint(customMaps[map]["checkpoints"][mycheckpoint]["x"],customMaps[map]["checkpoints"][mycheckpoint]["y"])


      if not sprint and mycheckpoint == 1 then

        SetBlipColour(SetBlips[1], 2)
        SetBlipScale(SetBlips[1], 1.6)

      end

      if not sprint and mycheckpoint == 2 then
        myLap = myLap + 1

        -- Uncomment these lines to make the checkpoints re-draw on each lap
        --ClearBlips()
        --RemoveCheckpoints()
        --LoadMapBlips(map)
        SetBlipColour(SetBlips[1], 3)
        SetBlipScale(SetBlips[1], 1.0)
        SetBlipColour(SetBlips[2], 2)
        SetBlipScale(SetBlips[2], 1.6)
      elseif sprint and mycheckpoint == 1 then
        myLap = myLap + 2
      end

      hudUpdate('update', {
        curLap = myLap,
        curCheckpoint = (mycheckpoint-1)
      })
    end
  end

  hudUpdate('finished', {
    eventId = identifier
  })

  PlaySound(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  TriggerEvent("DoLongHudText","You have finished!",14)
  Wait(10000)
  racing = false
  hudUpdate('clear')
  ClearBlips()
  RemoveCheckpoints()
end

function EndRace()
  ClearBlips()
  RemoveCheckpoints()
end

function RemoveCheckpoints()
  for i = 1, #checkpointMarkers do
    SetEntityAsNoLongerNeeded(checkpointMarkers[i].left)
    DeleteObject(checkpointMarkers[i].left)
    SetEntityAsNoLongerNeeded(checkpointMarkers[i].right)
    DeleteObject(checkpointMarkers[i].right)
    checkpointMarkers[i] = nil
  end
end

function FUCKK(num)
  local new = math.ceil(num*100)
  new = new / 100
  return new
end

function SaveMap(name,description)
  -- get distance here between checkpoints

  local distanceMap = 0.0
  for i = 1, #currentMap do
    if i == #currentMap then
      distanceMap = Vdist(currentMap[i]["x"],currentMap[i]["y"],currentMap[i]["z"], currentMap[1]["x"],currentMap[1]["y"],currentMap[1]["z"]) + distanceMap
    else
      distanceMap = Vdist(currentMap[i]["x"],currentMap[i]["y"],currentMap[i]["z"], currentMap[i+1]["x"],currentMap[i+1]["y"],currentMap[i+1]["z"]) + distanceMap
    end
  end
  distanceMap = math.ceil(distanceMap)

  if #currentMap > 1 then
    TriggerEvent("DoLongHudText","The map is being processed and should be available shortly.",2)
    TriggerServerEvent("racing-save-map",currentMap,name,description,distanceMap)
  else
    TriggerEvent("DoLongHudText","Failed due to lack of checkpoints",2)
  end
  currentMap = {}
  creatingMap = false
end

RegisterNUICallback('racing:events:list', function()
  SendNUIMessage({
    openSection = "racing:events:list",
    races = currentRaces,
    canMakeMap = true
  });
end)

--[[RegisterNUICallback('racing:events:highscore', function()
  TriggerServerEvent("racing-retreive-maps")
  Wait(300)
  local highScoreObject = {}
  for k,v in pairs(customMaps) do
    highScoreObject[k] = {
      fastestLap = v.fastest_lap,
      fastestName = v.fastest_name,
      fastestSprint = v.fastest_sprint,
      fastestSprintName = v.fastest_sprint_name,
      map = v.track_name,
      noOfRaces = v.races,
      mapDistance = v.distance
    }
  end

  SendNUIMessage({
    openSection = "racing:events:highscore",
    highScoreList = highScoreObject
  });
end)]]--

-- Callback when setting up new Event
--[[RegisterNUICallback('racing:event:setup', function()
  TriggerServerEvent("racing-build-maps")
end)]]--

-- Fix
RegisterNUICallback('racing:event:leave', function()
  hudUpdate('clear')
  ClearBlips()
  RemoveCheckpoints()
  racing = false
end)

-- Fix
RegisterNUICallback('racing:event:join', function(data)
  RemoveCheckpoints()
  local id = data.identifier
  local ped = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ped)

  if Vdist(customMaps[currentRaces[id]["map"]]["checkpoints"][1]["x"], customMaps[currentRaces[id]["map"]]["checkpoints"][1]["y"], customMaps[currentRaces[id]["map"]]["checkpoints"][1]["z"],plyCoords.x,plyCoords.y,plyCoords.z) < 40 then
    -- IF the race is OPEN and you are not in the race and youre not racing
    if currentRaces[id]["open"] and not JoinedRaces[id] and not racing then
      racing = true
      JoinedRaces[id] = true
      TriggerServerEvent("racing-join-race",id)
      hudUpdate('starting')
      ShowText("Joining Race!")
      LoadMapBlips(currentRaces[id]["map"])
    else
      -- IF youre in this race and youre not racing
      if (JoinedRaces[id] and not racing) then
        racing = true
        hudUpdate('starting')
      else
        ShowText("This race is closed or you are already in it!")
      end
    end
  else
    ShowText("You are too far away!")
  end
end)

-- Fix
RegisterNUICallback('racing:event:start', function(data)
  StartEvent(data.raceMap, data.raceLaps, data.raceCountdown, data.raceName, data.raceStartTime, data.mapCreator, data.mapDistance, data.mapDescription)
  Wait(500)
  SendNUIMessage({
    openSection = "racing:events:list",
    races = currentRaces
  });
end)

-- Fix this
RegisterNUICallback('race:completed', function(data)
  JoinedRaces[data.identifier] = nil
  TriggerServerEvent("race:completed2",data.fastestlap, data.overall, data.sprint, data.identifier)
  EndRace()
end)

-- Racing:Map
RegisterNUICallback('racing:map:create', function()
  if not exports['StreetRaces']:isRecordingRace() then
    ExecuteCommand('race record')
    TriggerEvent('DoLongHudText', "Checkpoint recording started, place your checkpoints on the map")
  else
    TriggerEvent('DoLongHudText', "Already recording race", 2)
  end
end)

RegisterNUICallback('racing:map:load', function(data)
  ClearBlips()
  RemoveCheckpoints()
  if(data.id ~= nil) then
    LoadMapBlips(data.id)
  end
end)

RegisterNUICallback('racing:map:delete', function(data)
  ClearBlips()
  RemoveCheckpoints()
  if data.id == "0" then
    print("you suck")
  else
    TriggerServerEvent("racing-map-delete",customMaps[tonumber(data.id)]["dbid"])
  end
end)

RegisterNUICallback('racing:map:removeBlips', function()
  EndRace()
end)

RegisterNUICallback('racing:map:cancel', function()
  if exports['StreetRaces']:isRecordingRace() then
    TriggerEvent('racing:cleanupRace')
    TriggerEvent('DoLongHudText', "Race Setup cancelled", 2)
  else
    TriggerEvent('DoLongHudText', "Not recording race", 2)
  end
end)

RegisterNUICallback('racing:map:save', function(data)
  if exports['StreetRaces']:cpCount() then
    ExecuteCommand("race start " .. data.name .. " " .. data.desc)
    TriggerEvent('DoLongHudText', 'Race started with a bet amount of $' .. data.name)
  else
    TriggerEvent('DoLongHudText', 'No checkpoints set', 2)
  end
end)

RegisterNetEvent('racing:data:set')
AddEventHandler('racing:data:set', function(data)
  if(data.event == "map") then
    if (data.eventId ~= -1) then
      customMaps[data.eventId] = data.data
    else
      customMaps = data.data
      if(data.subEvent == nil or data.subEvent ~= "noNUI") then
        SendNUIMessage({
          openSection = 'racing-start',
          maps = customMaps
        })
      end
    end
  elseif (data.event == "event") then
    if (data.eventId ~= -1) then
      currentRaces[data.eventId] = data.data
      if JoinedRaces[data.eventId] and racing and data.subEvent == "close" then
        RunRace(data.eventId)
      end
      SendNUIMessage({
        openSection = "racing:event:update",
        eventId = data.eventId,
        raceData = currentRaces[data.eventId]
      })
    else
      currentRaces = data.data
      SendNUIMessage({
        openSection = "racing:event:update",
        raceData = currentRaces
      })
    end
  end
end)

RegisterNetEvent('racing:clearFinishedRaces')
AddEventHandler('racing:clearFinishedRaces', function(id)
  if(JoinedRaces[id] ~= nil) then
    JoinedRaces[id] = nil
    ClearBlips()
    RemoveCheckpoints()
  end
end)

RegisterCommand('pn', function(source)
  TriggerServerEvent('phone:pn', exports['isPed']:isPed('cid'))
end)

RegisterCommand('number', function(source)
  TriggerServerEvent('phone:number', exports['isPed']:isPed('cid'))
end)

-- Opens our phone
RegisterNetEvent('phoneGui2')
AddEventHandler('phoneGui2', function()
  openGui()
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('phone:close')
AddEventHandler('phone:close', function(number, message)
  closeGui()

end)

-- SMS Callbacks
RegisterNUICallback('messages', function(data, cb)
  loading()
  TriggerServerEvent('phone:getSMS', exports['isPed']:isPed('cid'))
  cb('ok')
end)

RegisterNetEvent('phone:clientGetMessagesBetweenParties')
AddEventHandler('phone:clientGetMessagesBetweenParties', function(messages, displayName, clientNumber)
  
  SendNUIMessage({openSection = "messageRead", messages = messages, displayName = displayName, clientNumber = clientNumber})
end)

--$.post...
RegisterNUICallback('messageRead', function(data, cb)
  TriggerServerEvent('phone:serverGetMessagesBetweenParties',exports['isPed']:isPed('cid'), data.sender, data.receiver, data.displayName)
  cb('ok')
end)

RegisterNUICallback('messageDelete', function(data, cb)
  TriggerServerEvent('phone:removeSMS', data.id, data.number)
  cb('ok')
end)

RegisterNUICallback('newMessage', function(data, cb)
  SendNUIMessage({openSection = "newMessage"})
  cb('ok')
end)





RegisterNUICallback('messageReply', function(data, cb)
  SendNUIMessage({openSection = "newMessageReply", number = data.number})
  cb('ok')
end)

RegisterNUICallback('newMessageSubmit', function(data, cb)
  if not isDead then
    TriggerEvent('phone:sendSMS', tonumber(data.number), data.message)
    cb('ok')
  else
    TriggerEvent("DoLongHudText","You can not do this while injured.",2)
  end
end)


function testfunc()

end
RegisterNetEvent("TokoVoip:UpVolume");
AddEventHandler("TokoVoip:UpVolume", setVolumeUp);

RegisterNetEvent('refreshContacts')
AddEventHandler('refreshContacts', function()
  TriggerServerEvent('getContacts', exports['isPed']:isPed('cid'))
  SendNUIMessage({openSection = "contacts"})
end)

RegisterNetEvent('refreshYP')
AddEventHandler('refreshYP', function()
  if guiEnabled then
    TriggerServerEvent('getYP')
    Citizen.Wait(250)
    TriggerEvent('YPUpdatePhone')
  end
end)

RegisterNetEvent('refreshSMS')
AddEventHandler('refreshSMS', function()
  TriggerServerEvent('phone:getSMS', exports['isPed']:isPed('cid'))
  Citizen.Wait(250)
  SendNUIMessage({openSection = "messages"})
end)

-- Contact Callbacks
RegisterNUICallback('contacts', function(data, cb)
  TriggerServerEvent('getContacts', exports['isPed']:isPed('cid'))
  SendNUIMessage({openSection = "contacts"})
  cb('ok')
end)

RegisterNUICallback('newContact', function(data, cb)
  SendNUIMessage({openSection = "newContact"})
  cb('ok')
end)

RegisterNUICallback('newContactSubmit', function(data, cb)
  TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.6vw; padding-left: 0.8vw; background-color: rgba(190, 97, 18, 0.8); border-radius: 6px;"><span style="width: 100%; font-weight: bold;">Service: </span>Contact Saved</div>',
		args = {}
  })
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()  
  TriggerEvent('phone:addContact', data.name, tonumber(data.number))
  cb('ok')
end)

RegisterNUICallback('removeContact', function(data, cb)
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter() 
  TriggerServerEvent('deleteContact', Player.id, data.name, data.number)
  cb('ok')
end)


myID = 0
mySourceID = 0

mySourceHoldStatus = false
TriggerEvent('phone:setCallState', isNotInCall)
costCount = 1

RegisterNetEvent('animation:phonecallstart')
AddEventHandler('animation:phonecallstart', function()
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",true)
  local lPed = PlayerPedId()
  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Citizen.Wait(0)
  end
  local count = 0
  costCount = 1
  inPhone = false
  Citizen.Wait(200)
  ClearPedTasks(lPed)
  
  TriggerEvent("attachItemPhone","phone01")
  TriggerEvent("DoLongHudText","[E] Toggles Call.", 6)


  while callStatus ~= isNotInCall do

    if isDead then
      endCall()
    end


    if IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_call_listen_base", 3) and not IsPedRagdoll(PlayerPedId()) then
    else 



      if IsPedRagdoll(PlayerPedId()) then
        Citizen.Wait(1000)
      end
      TaskPlayAnim(lPed, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
    end
    Citizen.Wait(1)
    count = count + 1

    if AnonCall then
       local dPB = #(PhoneBooth - GetEntityCoords( PlayerPedId()))
       if dPB > 2.0 then
        TriggerEvent("DoLongHudText","Moved too far.", 2)
        endCall()
       end
    end



    if IsControlJustPressed(0, 38) then
      TriggerEvent("phone:holdToggle")
    end

    if onhold then
      if count == 800 then
         count = 0
         TriggerEvent("DoLongHudText","Call On Hold.", 1)
      end
    end

      --check if not unarmed
    local curw = GetSelectedPedWeapon(PlayerPedId())
    noweapon = `WEAPON_UNARMED`
    if noweapon ~= curw then
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end

  end
  ClearPedTasks(lPed)
  TaskPlayAnim(lPed, "cellphone@", "cellphone_call_out", 2.0, 2.0, 800, 49, 0, 0, 0, 0)
  Citizen.Wait(700)
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",false)
end)

RegisterNetEvent('phone:makecall')
AddEventHandler('phone:makecall', function(pnumber)

  local pnumber = tonumber(pnumber)
  AnonCall = false
  if callStatus == isNotInCall and not isDead and hasPhone() then
    local dialingName = getContactName(pnumber)
    TriggerEvent('phone:setCallState', isDialing, dialingName)
    TriggerEvent("animation:phonecallstart")
    recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = pnumber, ["name"] = dialingName }
    TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, true)
  else
    TriggerEvent("It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.", 2)
  end
end)



local PayPhoneHex = {
  [1] = 1158960338,
  [2] = -78626473,
  [3] = 1281992692,
  [4] = -1058868155,
  [5] = -429560270,
  [6] = -2103798695,
  [7] = 295857659,
  [8] = -1559354806,
}

function checkForPayPhone()
  for i = 1, #PayPhoneHex do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 5.0, PayPhoneHex[i], 0, 0, 0)
    if DoesEntityExist(objFound) then
      return true
    end
  end
  return false
end

RegisterNetEvent('phone:makepayphonecall')
AddEventHandler('phone:makepayphonecall', function(pnumber) 

    if not checkForPayPhone() then
      TriggerEvent("DoLongHudText","You are not near a payphone.",2)
      return
    end
    if checkForPayPhone() then
      local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
      LocalPlayer:removeCash(exports['isPed']:isPed('cid'), 25)
    end

    PhoneBooth = GetEntityCoords( PlayerPedId() )
    AnonCall = true

    local pnumber = tonumber(pnumber)
    if callStatus == isNotInCall and not isDead then
      TriggerEvent('phone:setCallState', isDialing)
      TriggerEvent("animation:phonecallstart")
      TriggerEvent("InteractSound_CL:PlayOnOne","payphonestart",0.5)
      TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, false)
    else
      TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
    end

end)

RegisterCommand("payphone", function(source, args)
  local src = source
  local pnumber = args[1]
  local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  if Player.cash >= 25 then
      TriggerEvent('phone:makepayphonecall', pnumber)
  else
      TriggerEvent('DoLongHudText', 'You dont have $25 for the payphone', 2)
  end
end, false)




--[[ The following happens for regular calls too ]]

RegisterNUICallback('callContact', function(data, cb)
  closeGui()
  AnonCall = false
  Wait(1500)
  if callStatus == isNotInCall and not isDead and hasPhone() then
    TriggerEvent('phone:setCallState', isDialing, data.name == "" and data.number or data.name)
    TriggerEvent("animation:phonecallstart")
    TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), data.number, true)
  else
    TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
  end
  cb('ok')
end)

debugn = false
function t(trace)
  print(trace)
end

RegisterNetEvent('phone:failedCall')
AddEventHandler('phone:failedCall', function()
    t("Failed Call")
    endCall()
end)


RegisterNetEvent('phone:hangup')
AddEventHandler('phone:hangup', function(AnonCall)
    if AnonCall then
      t("Call Anon Hangup")
      endCall2()
    else
      t("Call Hangup")
      endCall()
    end
end)

local callid = 0

RegisterNetEvent('phone:hangupcall')
AddEventHandler('phone:hangupcall', function()
    if AnonCall then
      t("Call Anon Hangup 2")
      endCall2()
    else
      t("Call Hangup 2")
      endCall()
    end
end)

RegisterNetEvent('phone:endCalloncommand')
AddEventHandler('phone:endCalloncommand', function()
  TriggerServerEvent('phone:EndCall', mySourceID, callid, true)
end)

RegisterNetEvent('phone:otherClientEndCall')
AddEventHandler('phone:otherClientEndCall', function()
    TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
    TriggerEvent("DoLongHudText", "Your call was ended!", 2)
    callid = 0
    myID = 0
    mySourceID = 0
    mySourceHoldStatus = false
    TriggerEvent('phone:setCallState', isNotInCall)
    onhold = false
end)

RegisterNUICallback('btnAnswer', function()
    closeGui()
    TriggerEvent("phone:answercall")
end)
RegisterNUICallback('btnHangup', function()
    closeGui()
    TriggerEvent("phone:hangup")
end)

RegisterNetEvent('phone:answercall')
AddEventHandler('phone:answercall', function()
    if callStatus == isReceivingCall and not isDead then
    answerCall()
    TriggerEvent("animation:phonecallstart")
    TriggerEvent("DoLongHudText","You have answered a call.", 1)
    callTimer = 0
  else
    TriggerEvent("DoLongHudText","You are not being called, injured, or you took too long.", 2)
  end
end)

RegisterNetEvent('phone:initiateCall')
AddEventHandler('phone:initiateCall', function(srcID)
    initiatingCall()
    if not AnonCall then
      TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
    end
end)

RegisterNetEvent('phone:addToCall')
AddEventHandler('phone:addToCall', function(voipchannel)
  local playerName = GetPlayerName(PlayerId())
  exports['urp-voip']:addPlayerToCall(tonumber(voipchannel))
end)

RegisterNetEvent('phone:callFullyInitiated')
AddEventHandler('phone:callFullyInitiated', function(srcID,sentSource)
 TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
  myID = srcID
  mySourceID = sentSource
  local penis = isCallInProgress
  TriggerEvent('phone:setCallState', penis)
  callTimer = 0
  TriggerEvent("phone:callactive")
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
RegisterNetEvent('phone:callactive')
AddEventHandler('phone:callactive', function()
    Citizen.Wait(100)
    local held1 = false
    local held2 = false
    while callStatus == isCallInProgress do
      local phoneString = ""
      Citizen.Wait(1)

      if onhold then
        phoneString = phoneString .. "They are on Hold | "
        if not held1 then
          TriggerEvent("DoLongHudText","You have put the caller on hold.",1)
          held1 = true
        end
      else
        phoneString = phoneString .. "Call Active | "
        if held1 then
          TriggerEvent("DoLongHudText","Your call is no longer on hold.",1)
          held1 = false
        end
      end

      if mySourceHoldStatus then
        phoneString = phoneString .. "You are on hold"
        if not held2 then
          TriggerEvent("DoLongHudText", "You are on hold.", 2)
          held2 = true
        end
      else
        phoneString = phoneString .. "Caller Active"
        if held2 then
          TriggerEvent("DoLongHudText", "You are no longer on hold.", 1)
          held2 = false
        end
      end
      drawTxt(0.97, 1.46, 1.0,1.0,0.33, phoneString, 255, 255, 255, 255)  -- INT: kmh
    end
end)



RegisterNetEvent('phone:id')
AddEventHandler('phone:id', function(sentcallid)
  callid = sentcallid
end)

RegisterNetEvent('phone:setCallState')
AddEventHandler('phone:setCallState', function(pCallState, pCallInfo)
  callStatus = pCallState
  SendNUIMessage({
    openSection = 'callState',
    callState = pCallState,
    callInfo = pCallInfo
  })
end)

RegisterNetEvent('phone:receiveCall')
AddEventHandler('phone:receiveCall', function(phoneNumber, srcID, calledNumber)
  local callFrom = getContactName(calledNumber)
  
  recentcalls[#recentcalls + 1] = { ["type"] = 1, ["number"] = calledNumber, ["name"] = callFrom }

  if callStatus == isNotInCall then
    myID = 0
    mySourceID = srcID
    TriggerEvent('phone:setCallState', isReceivingCall, callFrom)

    receivingCall(callFrom) -- Send contact name if exists, if not send number
  else
    TriggerEvent("DoLongHudText","You are receiving a call from " .. callFrom .. " but are currently already in one, sending busy response.",2)
  end
end)
callTimer = 0
function initiatingCall()
  callTimer = 8
  TriggerEvent("DoLongHudText","You are making a call, please hold.", 1)
  while (callTimer > 0 and callStatus == isDialing) do
    if AnonCall and callTimer < 7 then
      TriggerEvent("InteractSound_CL:PlayOnOne","payphoneringing", 0.5)
    elseif not AnonCall then
      TriggerEvent("InteractSound_CL:PlayOnOne","cellcall",0.5)
    end
    
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus == isDialing or callTimer == 0 then
    endCall()
  end
end

function receivingCall(callFrom)
  callTimer = 8
  while (callTimer > 0 and callStatus == isReceivingCall) do
    if hasPhone() then
      Citizen.Wait(1)
      TriggerEvent("DoLongHudText","Call from: " .. callFrom .. " /answer | /hangup", 1)

      if phoneNotifications then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cellcall', 0.5)
      end
    end
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus ~= isCallInProgress then
    endCall()
  end
end

function answerCall()
    if mySourceID ~= 0 then
      TriggerServerEvent("phone:StartCallConfirmed",mySourceID)
      TriggerEvent('phone:setCallState', isCallInProgress)
      TriggerEvent("phone:callactive")
    end
end

RegisterNetEvent('phone:removefromToko')
AddEventHandler('phone:removefromToko', function(playerRadioChannel)
  exports['urp-voip']:removePlayerFromCall()
end)

function endCall()
  TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  onhold = false
  mySourceHoldStatus = false
  AnonCall = false
  callid = 0
end

function endCall2()
  TriggerEvent("InteractSound_CL:PlayOnOne","payphoneend",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  onhold = false
  mySourceHoldStatus = false
  AnonCall = false
  callid = 0
  --[[ 
  NetworkSetTalkerProximity(1.0)
  Citizen.Wait(300)
  NetworkClearVoiceChannel()
  Citizen.Wait(300)
  NetworkSetTalkerProximity(18.0)
  ]]
end


RegisterNetEvent('phone:holdToggle')
AddEventHandler('phone:holdToggle', function()
  if myID == nil then
    myID = 0
  end
  if myID ~= 0 then
    if not onhold then

      TriggerEvent("DoLongHudText","Call on hold", 2)

      onhold = true

    

      TriggerServerEvent("OnHold:Server",mySourceID,true)
    else
      TriggerEvent("DoLongHudText","No longer on hold.", 1)
      TriggerServerEvent("OnHold:Server",mySourceID,false)
      onhold = false

    end
  else

    if mySourceID ~= 0 then
      if not onhold then
        TriggerEvent("DoLongHudText","Call on hold.", 2)
        
        onhold = true


        TriggerServerEvent("OnHold:Server",mySourceID,true)
      else
        TriggerEvent("DoLongHudText","No longer on hold.", 1)
    
        TriggerServerEvent("OnHold:Server",mySourceID,false)
        onhold = false
      end
    end
  end
end)


RegisterNetEvent('OnHold:Client')
AddEventHandler('OnHold:Client', function(newHoldStatus,srcSent)
    mySourceHoldStatus = newHoldStatus
    if mySourceHoldStatus then
        local playerId = GetPlayerFromServerId(srcSent)
        MumbleSetVolumeOverride(playerId, -1.0)
        TriggerEvent("DoLongHudText","You just got put on hold.", 1)
    else
        if not onhold then
          local playerId = GetPlayerFromServerId(srcSent)
          MumbleSetVolumeOverride(playerId, 1.0)
        end
        TriggerEvent("DoLongHudText","Your caller is back on the line.", 1)
    end
end)
----------


curNotifications = {}

RegisterNetEvent('phone:addnotification')
AddEventHandler('phone:addnotification', function(name,message)
    if not guiEnabled then
      SendNUIMessage({
          openSection = "newemail"
      }) 
    end 
    curNotifications[#curNotifications+1] = { ["name"] = name, ["message"] = message }
end)

RegisterNetEvent('YellowPageArray')
AddEventHandler('YellowPageArray', function(pass)
    local notdecoded = json.encode(pass)
    YellowPages = notdecoded

    YellowPageArray = pass
end)

RegisterNetEvent('givemethehandle')
AddEventHandler('givemethehandle', function(thehandle)
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  handle = "@" .. Player.first_name .. "_" .. Player.last_name
end)

local currentTwats = {}

RegisterNetEvent('Client:UpdateTweets')
AddEventHandler('Client:UpdateTweets', function(data)
    
    SendNUIMessage({openSection = "twatter", twats = data, myhandle = handle})

end)

RegisterNetEvent('Client:UpdateTweet')
AddEventHandler('Client:UpdateTweet', function(data, handle2)
    local src = source

    if not hasPhone() then
      return
    end
    if guiEnabled then
        -- TriggerServerEvent('GetTweets', true)
    end
    
    -- SendNUIMessage({openSection = "twatter", twats = data, myhandle = handle})
    
    local message = data
    if string.find(message,handle) then
    
        if handle2 ~= handle then
            SendNUIMessage({openSection = "newtweet"})
        
            if phoneNotifications then
                PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
                TriggerEvent("DoLongHudText","You were just mentioned in a tweet on your phone.", 1)
       
            end
        end
    end
    
    if allowpopups and not guiEnabled then
        SendNUIMessage({openSection = "notify", handle = handle2, message = message})
    elseif allowpopups and guiEnabled then
    end
end)

function createGeneralAreaBlip(alertX, alertY, alertZ)
  local genX = alertX + math.random(-50, 50)
  local genY = alertY + math.random(-50, 50)
  local alertBlip = AddBlipForRadius(genX,genY,alertZ,75.0) 
  SetBlipColour(alertBlip,1)
  SetBlipAlpha(alertBlip,80)
  SetBlipSprite(alertBlip,9)
  Wait(60000)
  RemoveBlip(alertBlip)
end

RegisterNetEvent('phone:triggerHOAAlert')
AddEventHandler('phone:triggerHOAAlert', function(pAlertLocation, pAlertX, pAlertY, pAlertZ)
  local hoaRank = GroupRank("hoa")
  if hoaRank > 0 then
    SendNUIMessage({
      openSection = "hoa-notification",
      alertLocation = pAlertLocation
    })
    createGeneralAreaBlip(pAlertX, pAlertY, pAlertZ)
  end
end)

local lastTime = 0;
RegisterNetEvent('phone:triggerPager')
AddEventHandler('phone:triggerPager', function()
  --local job = exports["isPed"]:isPed("myjob")
  if job == "doctor" then
    local currentTime = GetGameTimer()
    if lastTime == 0 or lastTime + (5 * 60 * 1000) < currentTime then
      TriggerServerEvent('InteractSound_CL:PlayWithinDistance', 3.0, 'pager', 0.4)
      SendNUIMessage({
        openSection = "newpager"
      })
      lastTime = currentTime
    end
  end
end)

local customGPSlocations = {
  [1] = { ["x"] = 484.77066040039, ["y"] = -77.643089294434, ["z"] = 77.600166320801, ["info"] = "Garage A"},
  [2] = { ["x"] = -331.96115112305, ["y"] = -781.52337646484, ["z"] = 33.964477539063,  ["info"] = "Garage B"},
  [3] = { ["x"] = -451.37295532227, ["y"] = -794.06591796875, ["z"] = 30.543809890747, ["info"] = "Garage C"},
  [4] = { ["x"] = 399.51190185547, ["y"] = -1346.2742919922, ["z"] = 31.121940612793, ["info"] = "Garage D"},
  [5] = { ["x"] = 598.77319335938, ["y"] = 90.707237243652, ["z"] = 92.829048156738, ["info"] = "Garage E"},
  [6] = { ["x"] = 641.53442382813, ["y"] = 205.42562866211, ["z"] = 97.186958312988, ["info"] = "Garage F"},
  [7] = { ["x"] = 82.359413146973, ["y"] = 6418.9575195313, ["z"] = 31.479639053345, ["info"] = "Garage G"},
  [8] = { ["x"] = -794.578125, ["y"] = -2020.8499755859, ["z"] = 8.9431390762329, ["info"] = "Garage H"},
  [9] = { ["x"] = -669.15631103516, ["y"] = -2001.7552490234, ["z"] = 7.5395741462708, ["info"] = "Garage I"},
  [10] = { ["x"] = -606.86322021484, ["y"] = -2236.7624511719, ["z"] = 6.0779848098755, ["info"] = "Garage J"},
  [11] = { ["x"] = -166.60482788086, ["y"] = -2143.9333496094, ["z"] = 16.839847564697, ["info"] = "Garage K"},
  [12] = { ["x"] = -38.922565460205, ["y"] = -2097.2663574219, ["z"] = 16.704851150513, ["info"] = "Garage L"},
  [13] = { ["x"] = -70.179389953613, ["y"] = -2004.4139404297, ["z"] = 18.016941070557, ["info"] = "Garage M"},
  [14] = { ["x"] = 549.47796630859, ["y"] = -55.197559356689, ["z"] = 71.069190979004, ["info"] = "Garage Impound Lot"},
  [15] = { ["x"] = 364.27685546875, ["y"] = 297.84490966797, ["z"] = 103.49515533447, ["info"] = "Garage O"},
  [16] = { ["x"] = -338.31619262695, ["y"] = 266.79782104492, ["z"] = 85.741966247559, ["info"] = "Garage P"},
  [17] = { ["x"] = 273.66683959961, ["y"] = -343.83737182617, ["z"] = 44.919876098633, ["info"] = "Garage Q"},
  [18] = { ["x"] = 66.215492248535, ["y"] = 13.700443267822, ["z"] = 69.047248840332, ["info"] = "Garage R"},
  [19] = { ["x"] = 3.3330917358398, ["y"] = -1680.7877197266, ["z"] = 29.170293807983, ["info"] = "Garage Imports"},
  [20] = { ["x"] = 286.67013549805, ["y"] = 79.613700866699, ["z"] = 94.362899780273, ["info"] = "Garage S"},
  [21] = { ["x"] = 211.79, ["y"] = -808.38, ["z"] = 30.833, ["info"] = "Garage T"},
  [22] = { ["x"] = 447.65, ["y"] = -1021.23, ["z"] = 28.45, ["info"] = "Garage Police Department"},
  [23] = { ["x"] = -25.59, ["y"] = -720.86, ["z"] = 32.22, ["info"] = "Garage House"},
}

local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,houses,rented)

  

  SendNUIMessage({openSection = "GPS"})

  if loadedGPS then

    return

  end

  for i = 1, #customGPSlocations do

    SendNUIMessage({openSection = "AddGPSLocation", info = customGPSlocations[i]["info"], house_id = i, house_type = 69})

    Citizen.Wait(1)

  end



  loadedGPS = true

end)



RegisterNetEvent('GPSLocations')

AddEventHandler('GPSLocations', function()

	if GPSblip ~= nil then

		RemoveBlip(GPSblip)

		GPSblip = nil

	end	

	TriggerEvent("GPSActivated",false)

	TriggerEvent("openGPS",robberycoordsMansions,robberycoords,rentedOffices)

end)



RegisterNUICallback('loadUserGPS', function(data)

     TriggerEvent("GPS:SetRoute",data.house_id,data.house_type)

end)



RegisterNUICallback('btnCamera', function()

  SetNuiFocus(true,true)

end)



local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,house,rented)

  -- THIS IS FUCKING PEPEGA TOO.....





  if loadedGPS then

    SendNUIMessage({openSection = "GPS"})

    return

  end

  local mapLocationsObject = {

    custom = { info = customGPSlocations, houseType = 69 },

    mansions = { info = mansions, houseType = 2 },

    houses = { info = house, houseType = 1 },

    rented = { info = rented, houseType = 3 }

  }

  SendNUIMessage({openSection = "GPS", locations = mapLocationsObject })

  loadedGPS = true

end)



RegisterNUICallback('loadGPS', function()

  TriggerEvent("GPSLocations")

end)


RegisterNUICallback('btnTwatter', function()
  TriggerServerEvent('GetTweets')
end)

RegisterNUICallback('newTwatSubmit', function(data, cb)
    closeGui()
    TriggerServerEvent('Tweet', handle, data.twat, data.time)   
end)

RegisterNUICallback('btnCamera', function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
end)

RegisterNUICallback('notifications', function()

    lstnotifications = {}

    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }

        lstnotifications[#lstnotifications+1]= message2
    end

    
  SendNUIMessage({openSection = "notifications", list = lstnotifications})

end)

RegisterNetEvent('phone:loadSMSOther')
AddEventHandler('phone:loadSMSOther', function(messages,mynumber)
  openGui()
  lstMsgs = {}
  if (#messages ~= 0) then
    for k,v in pairs(messages) do
      if v ~= nil then
        local msgDisplayName = ""
        if v.receiver == mynumber then
          msgDisplayName = getContactName(v.sender)
        else
          msgDisplayName = getContactName(v.receiver)
        end
        local message = {
          id = tonumber(v.id),
          msgDisplayName = msgDisplayName,
          sender = tonumber(v.sender),
          receiver = tonumber(v.receiver),
          date = tonumber(v.date),
          message = v.message
        }
        lstMsgs[#lstMsgs+1]= message
      end
    end
  end
  SendNUIMessage({openSection = "messagesOther", list = lstMsgs, clientNumber = mynumber})
end)


RegisterNUICallback('accountInformation', function()
  local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  TriggerServerEvent('getAccountInfo', Player.cash, Player.bank)
end)

RegisterNetEvent('getAccountInfo')
AddEventHandler('getAccountInfo', function(cash, bank, licences)
    local LocalPlayer = exports['urp-base']:getModule("LocalPlayer")
    local Player = LocalPlayer:getCurrentCharacter()
    local responseObject = {
        cash = cash,
        bank = bank,
        job = Player.job,
        secondaryJob = "Coming soon.",
        licenses = "", 
        pagerStatus = true
    }
    SendNUIMessage({openSection = "accountInformation", response = responseObject})
end)


RegisterNetEvent('phone:newSMS')
AddEventHandler('phone:newSMS', function(id, number, message, mypn, date, recip)
  lastnumber = number
  if hasPhone() then
    SendNUIMessage({
        openSection = "newsms"
    })
      TriggerServerEvent('phone:getSMS', exports['isPed']:isPed('cid')) 
    if phoneNotifications then
      TriggerEvent("DoLongHudText", "You just received a new SMS.", 1)
      PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end
  end
end)

-- SMS Events
RegisterNetEvent('phone:loadSMS')
AddEventHandler('phone:loadSMS', function(messages,mynumber)

  lstMsgs = {}
  if (#messages ~= 0) then
    for k,v in pairs(messages) do
      if v ~= nil then
        local msgDisplayName = ""
        if v.receiver == mynumber then
          msgDisplayName = getContactName(v.sender)
        else
          msgDisplayName = getContactName(v.receiver)
        end
        local message = {
          id = tonumber(v.id),
          msgDisplayName = msgDisplayName,
          sender = tonumber(v.sender),
          receiver = tonumber(v.receiver),
          date = v.date,
          message = v.message
        }
        lstMsgs[#lstMsgs+1]= message
      end
    end
  end
  SendNUIMessage({openSection = "messages", list = lstMsgs, clientNumber = mynumber})
end)

RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(number, message)
  if(number ~= nil and message ~= nil) then
    TriggerServerEvent('phone:sendSMS', exports['isPed']:isPed('cid'), number, message)
    Citizen.Wait(1000)
    TriggerServerEvent('phone:getSMSc', exports['isPed']:isPed('cid'))
  else
    phoneMsg("You must fill in a number and message!")
  end
end)

local lastnumber = 0

RegisterNetEvent('animation:sms')
AddEventHandler('animation:sms', function(enable)
  TriggerEvent("destroyPropPhone")
  local lPed = PlayerPedId()
  inPhone = enable

  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Citizen.Wait(0)
  end

  if not isInTrunk then
    TaskPlayAnim(lPed, "cellphone@", "cellphone_text_in", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
  end
  Citizen.Wait(300)
  if inPhone then
    TriggerEvent("attachItemPhone","phone01")
    Citizen.Wait(150)
    while inPhone do
      if isDead then
        closeGui()
        inPhone = false
      end
      if not isInTrunk and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_text_read_base", 3) and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_swipe_screen", 3) then
        TaskPlayAnim(lPed, "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
      end    
      Citizen.Wait(1)
    end
    if not isInTrunk then
      ClearPedTasks(PlayerPedId())
    end
  else
    if not isInTrunk then
      Citizen.Wait(100)
      ClearPedTasks(PlayerPedId())
      TaskPlayAnim(lPed, "cellphone@", "cellphone_text_out", 2.0, 1.0, 5.0, 49, 0, 0, 0, 0)
      Citizen.Wait(400)
      TriggerEvent("destroyPropPhone")
      Citizen.Wait(400)
      ClearPedTasks(PlayerPedId())
    else
      TriggerEvent("destroyPropPhone")
    end
  end
end)


RegisterNetEvent('phone:reply')
AddEventHandler('phone:reply', function(message)
  if lastnumber ~= 0 then
    TriggerServerEvent('phone:sendSMS', exports['isPed']:isPed('cid'), lastnumber, message)
    TriggerEvent("chatMessage", "You", 6, message)
  else
    phoneMsg("No user has recently SMS'd you.")
  end
end)



function phoneMsg(inputText)
  TriggerEvent("chatMessage", "Service ", 5, inputText)
end


RegisterNetEvent("house:returnKeys")
AddEventHandler("house:returnKeys", function(pSharedKeys)
  SendNUIMessage({
    openSection = "manageKeys",
    sharedKeys = pSharedKeys
  })
end)


RegisterNetEvent('phone:deleteSMS')
AddEventHandler('phone:deleteSMS', function(id)
  table.remove( lstMsgs, tablefindKeyVal(lstMsgs, 'id', tonumber(id)))
  phoneMsg("Message Removed!")
end)

function getContactName(number)
  if (#lstContacts ~= 0) then
    for k,v in pairs(lstContacts) do
      if v ~= nil then
        if (v.number ~= nil and tonumber(v.number) == tonumber(number)) then
          return v.name
        end
      end
    end
  end

  return number
end

-- Contact Events
RegisterNetEvent('phone:loadContacts')
AddEventHandler('phone:loadContacts', function(contacts)

  lstContacts = {}

  if (#contacts ~= 0) then
    for k,v in pairs(contacts) do
      if v ~= nil then
        local contact = {
        }
        if activeNumbersClient['active' .. tonumber(v.number)] then
        
          contact = {
            name = v.name,
            number = v.number,
            activated = 1
          }
        else
    
          contact = {
            name = v.name,
            number = v.number,
            activated = 0
          }
        end
        lstContacts[#lstContacts+1]= contact

        SendNUIMessage({
          newContact = true,
          contact = contact,
        })
      end
    end
  else
       SendNUIMessage({
        emptyContacts = true
      })
  end
end)

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
  if(name ~= nil and number ~= nil) then
    number = tonumber(number)
    TriggerServerEvent('phone:addContact', exports['isPed']:isPed('cid'), name, number)
  else
     phoneMsg("You must fill in a name and number!")
  end
end)

RegisterNetEvent('phone:newContact')
AddEventHandler('phone:newContact', function(name, number)
  local contact = {
      name = name,
      number = number
  }
  lstContacts[#lstContacts+1]= contact

  SendNUIMessage({
    newContact = true,
    contact = contact,
  })
  -- phoneMsg("Contact Saved!")
  TriggerServerEvent('getContacts', exports['isPed']:isPed('cid'))
end)

RegisterNetEvent('phone:deleteContact')
AddEventHandler('phone:deleteContact', function(name, number)
  local contact = {
      name = name,
      number = number
  }

  table.remove( lstContacts, tablefind(lstContacts, contact))
  
  SendNUIMessage({
    removeContact = true,
    contact = contact,
  })
  local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter() 
  TriggerServerEvent('deleteContact', Player.id, name, number)
end)



function tablefind(tab,el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end

function tablefindKeyVal(tab,key,val)
  for index, value in pairs(tab) do
    if value ~= nil  and value[key] ~= nil and value[key] == val then
      return index
    end
  end
end


RegisterNetEvent('resetPhone')
AddEventHandler('resetPhone', function()
     SendNUIMessage({
      emptyContacts = true
    })

end)

local weather = CurrentWeather
local CurrentWeather = CurrentWeather
RegisterNetEvent("vSync:updateWeather")
AddEventHandler("vSync:updateWeather", function(CurrentWeather)
  CurrentWeather = CurrentWeather
  SendNUIMessage({openSection = "weather", CurrentWeather = CurrentWeather})
end)
RegisterNetEvent("kWeatherSync")
AddEventHandler("kWeatherSync", function(pWeather)
  -- weather = pWeather
end)

RegisterNUICallback('getWeather', function(data, cb)
  SendNUIMessage({openSection = "weather", CurrentWeather = CurrentWeather})
  cb("ok")
end)

function MyPlayerId()
  for i=0,256 do
    if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == PlayerPedId()) then return i end
  end
  return nil
end

function Voip(intPlayer, boolSend)

end


RegisterNetEvent('sendMessagePhoneN')
AddEventHandler('sendMessagePhoneN', function(phonenumberlol)
  TriggerServerEvent('message:tome', phonenumberlol)
end)





URP = URP or {}
URP.DataControls = URP.DataControls or {}

function URP.DataControls.getBindTable()

	local i = 1
	local controlTable = {}
	for k,v in pairs(URP.Controls.Current) do
		controlTable[i] = {k,v}
		i = i+1
	end

    return controlTable
end
URP.SettingsData = URP.SettingsData or {}
URP.Settings = URP.Settings or {}

URP.Settings.Current = {}
-- Current bind name and keys
URP.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["mainVolume"] = 6.0,
    ["clickVolume"] = 10.0,
    ["radioVolume"] = 5.0,
  },
  ["hud"] = {

  }

}
URP.Controls = URP.Controls or {}
URP.Controls.Current = {}
-- Current bind name and keys
URP.Controls.Default = {
  ["tokoptt"] = "caps",
  ["loudSpeaker"] = "-",
  ["distanceChange"] = "g",
  ["tokoToggle"] = "leftctrl",
  ["handheld"] = "leftshift+p",
  ["carStereo"] = "leftalt+p",
  ["switchRadioEmergency"] = "9",
  ["actionBar"] = "tab",
  ["generalUse"] = "e",
  ["generalPhone"] = "p",
  ["generalInventory"] = "k",
  ["generalChat"] = "t",
  ["generalEscapeMenu"] = "esc",
  ["generalUseSecondary"] = "enter",
  ["generalUseSecondaryWorld"] = "f",
  ["generalUseThird"] = "g",
  ["generalTackle"] = "leftalt",
  ["generalMenu"] = "f1",
  ["generalProp"] = "7",
  ["generalScoreboard"] = "u",
  ["movementCrouch"] = "x",
  ["movementCrawl"] = "z",
  ["vehicleCruise"] = "x",
  ["vehicleSearch"] = "g",
  ["vehicleHotwire"] = "h",
  ["vehicleBelt"] = "b",
  ["vehicleDoors"] = "l",
  ["vehicleSlights"] = "q",
  ["vehicleSsound"] = "leftalt",
  ["vehicleSnavigate"] = "r",
  ["newsTools"] = "h",
  ["newsNormal"] = "e",
  ["newsMovie"] = "m",
  ["housingMain"] = "h",
  ["housingSecondary"] = "g",
  ["heliCam"] = "e",
  ["helivision"] = "inputaim",
  ["helirappel"] = "x",
  ["helispotlight"] = "g",
  ["helilockon"] = "space",
}

function URP.SettingsData.getSettingsTable()
  return URP.Settings.Current
end

RegisterNUICallback('settings', function()
  local controls = URP.DataControls.getBindTable()
  local settings = URP.SettingsData.getSettingsTable()
  SendNUIMessage({openSection = "settings", currentControls = controls, currentSettings = settings})
end)


RegisterNUICallback('settingsResetToko', function()
  TriggerEvent("urp-base:cl:player_reset","tokovoip")
end)

RegisterNUICallback('settingsResetControls', function()
  TriggerEvent("urp-base:cl:player_control",nil)
end)