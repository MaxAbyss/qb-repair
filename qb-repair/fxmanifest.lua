fx_version 'cerulean'
game 'gta5'

shared_scripts {
	"config.lua"
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/C_repair.lua',
}

server_scripts {
	'server/S_repair.lua',
}
