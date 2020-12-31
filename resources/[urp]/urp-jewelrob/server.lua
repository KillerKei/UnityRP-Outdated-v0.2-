local state = false


RegisterServerEvent('jewel:request')
AddEventHandler('jewel:request', function()
	return state
end)

RegisterServerEvent('jewel:hasrobbed')
AddEventHandler('jewel:hasrobbed', function(data)

    if data then
        state = true
    else
        state = false
    end

end)