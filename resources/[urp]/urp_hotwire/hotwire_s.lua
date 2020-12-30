local vehicleKeys = {}
local myVehicleKeys = {}

local robbableItems = {
 [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(1, 16)}, -- really common
 [2] = {chance = 6, id = 1, name = 'Keys', isWeapon = false}, -- rare
 [3] = {chance = 3, id = 'chips', name = 'Chips', quantity = 1}, -- really common
 [4] = {chance = 5, id = 'oxy', name = 'Vicodin', quantity = 1}, -- rare
 [5] = {chance = 8, id = '2578778090', name = 'Knife', quantity = 1}, -- super rare
 [6] = {chance = 7, id = 'binoculars', name = 'Binoculars', quantity = 1}, -- rare
 [7] = {chance = 8, id = 'highgradefemaleseed', name = '(HG) Female Seed', quantity = 1},
 [8] = {chance = 7, id = 'lowgradefemaleseed', name = '(LG) Female Seed', quantity = 1},
 [9] = {chance = 8, id = 'highgrademaleseed', name = '(HG) Male Seed', quantity = 1},
 [10] = {chance = 7, id = 'lowgrademaleseed', name = '(LG) Male Seed', quantity = 1},


}

RegisterServerEvent('garage:searchItem')
AddEventHandler('garage:searchItem', function(plate)
 local source = tonumber(source)
 local item = {}
 local ident = GetPlayerIdentifiers(source)[1]

  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 then
    TriggerClientEvent('garage:addCash', source, item.quantity)
    TriggerClientEvent("DoLongHudText", source, 'You found $'..item.quantity)
   elseif tonumber(item.id) == 1 then
    TriggerClientEvent("DoLongHudText", source, 'You have found the keys to the vehicle!')
    vehicleKeys[plate] = {}
    table.insert(vehicleKeys[plate], {id = ident})
    TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
    TriggerClientEvent('vehicle:start', source)
   else
    TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
    TriggerClientEvent("DoLongHudText", source, 'Item Added!')
   end
  else
    TriggerClientEvent("DoLongHudText", source, 'You found nothing', 2)
  end
end)


--[[URPCore.RegisterServerCallback('disc-hotwire:checkOwner', function(source, cb, plate)
  local player = URPCore.GetPlayerFromId(source)
  MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
      ['@identifier'] = player.identifier,
      ['@plate'] = plate
  }, function(results)
      cb(#results == 1)
  end)
end)]]--

RegisterServerEvent('garage:giveKey')
AddEventHandler('garage:giveKey', function(target, plate)
 local targetSource = tonumber(target)
 local ident = GetPlayerIdentifiers(targetSource)[1]
 local ident2 = GetPlayerIdentifiers(source)[1]
 local plate = tostring(plate)

 vehicleKeys[plate] = {}
 table.insert(vehicleKeys[plate], {id = ident})
 --TriggerClientEvent('chatMessage', targetSource, 'You just recieved keys to a vehicle')
 TriggerClientEvent("DoLongHudText", source, 'You just recieved keys to a vehicle')
 TriggerClientEvent('garage:updateKeys', targetSource, vehicleKeys, ident)
 --re-enable to only have one set of keys
 --TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident2)
end)

RegisterServerEvent('garage:addKeys')
AddEventHandler('garage:addKeys', function(plate)
 local source = tonumber(source)
 local ident = GetPlayerIdentifiers(source)[1]
 while plate == nil do
  Citizen.Wait(5)
 end

 if vehicleKeys[plate] ~= nil then
  table.insert(vehicleKeys[plate], {id = ident})
  TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
 else
  vehicleKeys[plate] = {}
  table.insert(vehicleKeys[plate], {id = ident})
  TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
 end
end)


RegisterServerEvent('garage:removeKeys')
AddEventHandler('garage:removeKeys', function(plate)
 local source = tonumber(source)
 local ident = GetPlayerIdentifiers(source)[1]
 if vehicleKeys[plate] ~= nil then
  for id,v in pairs(vehicleKeys[plate]) do
   if v.id == ident then
    table.remove(vehicleKeys[plate], id)
   end
  end
 end
 TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
end)

RegisterServerEvent('removelockpick')
AddEventHandler('removelockpick', function()
 local source = tonumber(source)
 if math.random(1, 20) == 1 then
  TriggerClientEvent('player:receiveItem', source, "lockpick", 1)
  TriggerClientEvent("DoLongHudText", source, 'The lockpick bent out of shape.')
 end
end)
