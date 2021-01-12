


RegisterServerEvent("mech:check:materials")
AddEventHandler("mech:check:materials", function()
    local src = source
    exports.ghmattimysql:execute("SELECT * FROM mech_materials",{}, function(result)
        if result ~= nil then
            print(result[1]['Aluminum'])
            local strng = "\n Aluminum - " .. result[1]["Aluminum"] .. " \n Rubber - " .. result[1]["Rubber"] .. " \n Scrap - " .. result[1]["Scrap"] .. " \n Plastic - " .. result[1]["Plastic"] .. " \n Copper - " .. result[1]["Copper"] .. " \n Steel - " .. result[1]["Steel"] .. " \n Glass - " .. result[1]["Glass"]
            --TriggerClientEvent("DoLongHudText",src,strng)
            TriggerClientEvent("customNotification",src, strng)
            --TriggerClientEvent('chat:addMessage', src, { template = '<div class="chat-message jail"><b>'..strng..'</div>')
			--TriggerClientEvent("chatMessagess",-1, "OOC "..name..":  ", 2, strng)
        end
    end)

end)

RegisterServerEvent("mech:add:materials")
AddEventHandler("mech:add:materials", function(materials,amount)
    local src = source
    local addMaterials = 0
    TriggerClientEvent('inventory:removeItem',src,string.lower(materials), amount)
    exports.ghmattimysql:execute("SELECT * FROM mech_materials",{}, function(result)
        local set = ""
        local values = {}
        if materials == "Aluminum" or materials == "aluminum" then
             addMaterials = result[1]['Aluminum'] + amount
             set = "Aluminum = @Aluminum"
             values = {['Aluminum'] = addMaterials}
        elseif materials == "Rubber" or materials == "rubber" then
            addMaterials = result[1]['Rubber'] + amount
            set = "Rubber = @Rubber"
            values = {['Rubber'] = addMaterials}
        elseif materials == "Scrap" or materials == "scrap" then
            addMaterials = result[1]['Scrap'] + amount
            set = "Scrap = @Scrap"
            values = {['Scrap'] = addMaterials}
        elseif materials == "Plastic" or materials == "plastic" then
            addMaterials = result[1]['Plastic'] + amount
            set = "Plastic = @Plastic"
            values = {['Plastic'] = addMaterials}
        elseif materials == "Copper" or materials == "copper" then
            addMaterials = result[1]['Copper'] + amount
            set = "Copper = @Copper"
            values = {['Copper'] = addMaterials}
        elseif materials == "Steel" or materials == "steel" then
            addMaterials = result[1]['Steel'] + amount
            set = "Steel = @Steel"
            values = {['Steel'] = addMaterials}
        elseif materials == "Glass" or materials == "glass" then
            addMaterials = result[1]['Glass'] + amount
            set = "Glass = @Glass"
            values = {['Glass'] = addMaterials}
        end
        print('Adding materials', firstToUpper(materials),addMaterials, set)
        AddMaterials(firstToUpper(materials),addMaterials,set,values)

    --     local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
    --     MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE identifier = @identifier", values)
    -- exports.ghmattimysql:execute("UPDATE mech_materials SET ()")


    end)
    
end)

RegisterServerEvent("mech:remove:materials")
AddEventHandler("mech:remove:materials", function(materials,amount)
    local src = source
    local addMaterials = 0
    if amount == nil then
        TriggerClient('DoShotHudText',src, 'Are you crazy?', 2) 
        return
    end
    exports.ghmattimysql:execute("SELECT * FROM mech_materials",{}, function(result)
        local set = ""
        local values = {}
        if materials == "Aluminum" or materials == "aluminum" then
             addMaterials = result[1]['Aluminum'] - amount
             set = "Aluminum = @Aluminum"
             values = {['Aluminum'] = addMaterials}
        elseif materials == "Rubber" or materials == "rubber" then
            addMaterials = result[1]['Rubber'] - amount
            set = "Rubber = @Rubber"
            values = {['Rubber'] = addMaterials}
        elseif materials == "Scrap" or materials == "scrap" then
            addMaterials = result[1]['Scrap'] - amount
            set = "Scrap = @Scrap"
            values = {['Scrap'] = addMaterials}
        elseif materials == "Plastic" or materials == "plastic" then
            addMaterials = result[1]['Plastic'] - amount
            set = "Plastic = @Plastic"
            values = {['Plastic'] = addMaterials}
        elseif materials == "Copper" or materials == "copper" then
            addMaterials = result[1]['Copper'] - amount
            set = "Copper = @Copper"
            values = {['Copper'] = addMaterials}
        elseif materials == "Steel" or materials == "steel" then
            addMaterials = result[1]['Steel'] - amount
            set = "Steel = @Steel"
            values = {['Steel'] = addMaterials}
        elseif materials == "Glass" or materials == "glass" then
            addMaterials = result[1]['Glass'] - amount
            set = "Glass = @Glass"
            values = {['Glass'] = addMaterials}
        end
        print('Adding materials', firstToUpper(materials),addMaterials, set)
        AddMaterials(firstToUpper(materials),addMaterials,set,values)

    --     local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
    --     MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE identifier = @identifier", values)
    -- exports.ghmattimysql:execute("UPDATE mech_materials SET ()")


    end)
    
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function AddMaterials(materials,amount,set,values)
    print("my materials to add ",materials,amount,set,values)
    -- local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
    --     MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE identifier = @identifier", values)
     exports.ghmattimysql:execute("UPDATE mech_materials SET "..set.."", values)
end

-- chopshop

RegisterServerEvent('urp-chopshop:addCash')
AddEventHandler('urp-chopshop:addCash', function()
	local _source = source
	local randomChance = math.random(0, 2)
	local money = math.random(100, 250)
	local payout = math.random(2,4)
	if source ~= nil then	
		if randomChance == 0 then
			Citizen.Wait(5)
			TriggerClientEvent('player:receiveItem', _source,'scrapmetal', payout)
			TriggerClientEvent('player:receiveItem', _source, 'rubber', payout)
		elseif randomChance == 1 then
			Citizen.Wait(5)
			TriggerClientEvent('player:receiveItem', _source, 'glass', payout)
			TriggerClientEvent('player:receiveItem', _source, 'steel', payout)
			TriggerClientEvent('player:receiveItem', _source, 'plastic', payout)
		elseif randomChance == 2 then
			TriggerClientEvent('player:receiveItem', _source, 'electronics', payout)
			TriggerClientEvent('player:receiveItem', _source, 'aluminium', payout)
			TriggerClientEvent('player:receiveItem', _source, 'copper', payout)
		end
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM '..Config.SQLOwnedVehicleTable..' WHERE '..Config.SQLVehiclePlateColoumn..' = @'..Config.SQLVehiclePlateColoumn, {
		['@'..Config.SQLVehiclePlateColoumn] = plate
	})
end

function SaveInfoToDatabase(plate, ownername, choppedcarname, choppername, chopperidentifier)
	MySQL.Async.execute('INSERT INTO '..Config.SQLChopInfoTable..' ('..Config.SQLChopPlateColoumn..', '..Config.SQLChopCarOwnerColoumn..', '..Config.SQLChopCarModelColoumn..', '..Config.SQLChoppperNameColoumn..', '..Config.SQLChoppperIdentifierColoumn..') VALUES (@'..Config.SQLChopPlateColoumn..', @'..Config.SQLChopCarOwnerColoumn..', @'..Config.SQLChopCarModelColoumn..', @'..Config.SQLChoppperNameColoumn..', @'..Config.SQLChoppperIdentifierColoumn..')',
	{
		['@'..Config.SQLChopPlateColoumn]   = plate,
		['@'..Config.SQLChopCarOwnerColoumn]   = ownername,
		['@'..Config.SQLChopCarModelColoumn]   = choppedcarname,
		['@'..Config.SQLChoppperNameColoumn]   = choppername,
		['@'..Config.SQLChoppperIdentifierColoumn]   = chopperidentifier,

	}, function (rowsChanged)
	end)
end

-- irpCore.RegisterServerCallback('urp-chopshop:isdead', function(source, cb)
-- 	local identifier = GetPlayerIdentifiers(source)[1]

-- 	MySQL.Async.fetchScalar('SELECT '..Config.SQLPlayerIsDeadColoumn..' FROM '..Config.SQLPlayerInfoTable..' WHERE '..Config.SQLPlayerIdentifierColoumn..' = @'..Config.SQLPlayerIdentifierColoumn, {
-- 		['@'..Config.SQLPlayerIdentifierColoumn] = identifier
-- 	}, function(isDead)
-- 		cb(isDead)
-- 	end)
-- end)

-- irpCore.RegisterServerCallback('urp-chopshop:getVehInfos', function(source, cb, plate)
-- 	MySQL.Async.fetchAll('SELECT '..Config.SQLVehicleOwnerColoumn..' FROM '..Config.SQLOwnedVehicleTable..' WHERE '..Config.SQLVehiclePlateColoumn..' = @'..Config.SQLVehiclePlateColoumn, {
-- 		['@'..Config.SQLVehiclePlateColoumn] = plate
-- 	}, function(result)
-- 		local retrivedInfo = {
-- 			plate = plate
-- 		}
-- 		if result[1] then
-- 			MySQL.Async.fetchAll('SELECT '..Config.SQLPlayerNameColoumn..', '..Config.SQLPlayerFirstNameColoumn..', '..Config.SQLPlayerLastNameColoumn..' FROM '..Config.SQLPlayerInfoTable..' WHERE '..Config.SQLPlayerIdentifierColoumn..' = @'..Config.SQLPlayerIdentifierColoumn,  {
-- 				['@'..Config.SQLPlayerIdentifierColoumn] = result[1].owner
-- 			}, function(result2)

-- 				if Config.EnableirpCoreIdentity then
-- 					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
-- 				else
-- 					retrivedInfo.owner = result2[1].name
-- 				end

-- 				cb(retrivedInfo)
-- 			end)
-- 		else
-- 			cb(retrivedInfo)
-- 		end
-- 	end)
-- end)



































































































































































































































































































































Citizen.CreateThread(function()
	print('^4Coded for UnityRP By Keiron')
end)