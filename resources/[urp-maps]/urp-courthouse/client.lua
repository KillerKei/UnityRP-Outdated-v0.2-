Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local Getmecuh = PlayerPedId()
		local drawtext = "~b~ E ~w~- To enter courthouse"
		local plyCoords = GetEntityCoords(Getmecuh)
		local x,y,z = 237.8211, -413.0868, 48.11193
		local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z ,false)
		if distance <= 1.2 then
			DrawText3Ds(x,y,z, drawtext) 
			if IsControlJustReleased(0, 38) then
				Citizen.Wait(500)
				DoScreenFadeOut(400)
				Citizen.Wait(500)
				SetEntityCoords(Getmecuh, 227.4555, -423.2317, -15.40781)
				Citizen.Wait(250)
				DoScreenFadeIn(250)
			end
		else
			if distance >= 1.2 then
				Citizen.Wait(1000)
				
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local Getmecuh = PlayerPedId()
		local drawtext2 = "~b~ E ~w~- Exit courthouse"
		local x,y,z = 227.449, -423.1863, -16.00754
		local plyCoords = GetEntityCoords(Getmecuh)
		local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z ,false)
		if distance <= 1.2 then
			DrawText3Ds(x,y,z, drawtext2) 
			if IsControlJustReleased(0, 38) then
				Citizen.Wait(500)
				DoScreenFadeOut(400)
				Citizen.Wait(500)
				SetEntityCoords(Getmecuh, 233.0308, -411.045, 48.11195)
				Citizen.Wait(250)
				DoScreenFadeIn(250)
			end
		else
			if distance >= 1.2 then
				Citizen.Wait(1000)
				
			end
		end
	end
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end