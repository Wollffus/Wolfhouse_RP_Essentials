fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'https://discord.gg/zGVDppYxfk'
version '1.4.1'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

-- Run the server scripts
server_script "branding.lua"

-- Run the client scripts
client_script "config.lua"
client_script "client.lua"
