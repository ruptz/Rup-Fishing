fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.0'
author 'ruptz'
description 'Rup-Fishing'

shared_scripts { 
    '@ox_lib/init.lua', 
    'configuration/*.lua',
    'shared/*.lua'
}

client_scripts { 'client/*.lua' }

server_scripts { 'server/*.lua' }

dependencies { 'ox_lib' }