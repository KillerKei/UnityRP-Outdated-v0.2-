local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
job = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        job = exports['isPed']:isPed('job')
    end
end)


RegisterNetEvent("job")
AddEventHandler("job", function()
    if job ~= nil and job == 'Police' then isPolice = true end
end)

rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            return not isDead
        end,
        subMenus = {"general:escort", "general:escortcuffed", "general:checkvehicle","general:putinvehicle", "general:unseatnearest", "general:flipvehicle", "general:civcuff", "general:civuncuff", "general:keysgive",  "general:emotes", "general:askfortrain"  }
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
            local Player = LocalPlayer:getCurrentCharacter()
            return (Player.job == 'Police' and not isDead)
        end,
        subMenus = {"police:escort", "police:putinvehicle", "police:unseatnearest", "police:hardcuff", "police:softcuff", "police:uncuff", "police:panic", "police:pdrevive", "cuffs:checkinventory", "police:frisk", "police:mdt"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
            local Player = LocalPlayer:getCurrentCharacter()
            return (Player.job == 'Police' and not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = {"general:unseatnearest", "police:runplate", "police:toggleradar"}
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
            local Player = LocalPlayer:getCurrentCharacter()
            return (Player.job == 'EMS' and not isDead)
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "general:escort", "general:putinvehicle", "general:unseatnearest", "general:checktargetstates" }
    },
    {
        id = "policeDead",
        displayName = "10-13",
        icon = "#police-dead",
        functionName = "police:tenThirteen",
        enableMenu = function()
            downed = exports["urp-deathmanager"]:GetDeath()
            local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
            local Player = LocalPlayer:getCurrentCharacter()
            return Player.job == 'Police' and downed end
    },
    {
        id = "emsDead",
        displayName = "10-14",
        icon = "#ems-dead",
        functionName = "police:tenForteen",
        enableMenu = function()
            downed = exports["urp-deathmanager"]:GetDeath()
            local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
            local Player = LocalPlayer:getCurrentCharacter()
            return Player.job == 'EMS' and downed end
    },
    {
        id = "animations",
        displayName = "Walkstyle",
        icon = "#walking",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            return not isDead
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            return not isDead
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "blips",
        displayName = "Blips",
        icon = "#blips",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"blips:trainstations", "blips:garages", 'blips:gasstations'}
    },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, {
        id = "impound",
        displayName = "Impound Vehicle",
        icon = "#impound-vehicle",
        functionName = "impoundVehicle",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            if not isDead and myJob == "towtruck" and #(GetEntityCoords(PlayerPedId()) - vector3(549.47796630859, -55.197559356689, 71.069190979004)) < 10.599 then
                return true
            end
            return false
        end
    }, {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            return not isDead and hasOxygenTankOn
        end
    }, {
        id = "cocaine-status",
        displayName = "Request Status",
        icon = "#cocaine-status",
        functionName = "cocaine:currentStatusServer",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            if not isDead and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }, {
        id = "cocaine-crate",
        displayName = "Remove Crate",
        icon = "#cocaine-crate",
        functionName = "cocaine:methCrate",
        enableMenu = function()
            isDead = exports["urp-deathmanager"]:GetDeath()
            if not isDead and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }



}

newSubMenus = {
    ['general:emotes'] = {
        title = "Emotes",
        icon = "#general-emotes",
        functionName = "emotes:OpenMenu"
    },
    ['general:askfortrain'] = {
        title = "Request Train",
        icon = "#general-ask-for-train",
        functionName = "AskForTrain",
    }, 
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "civputInVehicle"
    }, 
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "civoutOfVehicle"
    },
    ['general:escort'] = {
        title = "Escort Uncuffed",
        icon = "#general-escort",
        functionName = "civDrag"
    },
    ['general:escortcuffed'] = {
        title = "Escort Cuffed",
        icon = "#police-action-escort",
        functionName = "pdescort"
    },
    ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "menu:VehReq"
    }, 
    ['general:keysgive'] = {
        title = "Give Key",
        icon = "#general-keys-give",
        functionName = "hotwire:giveKey"
    },
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['general:civcuff'] = {
        title = "Civ Cuff",
        icon = "#cuffs-cuff",
        functionName = "urp_handcuffs:cuffcheck"
    },
    ['general:civuncuff'] = {
        title = "Civ Uncuff",
        icon = "#cuffs-cuff",
        functionName = "urp_handcuffs:uncuff"
    },    
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['drivinginstructor:drivingtest'] = {
        title = "Driving Test",
        icon = "#drivinginstructor-drivingtest",
        functionName = "drivingInstructor:testToggle"
    },
    ['drivinginstructor:submittest'] = {
        title = "Submit Test",
        icon = "#drivinginstructor-submittest",
        functionName = "drivingInstructor:submitTest"
    },
    ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    },
    ['cuffs:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "civ:cuffFromMenu"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "police:uncuffMenu"
    },
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "pdsearch"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "unseatPlayerCiv"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "tp:emsRevive"
    },
    ['medic:heal'] = {
        title = "Patch Small",
        icon = "#medic-heal",
        functionName = "tp:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Patch Big",
        icon = "#medic-bigheal",
        functionName = "tp:emsbigheal"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#police-action-escort",
        functionName = "pdescort"
    },
    ['police:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#police-action-put-in-veh",
        functionName = "putInVehicle"
    },
    ['police:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#police-action-unseat-nearest",
        functionName = "outOfVehicle"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:mdt'] = {
        title = "MDT",
        icon = "#police-action-mdt",
        functionName = "mdt"
    },
    ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "wk:radarRC"
    },
    ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "urp-policefrisk:menuEvent"
    },
    ['police:pdrevive'] = {
        title = "Revive",
        icon = "#police-action-pdrevive",
        functionName = "tp:pdrevive"
    },
    ['police:hardcuff'] = {
        title = "Hard Cuff",
        icon = "#police-action-hc",
        functionName = "hardcuff"
    },
    ['police:softcuff'] = {
        title = "Soft Cuff",
        icon = "#police-action-sc",
        functionName = "softcuff"
    },
    ['police:uncuff'] = {
        title = "Uncuff",
        icon = "#police-action-uc",
        functionName = "uncuff"
    },
    ['police:panic'] = {
        title = "Panic",
        icon = "#police-action-panic",
        functionName = "police:panic"
    },
    ['judge:grantDriver'] = {
        title = "Grant Drivers",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }, 
    ['blips:trainstations'] = {
        title = "Train Stations",
        icon = "#blips-trainstations",
        functionName = "Trains:ToggleTainsBlip"
    },
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:gasstations'] = {
        title = "Gas Stations",
        icon = "#blips-gasstations",
        functionName = "CarPlayerHud:ToggleGas"
    }, 
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
local isDead = exports["urp-deathmanager"]:GetDeath()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)


RegisterNetEvent("isPolice")
AddEventHandler("isPolice", function()
    local LocalPlayer = exports["urp-base"]:getModule("LocalPlayer")
    local Player = LocalPlayer:getCurrentCharacter()
    if Player.job == 'Police' then
        isPolice = true
    end
end)

RegisterNetEvent('police:tenForteen')
AddEventHandler('police:tenForteen', function()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	
	TriggerEvent('ems:medicDown')
    TriggerEvent('DoLongHudText', 'Distress signal has been sent to available units!')
	TriggerServerEvent('urp_addons_gcphone:startCall', 'ambulance', '10-14 Medic Down at Coords : ', PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end)

RegisterNetEvent('police:tenThirteen')
AddEventHandler('police:tenThirteen', function()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	
	TriggerEvent('police:officerDown')
	TriggerEvent('DoLongHudText', 'Distress signal has been sent to available units!')
	TriggerServerEvent('urp_addons_gcphone:startCall', 'police', '10-13 Officer Down at Coords : ', PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

RegisterNetEvent('urp_handcuffs:cuffcheck')
AddEventHandler('urp_handcuffs:cuffcheck', function()
    local target, distance = GetClosestPlayer()
    if exports['urp-inventory']:hasEnoughOfItem('cuffs', 1, true) then
        if distance ~= -1 and distance <= 3.0 then
            playerheading = GetEntityHeading(GetPlayerPed(-1))
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            local target_id = GetPlayerServerId(target)
            TriggerServerEvent('urp-policejob:requesthard', target_id, playerheading, playerCoords, playerlocation)
            Citizen.Wait(1800)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'cuff', 1.0)
        else
            TriggerEvent('DoLongHudText', 'Not near player', 2)
        end
    end
end)

RegisterNetEvent('urp_handcuffs:uncuff')
AddEventHandler('urp_handcuffs:uncuff', function()
    if exports['urp-inventory']:hasEnoughOfItem('keya', 1, true) then
        local target, distance = GetClosestPlayer()
        if distance ~= -1 and distance <= 3.0 then
            playerheading = GetEntityHeading(GetPlayerPed(-1))
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            local target_id = GetPlayerServerId(target)
            TriggerServerEvent('urp-policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
            Citizen.Wait(1200)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'uncuff', 0.5)
        end
    else
        TriggerEvent('DoLongHudText', 'No Handcuff key', 2)
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function loadAnimDict( dict )
    RequestAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        
        Citizen.Wait( 1 )
    end
end

RegisterNetEvent('FlipVehicle')
AddEventHandler('FlipVehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
            loadAnimDict("random@mugging4")
        TaskPlayAnim(PlayerPedId(), "random@mugging4" , "struggle_loop_b_thief" ,8.0, -8.0, -1, 1, 0, false, false, false )
        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
        local finished = exports["urp-taskbar"]:taskBar(10000,"Flipping Vehicle Over",false,false,playerVeh)
        if finished == 100 then
            ClearPedTasks(PlayerPedId())
            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
        end
    else
        TriggerEvent('DoLongHudText', 'There is no vehicle near by!', 2)
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function getVehicleInDirectionClose(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 3 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('civputInVehicle')
AddEventHandler('civputInVehicle', function()
    local target, distance = GetClosestPlayer()
    if target and distance < 3 then
        TriggerServerEvent('urp-interactions:putInVehicle', GetPlayerServerId(target))
	else
        TriggerEvent('DoLongHudText', 'There is no player(s) nearby!',2)
	end
end)

RegisterNetEvent('urp-interactions:putInVehicle')
AddEventHandler('urp-interactions:putInVehicle', function()
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed) then
        local coordA = GetEntityCoords(playerPed, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 100.0, 0.0)
        local vehicle = getVehicleInDirectionClose(coordA, coordB)
        local modelHash = GetEntityModel(vehicle)
        if vehicle then
            for i = GetVehicleModelNumberOfSeats(modelHash), 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    if not isDead then
                        TaskWarpPedIntoVehicle(playerPed, vehicle, i)
                    else
                        ClearPedSecondaryTask(playerPed)
                        Citizen.Wait(0)
                        TaskWarpPedIntoVehicle(playerPed, vehicle, i)
                    end
                    break
                end

            end
        end
    end
end)

RegisterNetEvent('civoutOfVehicle')
AddEventHandler('civoutOfVehicle', function()
    local target, distance = GetClosestPlayer()
    if target and distance < 3 then
        TriggerServerEvent('urp-interactions:outOfVehicle', GetPlayerServerId(target))
	else
		TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	end
end)

RegisterNetEvent('urp-interactions:outOfVehicle')
AddEventHandler('urp-interactions:outOfVehicle', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed)
        TaskLeaveVehicle(playerPed, vehicle, 16)
    end
end)

--START SCUBA

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

attachedProp = 0
attachedProp2 = 0

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end
function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end
function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["isPed"]:GlobalObject(attachedProp2)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end
function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["isPed"]:GlobalObject(attachedProp)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

RegisterCommand('scuba', function()
	local vehFront = VehicleInFront()
    if vehFront > 0 then
        if GetVehicleDoorAngleRatio(vehFront, 5) ~= 0.0 then
  		    loadAnimDict('anim@narcotics@trash')
            TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)	
                local finished = exports["urp-taskbar"]:taskBar(4000,"Grabbing Scuba Gear")
                if finished == 100 then
	  		    loadAnimDict('anim@narcotics@trash')
    		    TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)	  		
			    TriggerEvent("UseOxygenTank")
            end
        else
            TriggerEvent('DoLongHudText', 'The trunk is closed?!', 2)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if hasOxygenTankOn and IsPedSwimmingUnderWater(PlayerPedId()) then
            SetPedDiesInWater(PlayerPedId(), false)
        elseif not hasOxygenTankOn and IsPedSwimmingUnderWater(PlayerPedId()) then
            SetPedDiesInWater(PlayerPedId(), true)
        end
    end
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
    TriggerEvent('menu:hasOxygenTank', false)
    removeAttachedProp()
    removeAttachedProp2()
    TriggerEvent('DoLongHudText', 'Removed Scuba Gear', 2)
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
    TriggerEvent('menu:hasOxygenTank', true)
    attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
    attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    TriggerEvent('DoLongHudText', 'Equipped Scuba Gear')
end)

--END SCUBA
GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

RegisterNetEvent('pdescort')
AddEventHandler('pdescort', function()
	local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        local job = exports['urp-base']:getModule("LocalPlayer"):getCurrentCharacter().job
        if job == "Police" then
            TriggerServerEvent('urp-policejob:drag', GetPlayerServerId(closestPlayer))
        end
	else
		TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	end
end)
