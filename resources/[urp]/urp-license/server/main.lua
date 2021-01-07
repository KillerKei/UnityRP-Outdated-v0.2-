cid = nil
job = nil

RegisterServerEvent('urp-license:pass', function(cid, job)
	cid = cid
	job = job
end)

RegisterCommand('givelicense', function(source, cb)
	local src = source
	local myPed = GetPlayerPed(src)
	local myPos = GetEntityCoords(myPed)
  
	for k, v in ipairs(GetPlayers()) do
		if v ~= src then
	  local xTarget = GetPlayerPed(v)
	  local tPos = GetEntityCoords(xTarget)
	  local dist = #(vector3(tPos.x, tPos.y, tPos.z) - myPos)
		
	  if dist < 1 and job == 'Police' then -- job goes here
		TriggerEvent('cash:remove', 2500) -- change price here
		TriggerEvent('urp-license:checkLicense', v, 'weapon', function(cb)
		  if cb == false then 
			TriggerEvent('urp-license:addLicense', v, 'weapon', function()
			end)
			TriggerClientEvent('DoLongHudText', source, 'You have given a License to Carry a Weapon to ID - [' .. v .. '] for $2500.' , 1) -- price also changes here
			TriggerClientEvent('DoLongHudText', v, 'You have given a License to Carry a Weapon for $2500.', 1) -- price also changes here
		  else
			TriggerClientEvent('DoLongHudText', source, 'Failed. ID [ ' .. v .. ' ] already has a license.' , 2) -- price also changes here
		  end
		end)
	  end
		end
	end
  end)

function AddLicense(target, type, cb)
	MySQL.Async.execute(
		'INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)',
		{
			['@type']  = type,
			['@owner'] = cid
		}, function(rowsChanged)
			if cb ~= nil then
				cb()
			end
		end
	)
end

function RemoveLicense(target, type, cb)
	MySQL.Async.execute(
		'DELETE FROM user_licenses WHERE type = @type AND owner = @owner',
		{
			['@type']  = type,
			['@owner'] = cid
		}, function(rowsChanged)
			if cb ~= nil then
				cb()
			end
		end
	)
end

function GetLicense(type, cb)
	MySQL.Async.fetchAll(
		'SELECT * FROM licenses WHERE type = @type',
		{
			['@type'] = type
		}, function(result)
			local data = {
				type  = type,
				label = result[1].label
			}

			cb(data)
		end
	)
end

function GetLicenses(target, cb)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_licenses WHERE owner = @owner',
		{
			['@owner'] = cid
		}, function(result)
			local licenses   = {}
			local asyncTasks = {}

			for i=1, #result, 1 do

				local scope = function(type)
					table.insert(asyncTasks, function(cb)
						MySQL.Async.fetchAll(
							'SELECT * FROM licenses WHERE type = @type',
							{
								['@type'] = type
							}, function(result2)

								table.insert(licenses, {
									type  = type,
									label = result2[1].label
								})
								cb()
							end
						)
					end)
				end
				scope(result[i].type)
			end

			Async.parallel(asyncTasks, function(results)
				cb(licenses)
			end)

		end
	)
end

function CheckLicense(target, type, cb)
	MySQL.Async.fetchAll(
		'SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner',
		{
			['@type']  = type,
			['@owner'] = cid
		}, function(result)
			if tonumber(result[1].count) > 0 then
				cb(true)
			else
				cb(false)
			end

		end
	)
end

function GetLicensesList(cb)
	MySQL.Async.fetchAll(
		'SELECT * FROM licenses',
		{
			['@type'] = type
		}, function(result)
			local licenses = {}

			for i=1, #result, 1 do
				table.insert(licenses, {
					type  = result[i].type,
					label = result[i].label
				})
			end
			cb(licenses)
		end
	)
end

RegisterNetEvent('urp-license:addLicense')
AddEventHandler('urp-license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

RegisterNetEvent('urp-license:removeLicense')
AddEventHandler('urp-license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

AddEventHandler('urp-license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('urp-license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)
RegisterServerEvent('urp-license:checkLicense')
AddEventHandler('urp-license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('urp-license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)