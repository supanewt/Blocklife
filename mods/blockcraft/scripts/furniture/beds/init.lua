local modpath = minetest.get_modpath("blockcraft")
local beds_path = modpath .. "/scripts/furniture/beds"

dofile(beds_path .. "/helpers.lua")
dofile(beds_path .. "/api.lua")
dofile(beds_path .. "/nodes.lua")
dofile(beds_path .. "/spawns.lua")
