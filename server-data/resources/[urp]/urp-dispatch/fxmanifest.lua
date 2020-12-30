fx_version 'bodacious'
games { 'rdr3', 'gta5' }
version '1.0.0'

dependencies {
    "ghmattimysql",
    -- "yarn"
} 

files {
    'client/dist/index.html',
    'client/dist/js/app.js',
    'client/dist/css/app.css',
}
-- I started work on a server component in NodeJS, it's going to require
-- a lot more work tho...
client_script 'client/*.lua'
server_script 'server/sv_dispatch.lua'

ui_page 'client/dist/index.html'