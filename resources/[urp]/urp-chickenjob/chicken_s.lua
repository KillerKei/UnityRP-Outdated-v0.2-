RegisterServerEvent('cunt:pay')
AddEventHandler('cunt:pay', function(money)
    local source = source
    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    if money ~= nil then
       TriggerClientEvent('cash:add', source, money)
       TriggerClientEvent('DoLongHudText', source, 'You got $'.. money .. ' for 1 chicken', 1)
    end
end)