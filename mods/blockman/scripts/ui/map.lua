-- map/init.lua

-- Mod global namespace

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.map = blockman.map or {}
local map = blockman.map
blockman.expose_global("map", map)


-- Load support for MT game translation.
local S = minetest.get_translator("blockman")


-- Update HUD flags
-- Global to allow overriding

function map.update_hud_flags(player)
	local creative_enabled = minetest.is_creative_enabled(player:get_player_name())

	local minimap_enabled = creative_enabled or
		player:get_inventory():contains_item("main", "blocklife:mapping_kit")
	local radar_enabled = creative_enabled

	player:hud_set_flags({
		minimap = minimap_enabled,
		minimap_radar = radar_enabled
	})
end


-- Set HUD flags 'on joinplayer'

minetest.register_on_joinplayer(function(player)
	map.update_hud_flags(player)
end)


-- Cyclic update of HUD flags

local function cyclic_update()
	for _, player in ipairs(minetest.get_connected_players()) do
		map.update_hud_flags(player)
	end
	minetest.after(5.3, cyclic_update)
end

minetest.after(5.3, cyclic_update)


-- Mapping kit item

minetest.register_craftitem("blocklife:mapping_kit", {
	description = S("Mapping Kit") .. "\n" .. S("Use with 'Minimap' key"),
	inventory_image = "blocklife_map_mapping_kit.png",
	stack_max = 1,
	groups = {flammable = 3, tool = 1},

	on_use = function(itemstack, user, pointed_thing)
		map.update_hud_flags(user)
	end,
})


-- Crafting

minetest.register_craft({
	output = "blocklife:mapping_kit",
	recipe = {
		{"blocklife:glass", "blocklife:paper", "group:stick"},
		{"blocklife:steel_ingot", "blocklife:paper", "blocklife:steel_ingot"},
		{"group:wood", "blocklife:paper", "dye:black"},
	}
})


-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:mapping_kit",
	burntime = 5,
})


minetest.register_alias("map:mapping_kit", "blocklife:mapping_kit")
