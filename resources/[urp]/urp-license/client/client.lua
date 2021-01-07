job = nil
cid = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        cid = exports['isPed']:isPed('cid')
        job = exports['isPed']:isPed('job')
        TriggerServerEvent('urp-license:pass', cid, job)
    end
end)