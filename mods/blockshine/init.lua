-- Blockshine resources and ore progression

local modpath = minetest.get_modpath("blockshine")

local function load(script)
	dofile(modpath .. "/scripts/" .. script)
end

load("ores/init.lua")
