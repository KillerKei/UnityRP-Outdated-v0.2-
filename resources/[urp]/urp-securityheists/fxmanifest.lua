fx_version 'adamant'
games { 'gta5' }

--client_script "@np-errorlog/client/cl_errorlog.lua"

client_script 'client.lua'
client_script 'clientTowAI.lua'
client_script "@urp-errorlog/client/cl_errorlog.lua"
server_script "server.lua"