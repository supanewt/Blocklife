-- walls/init.lua

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.walls = blockman.walls or {}
local walls = blockman.walls
blockman.expose_global("walls", walls)

local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")

walls.register = function(wall_name, wall_desc, wall_texture_table, wall_mat, wall_sounds)
	--make wall_texture_table paramenter backwards compatible for mods passing single texture
	if type(wall_texture_table) ~= "table" then
		wall_texture_table = { wall_texture_table }
	end
	-- inventory node, and pole-type wall start item
	minetest.register_node(wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			-- connect_bottom =
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
			-- connect_top =
			-- connect_bottom =
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + fence_collision_extra,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + fence_collision_extra,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2 + fence_collision_extra,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2 + fence_collision_extra,1/4},
		},
		connects_to = { "group:wall", "group:stone", "group:fence", "group:wall_connected" },
		paramtype = "light",
		is_ground_content = false,
		tiles = wall_texture_table,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2 },
		sounds = wall_sounds,
	})

	-- crafting recipe
	-- HACK:
	--   Walls have no crafts, when register new wall via API from another mod, but in the same namespace (`walls`).
	--   So we should remove `":"` at the beginning of the name.
	if wall_name:sub(1, 1) == ":" then
		wall_name = wall_name:sub(2)
	end
	minetest.register_craft({
		output = wall_name .. " 6",
		recipe = {
			{ "", "", "" },
			{ wall_mat, wall_mat, wall_mat},
			{ wall_mat, wall_mat, wall_mat},
		}
	})

end

walls.register("blocklife:cobble", S("Cobblestone Wall"), {"blocklife_cobble.png"},
		"blocklife:cobble", blockman.node_sound_stone_defaults())

walls.register("blocklife:mossycobble", S("Mossy Cobblestone Wall"), {"blocklife_mossycobble.png"},
		"blocklife:mossycobble", blockman.node_sound_stone_defaults())

walls.register("blocklife:desertcobble", S("Desert Cobblestone Wall"), {"blocklife_desert_cobble.png"},
		"blocklife:desert_cobble", blockman.node_sound_stone_defaults())



minetest.register_alias("walls:cobble", "blocklife:cobble")
minetest.register_alias("walls:mossycobble", "blocklife:mossycobble")
minetest.register_alias("walls:desertcobble", "blocklife:desertcobble")
