fx_version 'bodacious'
games {'gta5'}

author 'Lynxist'
description 'Zombie Quest Shit'
version '1.0'
lua54 'yes'

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
	"client/*.lua",
}

server_scripts {
  "server/*.lua",
}


shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

