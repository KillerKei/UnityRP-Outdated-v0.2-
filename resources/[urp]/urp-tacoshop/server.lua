
RegisterServerEvent('weed:checkmoney')
AddEventHandler('weed:checkmoney', function()
local source = source
-- local xPlayer  = irpCore.GetPlayerFromId(source)
    TriggerClientEvent('weed:successStart', source)
end)

-- RegisterServerEvent('mission:finished')
-- AddEventHandler('mission:finished', function(money)
--     local source = source
--     local xPlayer  = irpCore.GetPlayerFromId(source)
--     if money ~= nil then
--         xPlayer.addMoney(money)
--     end
-- end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,14))
end)