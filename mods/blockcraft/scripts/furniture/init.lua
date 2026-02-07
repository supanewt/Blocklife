local modpath = minetest.get_modpath("blockcraft")
local furniture_path = modpath .. "/scripts/furniture"

-- Beds expect a global beds table and translator
local beds = blockman.beds or {}
blockman.beds = beds
blockman.expose_global("beds", beds)
beds.player = {}
beds.bed_position = {}
beds.pos = {}
beds.spawn = {}
beds.get_translator = minetest.get_translator("blockcraft")

dofile(furniture_path .. "/beds/init.lua")
