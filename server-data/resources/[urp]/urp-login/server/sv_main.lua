RegisterNetEvent('urp-login:getUserId')
AddEventHandler('urp-login:getUserId', function()
    local src = source
    local steam = GetPlayerIdentifiers(src)[1]


    exports.ghmattimysql:execute('SELECT uid FROM __users WHERE steam = ?', {steam}, function(data)
        TriggerClientEvent('urp-login:updateUId', src, data)
    end)

end)

RegisterNetEvent('urp-login:updateCharacters')
AddEventHandler('urp-login:updateCharacters', function(uid)
    local src = source
    local uId = uid
    

    exports.ghmattimysql:execute('SELECT * FROM __characters WHERE uid= ?', {uId}, function(data)
        TriggerClientEvent('urp-login:updateChars', src, data)
    end)

end)

RegisterNetEvent('urp-login:createCharacter')
AddEventHandler('urp-login:createCharacter', function(data, userid, pn)
    local src = source
    local phone = pn

    exports.ghmattimysql:execute('INSERT INTO __characters(first_name, last_name, dob, gender, phone_number, story, uid) VALUES(?, ?, ?, ?, ?, ?, ?)', {data.firstname, data.lastname, data.dob, data.gender, phone, data.story, userid})

end)

RegisterNetEvent('urp-login:deleteCharacter')
AddEventHandler('urp-login:deleteCharacter', function(data)
    local src = source

    exports.ghmattimysql:execute('DELETE FROM __characters WHERE id = ? LIMIT 1', {data})

end)

RegisterNetEvent("urp-login:disconnectPlayer")
AddEventHandler("urp-login:disconnectPlayer", function()
    local src = source

    DropPlayer(src, 'Later Cunt!')

end)