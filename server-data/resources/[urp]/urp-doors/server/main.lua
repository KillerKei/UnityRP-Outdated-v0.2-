local DoorInfo	= {}

RegisterServerEvent('urp-doors:updateState')
AddEventHandler('urp-doors:updateState', function(doorID, state)
	if type(doorID) ~= 'number' then
		return
	end
	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('urp-doors:setState', -1, doorID, state)
end)

RegisterServerEvent("urp-doors:jailbreak")
AddEventHandler("urp-doors:jailbreak", function()
    local _source = source
	TriggerClientEvent('urp-alerts:jailinProgress', -1)
	TriggerClientEvent('urp-doors:UseRedKeycard2',source)
end)

RegisterServerEvent("urp-doors:jailbreak2")
AddEventHandler("urp-doors:jailbreak2", function()
    local _source = source
	TriggerClientEvent('urp-doors:UseRedKeycard3',source)
end)

RegisterServerEvent("urp-doors:jailbreak3")
AddEventHandler("urp-doors:jailbreak3", function()
    local _source = source
	TriggerClientEvent('urp-doors:UseRedKeycard4',source)
end)

RegisterServerEvent('urp-doors:getDoorInfo')
AddEventHandler('urp-doors:getDoorInfo', function()
	local src = source
	TriggerClientEvent('urp-doors:getDoorInfo', src, DoorInfo, #DoorInfo)
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return false
end