URP.SettingsData = URP.SettingsData or {}
URP.Settings = URP.Settings or {}

URP.Settings.Current = {}
-- Current bind name and keys
URP.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["clickVolume"] = 0.8,
    ["radioVolume"] = 0.8,
    ["phoneVolume"] = 0.8,
    ["releaseDelay"] = 200
  },
  ["hud"] = {

  }

}


function URP.SettingsData.setSettingsTable(settingsTable, shouldSend)
  if settingsTable == nil then
    URP.Settings.Current = URP.Settings.Default
    --TriggerServerEvent('urp-base:sv:player_settings_set',URP.Settings.Current)
    URP.SettingsData.checkForMissing()
  else
    if shouldSend then
      URP.Settings.Current = settingsTable
      --TriggerServerEvent('urp-base:sv:player_settings_set',URP.Settings.Current)
      URP.SettingsData.checkForMissing()
    else
       URP.Settings.Current = settingsTable
       URP.SettingsData.checkForMissing()
    end
  end

  TriggerEvent("event:settings:update",URP.Settings.Current)

end

function URP.SettingsData.setSettingsTableGlobal(self, settingsTable)
  URP.SettingsData.setSettingsTable(settingsTable,true);
end

function URP.SettingsData.getSettingsTable()
    return URP.Settings.Current
end

function URP.SettingsData.setVarible(self,tablename,atrr,val)
  URP.Settings.Current[tablename][atrr] = val
  --TriggerServerEvent('urp-base:sv:player_settings_set',URP.Settings.Current)
end

function URP.SettingsData.getVarible(self,tablename,atrr)
  return URP.Settings.Current[tablename][atrr]
end

function URP.SettingsData.checkForMissing()
  local isMissing = false

  for j,h in pairs(URP.Settings.Default) do
    if URP.Settings.Current[j] == nil then
      isMissing = true
      URP.Settings.Current[j] = h
    else
      for k,v in pairs(h) do
        if  URP.Settings.Current[j][k] == nil then
           URP.Settings.Current[j][k] = v
           isMissing = true
        end
      end
    end
  end
  

  if isMissing then
    --TriggerServerEvent('urp-base:sv:player_settings_set',URP.Settings.Current)
  end


end

RegisterNetEvent("urp-base:cl:player_settings")
AddEventHandler("urp-base:cl:player_settings", function(settingsTable)
  URP.SettingsData.setSettingsTable(settingsTable,false)
end)


RegisterNetEvent("urp-base:cl:player_reset")
AddEventHandler("urp-base:cl:player_reset", function(tableName)
  if URP.Settings.Default[tableName] then
      if URP.Settings.Current[tableName] then
        URP.Settings.Current[tableName] = URP.Settings.Default[tableName]
        URP.SettingsData.setSettingsTable(URP.Settings.Current,true)
      end
  end
end)