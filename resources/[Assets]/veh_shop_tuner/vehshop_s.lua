local carTable = {}

RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(name, model, costs, financed)
    local source = source
    TriggerClientEvent('FinishMoneyCheckForVeh', source, name, model, costs, financed)
end)

RegisterServerEvent('BuyForVeh')
AddEventHandler('BuyForVeh', function(cid, plate, name, model, vehicle, price, personalvehicle, financed, amount_due)
    if financed == true then
        exports.ghmattimysql:execute('INSERT INTO __vehicles(cid, plate, name, model, vehicle, price, personalvehicle, financed, amount_due, last_payment) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {cid, plate, name, model, json.encode(vehicle), price, personalvehicle, financed, amount_due, 2880})
        TriggerClientEvent("veh_shop_tuner:setPlate", source, vehicle, plate)
    else
        exports.ghmattimysql:execute('INSERT INTO __vehicles(cid, plate, name, model, vehicle, price, personalvehicle, financed, amount_due, last_payment) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {cid, plate, name, model, json.encode(vehicle), price, personalvehicle, financed, 0, 0})
        TriggerClientEvent("veh_shop_tuner:setPlate", source, vehicle, plate)
    end
end)

RegisterServerEvent('carshop:table69')
AddEventHandler('carshop:table69', function(data)
    TriggerClientEvent('veh_shop_tuner:returnTable', -1, data)
    carTable = data
end)

RegisterServerEvent('finance:enable')
AddEventHandler('finance:enable', function(plate)
    TriggerClientEvent('finance:enableOnClient', -1, plate)
end)

RegisterServerEvent('carshop:requesttable')
AddEventHandler('carshop:requesttable', function()
    local src = source
    TriggerClientEvent('veh_shop_tuner:returnTable', src, carTable)
end)

RegisterServerEvent('repo:car')
AddEventHandler('repo:car', function(plate, netID)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __vehicles WHERE `plate`= ?', {plate}, function(data)
        Citizen.Wait(3500)
        if data[1] ~= nil then
            if data[1].amount_due > 0 and data[1].last_payment <= 0 then
                exports.ghmattimysql:execute("DELETE FROM __vehicles WHERE `plate`= ?", {data[1].plate})
                TriggerClientEvent('repo:success', src, netID)
            else
                TriggerClientEvent('DoLongHudText', src, "This vehicle is not up for reposession currently.", 2)
            end
        end
    end)
end)