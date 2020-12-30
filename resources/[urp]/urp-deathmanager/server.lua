RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
    if target ~= nil then
        TriggerClientEvent('admin:revivePlayerClient', target)
        TriggerClientEvent('urp-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('urp-hospital:client:ResetLimbs', target)
    end
end)