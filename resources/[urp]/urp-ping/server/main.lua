cid = nil
RegisterNetEvent('urp-ping:getcid')
AddEventHandler('urp-ping:getcid', function(cid)
	cid = cid
	return cid
end)
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	TriggerEvent('urp-ping:getcid', cid)
	local id = cid
	local result = MySQL.Sync.fetchAll("SELECT * FROM __characters WHERE id = @id", {['@id'] = id})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			id = identity['id'],
			firstname = identity['first_name'],
			lastname = identity['last_name'],
			dateofbirth = identity['dob'],
			sex = identity['gender']

		}
	else
		return nil
	end
end

RegisterCommand('ping', function(source, args, rawCommand)
    local name = getIdentity(source)
	if args[1] ~= nil then
        if args[1]:lower() == 'accept' then
            TriggerClientEvent('urp-ping:client:AcceptPing', source)
        elseif args[1]:lower() == 'reject' then
            TriggerClientEvent('urp-ping:client:RejectPing', source)
        else
            local tSrc = tonumber(args[1])
            if source ~= tSrc then
                TriggerClientEvent('urp-ping:client:SendPing', tSrc, name.first_name .. ' ' .. name.last_name, source)
            else
                TriggerClientEvent('DoLongHudText', source, 'Can\'t Ping Yourself', 1)
            end
        end
    end
end, false)

RegisterServerEvent('urp-ping:server:SendPingResult')
AddEventHandler('urp-ping:server:SendPingResult', function(id, result)
    local name = getIdentity(source)
	if result == 'accept' then
		TriggerClientEvent('DoLongHudText', id, name.first_name .. ' ' .. name.last_name .. "'s Accepted Your Ping", 1)
	elseif result == 'reject' then
		TriggerClientEvent('DoLongHudText', id, name.first_name .. ' ' .. name.last_name .. "'s Rejected Your Ping", 1)
	elseif result == 'timeout' then
		TriggerClientEvent('DoLongHudText', id, name.first_name .. ' ' .. name.last_name .. "'s Did Not Accept Your Ping", 1)
	elseif result == 'unable' then
		TriggerClientEvent('DoLongHudText', id, name.first_name .. ' ' .. name.last_name .. "'s Was Unable To Receive Your Ping", 1)
	elseif result == 'received' then
		TriggerClientEvent('DoLongHudText', id, 'You Sent A Ping To ' .. name.first_name .. ' ' .. name.last_name .. '.', 1)
	end
end)
