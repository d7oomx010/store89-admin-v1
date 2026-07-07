fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Store89'
description 'Store89 Premium Admin Panel'
version '1.1.0'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/nui.lua',
    'client/functions.lua',
    'client/utils.lua',
    'client/actions.lua',
    'client/threads.lua',
    'client/players.lua',
    'client/world.lua',
    'client/vehicle.lua',
    'client/spectate.lua',
    'client/noclip.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'server/main.lua',
    'server/players.lua',
    'server/world.lua',
    'server/vehicles.lua',
    'server/callbacks.lua',
    'server/permissions.lua',
    'server/logs.lua',
    'server/discord.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/assets/*',
    'html/fonts/*'
}

dependencies {
    'ox_lib',
    'es_extended',
    'oxmysql'
}