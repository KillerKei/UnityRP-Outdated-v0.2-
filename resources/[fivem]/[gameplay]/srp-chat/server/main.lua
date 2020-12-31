--[[

  urpCore RP Chat

--]]

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    end)
  
  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  --    local name = getIdentity(source)
  --    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 
  --[[TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('urp-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)


 RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

 RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)]]--

 --[[RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    local fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message advert"><div class="chat-message-header"style="font-weight: bold;">{0}:</div><div class="chat-message-body">{1}</div></div>',
        args = {"AD " .. name.firstname .. ' ' ..name.lastname .. ' ', msg }
    })
end, false)]]--

RegisterServerEvent('chat:oocmessage')
AddEventHandler('chat:oocmessage', function(cid, firstname, lastname, dob, gender, message)
    local playerName = GetPlayerName(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message tweet"><b>OOC {0} [{1}] :</b> {2}</div>',
        args = {firstname .. ' ' ..lastname .. ' ', source, message }
    })
    PerformHttpRequest("https://discord.com/api/webhooks/780108039440171039/xcDZHxMACy-mkybcIvgpvWd5yFxiaOMkE_e2cUWKOvQNgmgLDWP0w_GDc_fu_tXAItrI", function(err, text, headers) end, 'POST', json.encode({username = playerName .. " [" .. source .. "]", content = "OOC Message : " .. message, tts = false}), { ['Content-Type'] = 'application/json' })
end)


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
