local src = source
cash = 0

local stolenGoodsTable = {
	[84] = "stolencasiowatch",
	[85] = "rolexwatch",
	[86] = "stoleniphone",
	[87] = "stolens8",
	[88] = "stolennokia",
	[89] = "stolenpixel3",
	[90] = "stolen2ctchain",
	[91] = "stolen5ctchain",
	[92] = "stolen8ctchain",
	[93] = "stolen10ctchain",
	[94] = "stolenraybans",
	[95] = "stolenoakleys",
	[96] = "stolengameboy",
	[97] = "stolenpsp",
}

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function()
    local source = source
    if cash >= 100 then
        TriggerClientEvent('cash:add', 100)
        print("cash")
        TriggerEvent('drugdelivery:startDealing', source)
        TriggerClientEvent('drugdelivery:client', source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You do not have enough money to start!', 2)
    end
end)

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local source = source
    local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
    local Player = LocalPlayer:getCurrentCharacter()
    if cash >= money then
        TriggerClientEvent("banking:removeCash", money)
        TriggerClientEvent('oxydelivery:startDealing', source)
        TriggerClientEvent('oxydelivery:client', source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You do not have enough money to start!', 2)
    end
end)

RegisterServerEvent('delmission:completed')
AddEventHandler('delmission:completed', function(money)
    local source = source
    if money ~= nil then
        TriggerClientEvent('cash:add', money)
    end
end)

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

RegisterServerEvent('urp-drugdeliveries:amount')
AddEventHandler('urp-drugdeliveries:amount', function(amountofcash)
    cash = amountofcash
end)
