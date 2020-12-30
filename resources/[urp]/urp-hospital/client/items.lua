function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterNetEvent("urp-hospital:items:gauze")
AddEventHandler("urp-hospital:items:gauze", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Packing Wounds', 1500, function()
        local finished = exports["urp-taskbar"]:taskBar(1500,"Packing Wounds")
        if finished == 100 then
        TriggerEvent('urp-hospital:client:FieldTreatBleed')
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:bandage")
AddEventHandler("urp-hospital:items:bandage", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Using Bandage', 5000, function()
        local finished = exports["urp-taskbar"]:taskBar(5000,"Using Bandage")
        if finished == 100 then
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerEvent('urp-hospital:client:RemoveBleed')
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:firstaid")
AddEventHandler("urp-hospital:items:firstaid", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Using First Aid', 10000, function()
        local finished = exports["urp-taskbar"]:taskBar(10000,"Using First Aid")
        if finished == 100 then
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerEvent('urp-hospital:client:RemoveBleed')
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:medkit")
AddEventHandler("urp-hospital:items:medkit", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Using Medkit', 20000, function()
        local finished = exports["urp-taskbar"]:taskBar(20000,"Using Medkit")
        if finished == 100 then
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        TriggerEvent('urp-hospital:client:FieldTreatLimbs')
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:vicodin")
AddEventHandler("urp-hospital:items:vicodin", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Taking Oxycodone', 1000, function()

        local finished = exports["urp-taskbar"]:taskBar(10000,"Taking Oxycodone")
        if finished == 100 then


        TriggerEvent('urp-hospital:client:UsePainKiller', 1)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:ifak")
AddEventHandler("urp-hospital:items:ifak", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 3.0, 1.0, 10000, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Using IFAK', 10000, function()

        local finished = exports["urp-taskbar"]:taskBar(10000,"Using IFAK")
        if finished == 100 then

            
        TriggerEvent('urp-hospital:client:UsePainKiller', 1)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:hydrocodone")
AddEventHandler("urp-hospital:items:hydrocodone", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Taking Hydrocodone', 1000, function()

        local finished = exports["urp-taskbar"]:taskBar(1000,"Taking Hydrocodone")
        if finished == 100 then


        TriggerEvent('urp-hospital:client:UsePainKiller', 2)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent("urp-hospital:items:morphine")
AddEventHandler("urp-hospital:items:morphine", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--    exports["urp_taskbar"]:StartDelayedFunction('Taking Morphine', 2000, function()

        local finished = exports["urp-taskbar"]:taskBar(2000,"Taking Morphine")
        if finished == 100 then

        
        TriggerEvent('urp-hospital:client:UsePainKiller', 6)
        ClearPedTasks(PlayerPedId())
    end
end)