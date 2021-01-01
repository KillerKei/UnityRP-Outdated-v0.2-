fx_version 'adamant'
games { 'gta5' }

client_script 'client.lua'
client_script "@irp-errorlog/client/cl_errorlog.lua"
server_script '@mysql-async/lib/MySQL.lua'
server_script 'server.lua'