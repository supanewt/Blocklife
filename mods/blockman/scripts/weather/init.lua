local modpath = minetest.get_modpath("blockman")
local weather_path = modpath .. "/scripts/weather"

dofile(weather_path .. "/api.lua")
dofile(weather_path .. "/core.lua")
