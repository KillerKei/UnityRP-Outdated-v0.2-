local webhook = 'https://discordapp.com/api/webhooks/766796912736862218/2EXzF929m_J69YKV2kpz4rE4py-mfRSAJbHYdoJKl9df99Z5b_fwMIeEX41bbm0fm8NL'

RegisterNetEvent('urp-coords:server')
AddEventHandler('urp-coords:server', function(x, y, z , heading)

    print('dick')

    print(json.encode(data))
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Coords Dick', content = '`' .. string.format('x = %s, y = %s, z = %s, h = %s', tostring(x), tostring(y), tostring(z), tostring(heading)) .. '`', tts = false}), { ['Content-Type'] = 'application/json' })

end)