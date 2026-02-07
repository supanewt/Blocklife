local modpath = minetest.get_modpath("blockman")
local player_path = modpath .. "/scripts/player"

dofile(player_path .. "/api.lua")
dofile(player_path .. "/core.lua")
dofile(player_path .. "/starters.lua")
