irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj)
    irpCore = obj
end)

RegisterServerEvent('irp-interactions:putInVehicle')
AddEventHandler('irp-interactions:putInVehicle', function(target)
    TriggerClientEvent('irp-interactions:putInVehicle', target)
end)

RegisterServerEvent('irp-interactions:outOfVehicle')
AddEventHandler('irp-interactions:outOfVehicle', function(target)
    TriggerClientEvent('irp-interactions:outOfVehicle', target)
end)
