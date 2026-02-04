fx_version 'cerulean'
game 'gta5'

author 'idtg Development'
description 'Miranda Rights Card UI for FiveM'
version '1.0.0'
lua54 'yes'

ui_page 'ui/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/img/*.png'
}