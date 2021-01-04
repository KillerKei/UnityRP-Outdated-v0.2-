Citizen.CreateThread(function()
    Citizen.Wait(2000)
    print('[urp-inventory]: Authorized.')
end)

RegisterServerEvent('server-inventory-request-identifier')
AddEventHandler('server-inventory-request-identifier', function()
    local src = source
    TriggerClientEvent('inventory-client-identifier', src)
end)

RegisterServerEvent('urp-inventory:openInventorySteal')
AddEventHandler('urp-inventory:openInventorySteal', function(target)
    local source = source
    -- print(source)
    if target ~= nil then
        -- print(target)
        local steam = GetPlayerIdentifiers(target)[1]
        local userData = promise:new()

        exports.ghmattimysql:execute('SELECT uid FROM __users WHERE steam = ?', {steam}, function(data)
            userData:resolve(data)
        end)

        local uid = Citizen.Await(userData)
        local user = exports['urp-base']:getModule("Player")
        local char = user:getCurrentCharacter(uid[1].uid)
        exports.ghmattimysql:execute('SELECT cash FROM __characters WHERE id = ?', {char.id}, function(data)
            TriggerClientEvent('cash:add', source, data[1].cash)
        end)
        TriggerClientEvent('urp-base:setCash', target, char.id, 0)
        TriggerClientEvent('urp-inventory:openInventorySteal', source, char)
    end
end)

RegisterServerEvent('loot:useItem')
AddEventHandler('loot:useItem', function(itemid)

end)

RegisterServerEvent('idcard:run')
AddEventHandler('idcard:run', function(data)
    local data = json.decode(data)
    local firstname = data.Name
    local lastname = data.Surname
    local sex = data.Sex
    local dob = data.DOB
    local Identifier = data.Identifier
    local src = source
    local myPed = GetPlayerPed(src)
    local sourcePlayer = tonumber(source)
    local players = GetPlayers()
    local myPos = GetEntityCoords(myPed)
    if firstname ~= nil and lastname ~= nil and sex ~= nil and dob ~= nil then
        TriggerClientEvent('chat:addMessage', source, {
            color = 9,
            multiline = false,
            templateId = "defaultAlt",
            args = {DOB = dob, Name = firstname, Surname = lastname, Sex = sex, Identifier = Identifier, pref = "None"}
        })
    end
    for k, v in ipairs(players) do
        if v ~= src then
            local xTarget = GetPlayerPed(v)
            local tPos = GetEntityCoords(xTarget)
            local dist = #(vector3(tPos.x, tPos.y, tPos.z) - myPos)
            if dist < 2 then 
                if firstname ~= nil and lastname ~= nil and sex ~= nil and dob ~= nil then
                    TriggerClientEvent('chat:addMessage', v, {
                        color = 9,
                        multiline = false,
                        templateId = "defaultAlt",
                        args = {DOB = dob, Name = firstname, Surname = lastname, Sex = sex, Identifier = Identifier, pref = "None"}
                    })
                end
            end
        end
    end
end)