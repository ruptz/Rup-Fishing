fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'
author 'ruptz'
description 'Rup-Fishing'
repository 'https://github.com/yourusername/yourrepository'

shared_scripts { 
    '@ox_lib/init.lua', 
    'config.lua',
    --'@es_extended/imports.lua' --[[ Uncomment if using ESX ]]
    --'@ND_Core/init.lua'        --[[ Uncomment if using ND-Core ]]
}

client_scripts { 'client/*.lua' }

server_scripts { 'server/*.lua' }

dependencies { 'ox_lib' }