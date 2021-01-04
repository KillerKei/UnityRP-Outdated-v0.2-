
local license = 0

local licenseArray = {}

job = nil

RegisterServerEvent('sec:checkRobbed')
AddEventHandler('sec:checkRobbed', function(license)

local _source = source

if licenseArray[#licenseArray] ~= nil then
    for k, v in pairs(licenseArray) do
        if v == license then
        print('Bitch')
        return
        end
    end
end

licenseArray[#licenseArray+1] = license

    TriggerClientEvent('sec:AllowHeist', _source)
end)

RegisterServerEvent('urp-securityheists:gatherjob')
AddEventHandler('urp-securityheists:gatherjob', function(jobname)
    job = jobname
    print(job)
end)

RegisterServerEvent('irp-securityheists:banktstart')
AddEventHandler('irp-securityheists:banktstart', function(license)
    local copcount = 0

    for i = 1, 50, 1 do

        if xPlayer.job.name == "police" then
            copcount = copcount + 1
        end
    end
    if copcount >= 4 then
	    local xPlayer = irpCore.GetPlayerFromId(source)
        TriggerClientEvent('sec:usegroup6card', source)
        TriggerClientEvent('inventory:removeItem', source, 'Gruppe6Card', 1)
    else
        TriggerClientEvent('DoLongHudText', source, 'There is not enough police on duty!', 2)
    end
end)