RegisterNetEvent('urp-base:setRank')
AddEventHandler('urp-base:setRank', function(target, rank)
    local source = source
    if target ~= nil then
        TriggerClientEvent('urp-base:setRank', target, rank)
    end
end)
        
RegisterNetEvent('urp-base:setJob')
AddEventHandler('urp-base:setJob', function(target, job)
    local source = source
    if target ~= nil then
        TriggerClientEvent('urp-base:setJob', target, job)
    end
end)