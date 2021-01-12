this_is_a_map 'yes'

files {
    'shellprops.ytyp',
    'irp-pillbox/gabz_timecycle_mods_1.xml',
    "interiorproxies.meta",
    "cellgate_game.dat151.rel"
}

data_file 'DLC_ITYP_REQUEST' 'shellprops.ytyp'
data_file 'TIMECYCLEMOD_FILE' 'irp-pillbox/gabz_timecycle_mods_1.xml'
data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"
data_file "AUDIO_GAMEDATA" "cellgate_game.dat"

client_scripts {
    "irp-pillbox/main.lua",
    "client.lua",
    "SLBK11_MissionRow/client/main.lua"
}

fx_version 'adamant'
games { 'gta5' }