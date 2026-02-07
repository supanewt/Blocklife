-- carts/core.lua

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.carts = blockman.carts or {}
local carts = blockman.carts
blockman.expose_global("carts", carts)
carts.railparams = {}
carts.get_translator = S

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 5
-- Maximal distance for the path correction (for dtime peaks)
carts.path_distance_max = 3

-- Register rails as dungeon loot after all mods load
minetest.register_on_mods_loaded(function()
	if minetest.global_exists("dungeon_loot") then
		dungeon_loot.register({
			name = "blocklife:rail", chance = 0.35, count = {1, 6}
		})
	end
end)
