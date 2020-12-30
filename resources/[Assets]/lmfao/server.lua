RegisterServerEvent('mission:completed')
AddEventHandler('mission:completed', function(money)
    local source = source
    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    if money ~= nil then
       TriggerClientEvent('cash:add', source, money)
       TriggerClientEvent('DoLongHudText', source, 'You got $'.. money .. ' for 5 Loose Buds of Weed.', 1)
    end
end)

RegisterServerEvent('missionSystem:caughtMoney')
AddEventHandler('missionSystem:caughtMoney', function(money)
    local source = source
    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    if money ~= nil then
       TriggerClientEvent('cash:add', source, money)
       TriggerClientEvent('DoLongHudText', source, 'You got $'.. money .. ' for 5 Loose Buds of Weed.', 1)
    end
end)