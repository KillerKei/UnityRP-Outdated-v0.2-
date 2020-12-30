SetDiscordAppId(762404987397341224)

SetDiscordRichPresenceAsset('logo')



local WaitTime = 100 -- How often do you want to update the status (In MS)



Citizen.CreateThread(function()

	while true do

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))

		local StreetHash = GetStreetNameAtCoord(x, y, z)



	    local onlinePlayers = 0

		for i = 0, 255 do

			if NetworkIsPlayerActive(i) then

				onlinePlayers = onlinePlayers+1

			end

		end



		Citizen.Wait(WaitTime)

		if StreetHash ~= nil then

			StreetName = GetStreetNameFromHashKey(StreetHash)

			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then

				  if not IsEntityInArea(PlayerPedId(),2631.851,2572.982,45.096,-2449.445,711.613,264.987,false,false,0) then

           if IsPedSprinting(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif IsPedRunning(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif IsPedWalking(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif IsPedStill(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")
				end

				else

				if IsPedRunning(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) > 2.0 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif not IsPedRunning(PlayerPedId()) and GetEntitySpeed(PlayerPedId()) > 1.0 and GetEntitySpeed(PlayerPedId()) < 2.0 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				else

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				end

				end

			elseif IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then

				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.23693629205)

				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))

				if MPH > 50 and not IsPedOnAnyBike(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif MPH <= 50 and MPH > 0  then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif MPH == 0 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif MPH > 50 and IsPedOnAnyBike(PlayerPedId()) then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				end

			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then

				local KT = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.9438444924406046)

				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))

				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 25.0 and KT>90 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT < 90 and KT>40 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId(), false)) == 0 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				elseif GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT >= 90 and KT < 120 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId())) == 0 then

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				else

					SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

				end

			elseif IsEntityInWater(PlayerPedId()) then

				SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then

				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))

				SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then

				SetRichPresence(onlinePlayers.."/50 | Eating Chicken")

			end

		end

	end

end)