RegisterServerEvent('server:givepayJob')
AddEventHandler('server:givepayJob', function(money)
    local source = source
    local LocalPlayer = exports['urp-base']:getModule('LocalPlayer')
    if money ~= nil then
       TriggerClientEvent('cash:add', source, money)
    end
end)