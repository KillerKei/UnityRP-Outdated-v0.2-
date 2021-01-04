URP.Player = URP.Player or {}
URP.LocalPlayer = URP.LocalPlayer or {}

function GetRanks()
    return JobRanks
end

function GetJobs()
    return Jobs
end

local function GetUser()
    return URP.LocalPlayer
end

function URP.LocalPlayer.setVar(self, var, data)
    GetUser()[var] = data
end

function URP.LocalPlayer.getVar(self, var)
    return GetUser()[var]
end

function URP.LocalPlayer.setCurrentCharacterVar(self, var, data)
    if not data then return end
    GetUser()["character"][var] = data
end

function URP.LocalPlayer.getRank(self)
    return GetUser()["character"]["rank"]
end

function URP.LocalPlayer.setRank(self, cid, data)
    GetUser()["character"]["rank"] = data
    Citizen.Wait(250)
    TriggerEvent('isPed:updateRank', data)
    TriggerServerEvent('player:setRank', cid, GetUser()["character"]["rank"])
end

function URP.LocalPlayer.getJob(self)
    return GetUser()["character"]["job"]
end

function URP.LocalPlayer.setJob(self, cid, data)
    GetUser()["character"]["job"] = data
    Citizen.Wait(250)
    TriggerEvent('isPed:updateJob', data)
    TriggerServerEvent('urp-policejob:spawned')
    TriggerServerEvent('player:setJob', cid, GetUser()["character"]["job"])
end

function URP.LocalPlayer.addCash(self, cid, data)
    GetUser()["character"]["cash"] = GetUser()["character"]["cash"] + data
    Citizen.Wait(250)
    TriggerEvent("banking:addCash", data)
    TriggerEvent('isPed:setCash', GetUser()["character"]["cash"])
    TriggerServerEvent('player:addCash', cid, GetUser()["character"]["cash"])
end

function URP.LocalPlayer.removeCash(self, cid, data)
    GetUser()["character"]["cash"] = GetUser()["character"]["cash"] - data
    Citizen.Wait(250)
    TriggerEvent("banking:removeCash", data)
    TriggerEvent('isPed:setCash', GetUser()["character"]["cash"])
    TriggerServerEvent('player:removeCash', cid, GetUser()["character"]["cash"])
end

function URP.LocalPlayer.setCash(self, cid, data)
    GetUser()["character"]["cash"] = data
    Citizen.Wait(250)
    TriggerEvent("banking:addCash", data)
    TriggerEvent('isPed:setCash', GetUser()["character"]["cash"])
    TriggerServerEvent('player:setCash', cid, data)
end

function URP.LocalPlayer.addBank(self, cid, data)
    GetUser()["character"]["bank"] = GetUser()["character"]["bank"] + data
    Citizen.Wait(250)
    TriggerEvent('banking:addBalance', data)
    TriggerEvent('isPed:setBank', GetUser()["character"]["bank"])
    TriggerServerEvent('player:addBank', cid, GetUser()["character"]["bank"])
end

function URP.LocalPlayer.removeBank(self, cid, data)
    GetUser()["character"]["bank"] = GetUser()["character"]["bank"] - data
    Citizen.Wait(250)
    TriggerEvent('banking:removeBalance', data)
    TriggerEvent('isPed:setBank', GetUser()["character"]["bank"])
    TriggerServerEvent('player:removeBank', cid, GetUser()["character"]["bank"])
end

function URP.LocalPlayer.setBank(self, cid, data)
    GetUser()["character"]["bank"] = data
    Citizen.Wait(250)
    TriggerEvent('banking:addBalance', data)
    TriggerEvent('isPed:setBank', GetUser()["character"]["bank"])
    TriggerServerEvent('player:setBank', cid, data)
end

RegisterNetEvent('urp-phone:groupManageUpdateBank')
AddEventHandler('urp-phone:groupManageUpdateBank', function(cid, data)
    GetUser()["character"]["bank"] = data
    Citizen.Wait(250)
    TriggerEvent('isPed:setBank', GetUser()["character"]["bank"])
    -- print(GetUser()['character']['bank'])
    TriggerServerEvent('player:setBank', cid, GetUser()["character"]["bank"])
end)

function URP.LocalPlayer.saveFood(self, cid, data)
    GetUser()["character"]["food"] = data
end

function URP.LocalPlayer.saveWater(self, cid, data)
    GetUser()["character"]["water"] = data
end

function URP.LocalPlayer.saveArmor(self, cid, data)
    GetUser()["character"]["armor"] = data
end


function URP.LocalPlayer.setCurrentCharacter(self, data)
    if not data then return end
    GetUser():setVar("character", data)
end

function URP.LocalPlayer.getCurrentCharacter(self)
    return GetUser():getVar("character")
end

function URP.LocalPlayer.setCharacterValue(self, var, data)
    GetUser():getVar("character")[var] = data
end

RegisterNetEvent("urp-base:networkVar")
AddEventHandler("urp-base:networkVar", function(var, val)
    URP.LocalPlayer:setVar(var, val)
end)

RegisterNetEvent('urp-base:setCash')
AddEventHandler('urp-base:setCash', function(cid, data)
    GetUser()["character"]["cash"] = data
    Citizen.Wait(250)
    TriggerEvent("banking:addCash", data)
    TriggerEvent('isPed:setCash', GetUser()["character"]["cash"])
    TriggerServerEvent('player:setCash', cid, data)
end)

RegisterNetEvent('client:GroupPayment')
AddEventHandler('client:GroupPayment', function(job, amount)
    if GetUser()["character"]["job"] == job then
        GetUser()["character"]["cash"] = GetUser()["character"]["cash"] + amount
        Citizen.Wait(250)
        TriggerEvent("banking:addCash", amount)
        TriggerEvent('isPed:setCash', GetUser()["character"]["cash"])
        TriggerServerEvent('player:addCash', GetUser()["character"]["id"], GetUser()["character"]["cash"])
        TriggerEvent('DoLongHudText', "Congratulations, you just received " .. amount .. " for your company selling a vehicle!", 6)
    end
end)

RegisterNetEvent('urp-base:updateJob')
AddEventHandler('urp-base:updateJob', function(name, rank)
    GetUser()["character"]["job"] = name
    TriggerEvent('isPed:updateJob', name)
    TriggerServerEvent('urp-policejob:spawned')
    TriggerServerEvent('player:setJob', exports['isPed']:isPed('cid'), GetUser()["character"]["job"])
    GetUser()["character"]["rank"] = rank
    TriggerEvent('isPed:updateRank', rank)
    TriggerServerEvent('player:setRank', exports['isPed']:isPed('cid'), GetUser()["character"]["rank"])
end)

RegisterNetEvent('urp-base:updateBank')
AddEventHandler('urp-base:updateJob', function(bank, rank)
    GetUser()["character"]["bank"] = bank
    TriggerEvent('isPed:updateJob', name)
    TriggerServerEvent('urp-policejob:spawned')
    TriggerServerEvent('player:setJob', exports['isPed']:isPed('cid'), GetUser()["character"]["job"])
    GetUser()["character"]["rank"] = rank
    TriggerEvent('isPed:updateRank', rank)
    TriggerServerEvent('player:setRank', exports['isPed']:isPed('cid'), GetUser()["character"]["rank"])
end)