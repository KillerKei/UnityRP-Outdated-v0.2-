local ultimaAccion = nil
local currentGarage = nil
local fetchedVehicles = {}
local fueravehicles = {}

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function MenuGarage(action)
    if not action then action = ultimaAccion; elseif not action and not ultimaAccion then action = "menu"; end
    currentGarage = cachedData["currentGarage"]
    if not currentGarage then
        CloseMenu()
        return 
    end
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    ultimaAccion = action
    Citizen.Wait(150)
    DeleteActualVeh()
    if action == "menu" then
        DisplayHelpText('~g~E~s~ or ~g~Enter~s~ Accepts ~g~Arrows~s~ Move ~g~Backspace~s~ Exit')
        Menu.addButton("Store Vehicle", "SaveInGarage", currentGarage)
        Menu.addButton("Vehicle List","ListeVehicule",nil)
        Menu.addButton("Close","CloseMenu",nil)
    end
end

function EnvioVehLocal(veh)
    local slots = {}
    for c,v in pairs(veh) do
        table.insert(slots,{["garage"] = v.garage, ["vehiculo"] = json.decode(v.vehicle)})
    end
    fetchedVehicles = slots
end

function EnvioVehFuera(data)
    local slots = {}
    for c,v in pairs(data) do
        if v.state == 0 or v.state == 2 or v.state == false or v.garage == nil then
            table.insert(slots,{["vehiculo"] = json.decode(v.vehicle),["state"] = v.state})
        end
    end
    fueravehicles = slots
end

function AbrirMenuGuardar()
    currentGarage = cachedData["currentGarage"]
    if not currentGarage then
        CloseMenu()
        return 
    end
   ped = GetPlayerPed(-1);
   MenuTitle = "Save :"
   ClearMenu()
   Menu.addButton("Close","CloseMenu",nil)
   Menu.addButton("GARAGE: "..currentGarage.." | SAVE", "SaveInGarage", currentGarage, "", "", "","DeleteActualVeh")
end

function ListeVehicule()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = GetPlayerPed(-1);
   MenuTitle = "My Vehicles :"
   ClearMenu()
   Menu.addButton("Return","MenuGarage",nil)
   local garage
    for _,v in pairs(CurrentVehicles) do
        garage = v.garage
        if GetDisplayNameFromVehicleModel(v.model) == 'CARNOTFOUND' then
            Menu.addButton("" ..(v.plate).." | ".."CONTACT ADMIN", "OptionVehicle", {v,nil}, "STORED - Garage: "..garage.."", " Engine : " .. round(v.engine_damage) /10 .. "%", " Fuel : " .. round(v.fuel) .. "%")
        else
            Menu.addButton("" ..(v.plate).." | "..GetDisplayNameFromVehicleModel(v.model), "OptionVehicle", {v,nil}, "STORED - Garage: "..garage.."", " Engine : " .. round(v.engine_damage) /10 .. "%", " Fuel : " .. round(v.fuel) .. "%")
        end
    end
end

function round(n)
    if not n then return 0; end
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function OptionVehicle(data)
   MenuTitle = "Options :"
   ClearMenu()
   Menu.addButton("Take", "SpawnVehicle", data)
   Menu.addButton("Return", "ListeVehicule", nil)
end

function CloseMenu()
    HandleCamera(currentGarage, false)
	TriggerEvent("inmenu",false)
    Menu.hidden = true
end

function LocalPed()
	return GetPlayerPed(-1)
end
