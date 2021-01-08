RegisterServerEvent('urp-hunting:giveloadout')
AddEventHandler('urp-hunting:giveloadout', function()
    TriggerClientEvent('player:receiveItem', source, '100416529', 1)
end)

RegisterServerEvent('urp-hunting:removeloadout')
AddEventHandler('urp-hunting:removeloadout', function()
    TriggerClientEvent('inventory:removeItem', source, '100416529', 1)
end)