local banks = {
    [1] = {x = 146.88589477539, y = -1046.0769042969, z = 29.368082046509, h = 244.70774841309, recent = false, robbing = false, rob = {}},
    [2] = {x = -1210.7919921875, y = -336.4977722168, z = 37.781051635742, h = 296.38696289062, recent = false, robbing = false, rob = {}},
    [3] = {x = -2956.5356445312, y = 481.47354125977, z = 15.69708442688, h = 358.35528564453, recent = false, robbing = false, rob = {}},
    [4] = {x = 311.11526489258, y = -284.50228881836, z = 54.164810180664, h = 248.95367431641, recent = false, robbing = false, rob = {}},
    [5] = {x = -353.90893554688, y = -55.3796043396, z = 49.036602020264, h = 251.66346740723, recent = false, robbing = false, rob = {}},
    [6] = {x = 1176.0682373047, y = 2712.8735351562, z = 38.088050842285, h = 87.942642211914, recent = false, robbing = false, rob = {}}
}

local rAllowed = true
local oDoors = {}

RegisterNetEvent('urp-robbery:restartSoon')
AddEventHandler('urp-robbery:restartSoon', function()
    rAllowed = false
end)

RegisterNetEvent('urp-robbery:openSmallBankDoor')
AddEventHandler('urp-robbery:openSmallBankDoor', function(vType)
    print('Opening Door.?')
    local pCoords = GetEntityCoords(PlayerPedId())
    local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 15.0, vType, 0, 0, 0)

    if vDoor == 0 then return end
    local oFactor = 50

    FreezeEntityPosition(vDoor, false)
    local vDoorHeading = GetEntityHeading(vDoor)

    if oDoors[vDoor] == nil then
        if vType == -131754413 then
            oFactor = 90
            TriggerEvent("urp-robbery:smallVaultDrawBoxes" ,vDoor, true)
        else
            TriggerEvent("urp-robbery:smallVaultDrawBoxes" ,vDoor, false)
        end
        oDoors[vDoor] = true

        for i = 1, 78 do
            SetEntityHeading(vDoor, vDoorHeading - i)
            Citizen.Wait(12)
        end
    elseif oDoors[vDoor] ~= nil then
        if vType == -131754413 and not drawingBoxes then
            TriggerEvent("urp-robbery:smallVaultDrawBoxes",vDoor,true)
        else
            if vType ~= -131754413 and not drawingBoxesV then
                TriggerEvent("urp-robbery:smallVaultDrawBoxes",vDoor,false)
            end
        end
    end

    FreezeEntityPosition(vDoor, true)

end)

local drawingBoxes = false
local drawingBoxesV = false

RegisterNetEvent('urp-robbery:smallVaultDrawBoxes')
AddEventHandler('urp-robbery:smallVaultDrawBoxes', function(vDoor, vToggle)
    local dCoords = GetEntityCoords(vDoor)

    local x5,y5,z5 = table.unpack(GetOffsetFromEntityInWorldCoords(vDoor, 0.19, 1.2 + 0.0, 0.0))
    local x7,y7,z7 = table.unpack(GetOffsetFromEntityInWorldCoords(vDoor, 1.1, 3.5 + 0.0, 0.0))
    local x8,y8,z8 = table.unpack(GetOffsetFromEntityInWorldCoords(vDoor, 3.6, 4.1 + 0.0, 0.0))
    local x10,y10,z10 = table.unpack(GetOffsetFromEntityInWorldCoords(vDoor, 3.6, 0.5 + 0.0, 0.0))
    local x13,y13,z13 = table.unpack(GetOffsetFromEntityInWorldCoords(vDoor, 5.8, 2.4 + 0.0, 0.0))

    print('Tots')

    if not drawingBoxesV and not vToggle then
        print('Test')
        drawingBoxesV = true
        while drawingBoxesV do
            Citizen.Wait(1)
            DrawSmallBankBoxes(x5,y5,z5, 5)
            DrawSmallBankBoxes(x7,y7,z7, 7)
            DrawSmallBankBoxes(x8,y8,z8, 8)
            DrawSmallBankBoxes(x10,y10,z10, 10)
            DrawSmallBankBoxes(x13,y13,z13, 13)
        end
    end
end)

function DrawSmallBankBoxes(x, y, z, inputType)
    local distance = #(vector3(x, y, z) - GetEntityCoords(PlayerPedId()))
    if distance > 3.0 then return end

    local bText = '[E] - Search'
    local cBankId = GetBankId()

    local bRobbed = false

    if banks[cBankId]['rob'] then
        if banks[cBankId]['rob'][inputType] then
            bText = 'Empty'
            bRobbed = true
        end
    end

    if bRobbed then return end

    if distance < 1.0 then
        if IsControlJustPressed(0, 38) then
            local sTimer = 15000
            if inputType < 5 then
                sTimer = 20000
            end

            print(inputType)

            local finished = exports['urp-taskbar']:taskBar(1000, 'Searching')

            if finished == 100 then
                TriggerServerEvent('urp-robbery:sBankBox', cBankId, inputType)
            end

            Citizen.Wait(1000)
        end
    end

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(bText)
    DrawText(_x,_y)
    local factor = (string.len(bText)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local vaultCard = false

RegisterNetEvent('urp-robbery:sBankLoot')
AddEventHandler('urp-robbery:sBankLoot', function()

    
    if math.random(100) > 95 then
        if vaultCard then 
            print('penis')
        else
            TriggerEvent('player:receiveItem', 'Gruppe6Card22', 1)
            vaultCard = true
        end
    else
        local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
        local Player = LocalPlayer:getCurrentCharacter()
        LocalPlayer:addCash(Player.id, math.random(1500, 4500))
    end

    if math.random(100) > 45 then
        local pick = math.random(3)
        if pick == 1 then
            TriggerEvent("player:receiveItem", "goldbar", math.random(5, 15))
        elseif pick == 2 then
            TriggerEvent("player:receiveItem", "valuablegoods", math.random(1, 4))
        elseif pick == 3 then
            TriggerEvent("player:receiveItem", "rolexwatch", math.random(100, 500))
        end
    end
end)

RegisterNetEvent('urp-robbery:securityBlueUsed')
AddEventHandler('urp-robbery:securityBlueUsed', function()
    print('Working.')
    local bId = GetBankId()

    if not bId then return end
    if not rAllowed then
        TriggerServerEvent('DoLongHudText', 'It\'s too late to rob this bank.', 2)
        return
    end

    print('Valid?')

    if banks[bId] == nil then return end

    print('Non-Invalid Bank Id.')

    if banks[bId]['robbing'] then
        TriggerEvent('DoLongHudText', 'This bank is already being robbed.', 2)
        return
    end

    local pCoords = GetEntityCoords(PlayerPedId())

    local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 3.0, 2121050683, 0, 0, 0)
    if vDoor ~= 0 then
        local finished = exports['urp-taskbar']:taskBar(5000, 'Requesting Access')
        TriggerEvent('inventory:removeItem', 'securityblue', 1)
        if finished ~= 100 then
            TriggerEvent('DoLongHudText', 'You cancelled the robbery.', 2)
            return
        end
        TriggerServerEvent('urp-robbery:smallBankAttempt', bId)
    end

    local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 3.0, -63539571, 0, 0, 0)
    if vDoor ~= 0 then
        local finished = exports['urp-taskbar']:taskBar(5000, 'Requesting Access')
        TriggerEvent('inventory:removeItem', 'securityblue', 1)
        if finished ~= 100 then
            TriggerEvent('DoLongHudText', 'You cancelled the robbery.', 2)
            return
        end
        TriggerServerEvent('urp-robbery:smallBankAttempt', bId)
    end

end)

RegisterNetEvent('urp-robbery:updateBankData')
AddEventHandler('urp-robbery:updateBankData', function(bData)
    if bData ~= nil or bData ~= {} then
        banks = bData
        print(json.encode(banks))
        OpenVaultDoor(true)
    end
end)

function OpenVaultDoor(vType)
    if vType then
        TriggerEvent('urp-robbery:openSmallBankDoor', 2121050683)
        TriggerEvent('urp-robbery:openSmallBankDoor', -63539571)
    else
        TriggerEvent('urp-robbery:openSmallBankDoor', -131754413)
    end
end

function GetBankId()
    local dMin = 999.0

    for i = 1, #banks do
        local dst = #(GetEntityCoords(PlayerPedId()) - vector3(banks[i]['x'], banks[i]['y'], banks[i]['z']))
        if dst < dMin then
            dMin = dst
            bankId = i
        end
    end

    if dMin < 10.0 then
        return bankId
    else
        return false
    end
end