fx_version 'adamant'
games { 'gta5' }

dependency "ghmattimysql"

client_scripts {
    'config.lua',
	'client/main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}
