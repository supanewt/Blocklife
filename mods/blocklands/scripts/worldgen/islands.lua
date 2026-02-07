islands = {}

-- fun island
-- seed = 5436146057422610855 
-- pos -1590 33 -171

local floor = math.floor
local ceil = math.ceil
local min = math.min
local max = math.max
local random = math.random

local mpath = minetest.get_modpath('blocklands')
local schem_path = minetest.get_modpath('blockfx') .. "/schematics"

local SCHEM_REPLACEMENTS = {
	["islands:palm_tree"] = "blocklife:palm_tree",
	["islands:palm_leaves"] = "blocklife:palm_leaves",
	["islands:palm_leaves2"] = "blocklife:palm_leaves2",
	["islands:palm_small_bottom"] = "blocklife:palm_small_bottom",
	["islands:palm_small_top"] = "blocklife:palm_small_top",
	["islands:tree"] = "blocklife:islands_tree",
	["islands:leaves"] = "blocklife:islands_leaves",
	["islands:twigs"] = "blocklife:islands_twigs",
	["islands:underbrush"] = "blocklife:islands_underbrush",
	["islands:grass"] = "blocklife:islands_grass",
	["islands:cotton_bush"] = "blocklife:islands_cotton_bush",
	["islands:wood"] = "blocklife:islands_wood",
	["islands:seabed"] = "blocklife:seabed",
	["default:stone"] = "blocklife:stone",
	["default:sand"] = "blocklife:sand",
	["default:dirt"] = "blocklife:dirt",
	["default:dirt_with_grass"] = "blocklife:dirt_with_grass",
	["default:dirt_with_rainforest_litter"] = "blocklife:dirt_with_rainforest_litter",
	["default:water_source"] = "blocklife:water_source",
}

local schem_palm_tree_big = schem_path .. '/blocklife_palm_tree_big.mts'
local schem_palm_tree = schem_path .. '/blocklife_palm_tree.mts'
local schem_islands_tree = schem_path .. '/blocklife_islands_tree.mts'
local schem_apple_tree = schem_path .. '/blocklife_apple_tree.mts'
local schem_bush = schem_path .. '/blocklife_bush.mts'
local schem_blueberry_bush = schem_path .. '/blocklife_blueberry_bush.mts'

local dbg = minetest.chat_send_all
local rnodes = minetest.registered_nodes

minetest.clear_registered_decorations()

minetest.set_mapgen_setting("mg_biome_np_heat", 
"90,0,(1000,1000,1000),5349,3,0.5,2",
true)

minetest.set_mapgen_setting("mg_biome_np_humidity", 
"54,10,(1000,1000,1000),5349,3,0.5,2",
true)

local function ensure_biome(name, def)
	if minetest.get_biome_id and minetest.get_biome_id(name) then
		return
	end
	def.name = name
	minetest.register_biome(def)
end

local biome_stub = {
	node_top = "blocklife:dirt_with_grass",
	depth_top = 1,
	node_filler = "blocklife:dirt",
	depth_filler = 3,
	node_stone = "blocklife:stone",
	node_water_top = "blocklife:water_source",
	depth_water_top = 1,
	node_water = "blocklife:water_source",
	node_river_water = "blocklife:water_source",
	node_riverbed = "blocklife:sand",
	depth_riverbed = 2,
	y_max = 31000,
	y_min = -31000,
	heat_point = 50,
	humidity_point = 50,
}

ensure_biome("grassland", table.copy(biome_stub))
ensure_biome("deciduous_forest", table.copy(biome_stub))
ensure_biome("coniferous_forest", table.copy(biome_stub))
ensure_biome("rainforest", table.copy(biome_stub))
ensure_biome("rainforest_swamp", table.copy(biome_stub))
ensure_biome("savanna", table.copy(biome_stub))
ensure_biome("savanna_shore", table.copy(biome_stub))
ensure_biome("deciduous_forest_shore", table.copy(biome_stub))

islands.settings_bkp = {}
islands.settings_bkp.lighting_alpha = minetest.settings:get('lighting_alpha')
islands.settings_bkp.lighting_beta = minetest.settings:get('lighting_beta')
islands.settings_bkp.lighting_boost = minetest.settings:get('lighting_boost')
islands.settings_bkp.lighting_boost_center = minetest.settings:get('lighting_boost_center')
islands.settings_bkp.lighting_boost_spread = minetest.settings:get('lighting_boost_spread')

minetest.after(0,function()
	minetest.settings:set('lighting_alpha',0.5)
	minetest.settings:set('lighting_beta',3)
	minetest.settings:set('lighting_boost',0.15)
	minetest.settings:set('lighting_boost_center',0.5)
	minetest.settings:set('lighting_boost_spread',0.2)
end)

minetest.register_on_shutdown(function()
	for k,v in pairs(islands.settings_bkp) do
		minetest.settings:set(k,v)
	end
end)

local function dig_up(pos, node, metadata, digger)
	pos.y = pos.y+1
	local node2 = minetest.get_node(pos)
	if node2 and (node2.name == "blocklife:islands_underbrush" or rnodes[node2.name].drawtype == "plantlike") then
		minetest.dig_node(pos)
	end
end

--[[
minetest.register_node("blocklife:sand", {
	description = "Sand",
	tiles = {"islands_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = blockman.node_sound_sand_defaults(),
})

minetest.register_node("blocklife:stone", {
	description = "Stone",
	tiles = {"islands_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocklife:cobble",
	legacy_mineral = true,
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:dirt", {
	description = "Dirt",
	tiles = {"islands_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	
})

minetest.register_node("blocklife:dirt_with_grass_palm", {
	description = "Dirt with Grass",
	tiles = {"islands_grass.png", "islands_dirt.png",
		{name = "islands_dirt.png^islands_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
--	drop = 'blocklife:dirt',
	drop = 'blocklife:dirt',
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	
	after_dig_node = dig_up,
	
})	--]]

minetest.register_node("blocklife:seabed", {
	description = "Seabed",
	tiles = {"blocklife_seabed.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = blockman.node_sound_sand_defaults(),
})

--[[
minetest.register_node("blocklife:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"blocklife_snow.png", "islands_dirt.png",
		{name = "islands_dirt.png^blocklife_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = 'blocklife:dirt',
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.2},
	}),
})	--]]

minetest.register_node("blocklife:palm_tree", {
	description = "Palm Tree",
	tiles = {"blocklife_palm_tree_top.png", "blocklife_palm_tree_top.png",
		"blocklife_palm_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = blockman.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("blocklife:palm_leaves", {
	description = ("Uspen Tree Leaves"),
--	drawtype = "allfaces_optional",
	drawtype = "nodebox",
	tiles = {
	{name="blocklife_palm_leaves_top.png",backface_culling = false},
	{name="blocklife_nothing.png"},
	{name="blocklife_palm_leaves.png",backface_culling = false},
	},
	waving = 2,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:palm_leaves"}, rarity = 5}
		}
	},
	sounds = blockman.node_sound_leaves_defaults(),

	--[[
	on_rightclick = function(pos)
		minetest.set_node(pos,{name="blocklife:palm_leaves2"})
	end,	--]]
})

minetest.register_node("blocklife:palm_leaves2", {
	description = ("Uspen Tree Leaves"),
--	drawtype = "allfaces_optional",
	drawtype = "nodebox",
	tiles = {
	{name="blocklife_palm_leaves_top.png",backface_culling = false},
	{name="blocklife_nothing.png"},
	{name="blocklife_palm_leaves.png",backface_culling = false},
	},
	waving = 2,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:palm_leaves"}, rarity = 5}
		}
	},
	color = "#00B000",
	sounds = blockman.node_sound_leaves_defaults(),

	--[[
	on_rightclick = function(pos)
		minetest.set_node(pos,{name="blocklife:palm_leaves"})
	end,	--]]
})


minetest.register_node("blocklife:islands_leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	waving = 2,
	tiles = {"blocklife_islands_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:islands_leaves"}, rarity = 5}
		}
	},
	sounds = blockman.node_sound_leaves_defaults(),
})

minetest.register_node("blocklife:islands_twigs", {
	description = "Twigs",
	drawtype = "allfaces_optional",
	waving = 0,
	tiles = {"blocklife_twigs.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = blockman.node_sound_leaves_defaults()
})

minetest.register_node("blocklife:islands_underbrush", {
	description = ("Underbrush"),
	drawtype = "nodebox",
	node_box ={
		type="fixed",
		fixed = {-0.5,-0.4,-0.5,0.5,-0.25,0.5}
	},
	selection_box = {
		type="fixed",
		fixed = {-0.3,-0.4,-0.3,0.3,-0.25,0.3}
	},
	tiles = {
		{name="blocklife_islands_underbrush_top.png",backface_culling = false},
		{name="blocklife_islands_underbrush_bot.png",backface_culling = false},
		{name="blocklife_nothing.png"},
	},
	walkable = false,
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, flammable = 2, leaves = 1},
	sounds = blockman.node_sound_leaves_defaults(),

})

minetest.register_node("blocklife:palm_small_bottom", {
	description = ("Young palm"),
	drawtype = "plantlike",
	selection_box = {
		type="fixed",
		fixed = {-0.2,-0.5,-0.2,0.2,0.3,0.2}
	},
	tiles = {"blocklife_palm_small_bottom.png"},
	paramtype = "light",
	drop = '',
--	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, flammable = 2},
	sounds = blockman.node_sound_leaves_defaults(),

	after_dig_node = dig_up,
})

minetest.register_node("blocklife:palm_small_top", {
	description = ("Young palm"),
	drawtype = "plantlike",
	tiles = {"blocklife_palm_small_top.png"},
	paramtype = "light",
	sunlight_propagates = true,
	drop = '',
	waving = 1,
	pointable = false,
	walkable = false,
	groups = {snappy = 3, flammable = 2},
	sounds = blockman.node_sound_leaves_defaults(),
})

minetest.register_node("blocklife:islands_wood", {
	description = "Wood Planks",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = blockman.node_sound_wood_defaults(),
})

minetest.register_node("blocklife:islands_grass", {
	description = ("Grass"),
	drawtype = "plantlike",
	tiles = {"blocklife_islands_tall_grass.png"},
	selection_box = {
		type="fixed",
		fixed = {-0.2,-0.5,-0.2,0.2,0,0.2}
	},
	paramtype = "light",
	drop = "",
	waving = 1,
	buildable_to = true,
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 3, flammable = 2},
	sounds = blockman.node_sound_leaves_defaults(),
})

blockman.register_leafdecay({
	trunks = {"blocklife:palm_tree"},
	leaves = {"blocklife:palm_leaves", "blocklife:palm_leaves2"},
	radius = 4,
})

blockman.register_leafdecay({
	trunks = {"blocklife:islands_twigs"},
	leaves = {"blocklife:islands_leaves"},
	radius = 4,
})

minetest.register_node(":blocklife:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "blocklife_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "blocklife_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
--	alpha = 215,
	use_texture_alpha = "blend",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "blocklife:water_flowing",
	liquid_alternative_source = "blocklife:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 190, r = 30, g = 130, b = 100},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = blockman.node_sound_water_defaults(),
})

minetest.register_decoration({
	name = "blocklife:palm_tree_tall",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.001,
		scale = 0.001,
		spread = {x = 64, y = 64, z = 64},
		seed = 2,
		octaves = 2,
		persist = 0.66
	},
	place_offset_y = 1,
	y_max = 100,
	y_min = 3,
	schematic = schem_palm_tree_big,
	replacements = SCHEM_REPLACEMENTS,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:palm_tree",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.02,
		scale = 0.003,
		spread = {x = 64, y = 64, z = 64},
		seed = 2,
		octaves = 2,
		persist = 0.66
	},
	place_offset_y = 1,
	y_max = 100,
	y_min = 3,
	schematic = schem_palm_tree,
	replacements = SCHEM_REPLACEMENTS,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:apple_tree",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0002,
		scale = 0.00003,
		spread = {x = 64, y = 64, z = 64},
		seed = 2,
		octaves = 2,
		persist = 0.66
	},
	place_offset_y = 1,
	y_max = 100,
	y_min = 3,
	schematic = schem_apple_tree,
	replacements = SCHEM_REPLACEMENTS,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:apple_tree",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0002,
		scale = 0.00003,
		spread = {x = 64, y = 64, z = 64},
		seed = 2,
		octaves = 2,
		persist = 0.66
	},
	place_offset_y = 1,
	y_max = 100,
	y_min = 3,
	schematic = schem_apple_tree,
	replacements = SCHEM_REPLACEMENTS,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:islands_tree",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.013,
		scale = 0.002,
		spread = {x = 64, y = 64, z = 64},
		seed = 3,
		octaves = 2,
		persist = 0.66
	},
	place_offset_y = 1,
	y_max = 100,
	y_min = 3,
	schematic = schem_islands_tree,
	replacements = SCHEM_REPLACEMENTS,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:palm_tree_small",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter", "blocklife:dirt_with_grass"},
	sidelen = 2,
	noise_params = {
		offset = 0.03,
		scale = 0.04,
		spread = {x = 64, y = 64, z = 64},
		seed = 7,
		octaves = 2,
		persist = 0.66
	},
	y_max = 100,
	y_min = 3,
	schematic = {
            size = {x = 1, y = 3, z = 1},
            data = {
                {name = "air"},
                {name = "blocklife:palm_small_bottom"},
                {name = "blocklife:palm_small_top"},
            },
			rotation = "random",
	},
	flags = "place_center_x, place_center_z",
})


minetest.register_decoration({
	name = "blocklife:islands_grass",
	deco_type = "simple",
	place_on = {"blocklife:dirt_with_rainforest_litter","blocklife:dirt_with_grass"},
	sidelen = 2,
	noise_params = {
		offset = 0.15,
		scale = 0.05,
		spread = {x = 200, y = 200, z = 200},
		seed = 100,
		octaves = 3,
		persist = 0.6
	},
	y_max = 100,
	y_min = 3,
	decoration = "blocklife:islands_grass",
})

minetest.register_decoration({
	name = "blocklife:islands_underbrush",
	deco_type = "simple",
	place_on = {"blocklife:dirt_with_rainforest_litter"},
	sidelen = 2,
	noise_params = {
		offset = 0.15,
		scale = 0.05,
		spread = {x = 200, y = 200, z = 200},
		seed = 112,
		octaves = 3,
		persist = 0.6
	},
	y_max = 100,
	y_min = 3,
	decoration = "blocklife:islands_underbrush",
})

minetest.register_decoration({
	name = "blocklife:bush",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter","blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.02,
		spread = {x = 64, y = 64, z = 64},
		seed = 1511,
		octaves = 3,
		persist = 0.6
	},
	y_max = 31000,
	y_min = 2,
	schematic = schem_bush,
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "blocklife:blueberry_bush",
	deco_type = "schematic",
	place_on = {"blocklife:dirt_with_rainforest_litter","blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0005,
		scale = 0.001,
		spread = {x = 64, y = 64, z = 64},
		seed = 1511,
		octaves = 3,
		persist = 0.6
	},
	y_max = 31000,
	y_min = 2,
	schematic = schem_blueberry_bush,
	flags = "place_center_x, place_center_z",
})

-- cotton
minetest.register_decoration({
	name = "blocklife:islands_cotton_bush",
	deco_type = "simple",
	place_on = {"blocklife:dirt_with_rainforest_litter","blocklife:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.01,
		scale = 0.03,
		spread = {x = 64, y = 64, z = 64},
		seed = 1519,
		octaves = 3,
		persist = 0.6
	},
	y_max = 31000,
	y_min = 2,
	decoration = "farming:cotton_8",
})

	minetest.register_decoration({
		name = "blocklife:corals",
		deco_type = "simple",
		place_on = {"blocklife:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"blocklife:coral_green", "blocklife:coral_pink",
			"blocklife:coral_cyan", "blocklife:coral_brown",
			"blocklife:coral_orange", "blocklife:coral_skeleton",
		},
	})

	-- Kelp

		minetest.register_decoration({
			name = "blocklife:kelp",
		deco_type = "simple",
		place_on = {"blocklife:seabed"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "blocklife:sand_with_kelp",
			param2 = 48,
			param2_max = 96,
		})

minetest.register_craft({
	output = "blocklife:islands_wood 4",
	recipe = {
		{"blocklife:palm_tree"},
	}
})



--[[
isln_pos1 = {x=0,y=0,z=0}
isln_pos2 = {x=0,y=0,z=0}

minetest.register_on_chat_message(
	function(name, message)
		if message == 'pos1' then
			local plyr = minetest.get_player_by_name('singleplayer')
			isln_pos1 = plyr:get_pos()
			minetest.chat_send_all(dump(isln_pos1))
		end
	end
)	

minetest.register_on_chat_message(
	function(name, message)
		if message == 'doit' then
			local plyr = minetest.get_player_by_name('singleplayer')
			local pos = plyr:get_pos()
			minetest.chat_send_all(minetest.get_biome_name(minetest.get_biome_data(pos).biome))
		end
	end
)	

minetest.register_on_chat_message(
	function(name, message)
		if message == 'pos2' then
			local plyr = minetest.get_player_by_name('singleplayer')
			isln_pos2 = plyr:get_pos()
			isln_pos2.y = isln_pos2.y - 1.5
			minetest.chat_send_all(dump(isln_pos2))
		end
	end
)	
				
minetest.register_on_chat_message(
	function(name, message)
		if message == 'schm' then
			local fname = minetest.get_worldpath() .."/palm_tree.txt"
			minetest.chat_send_all(fname)
			minetest.create_schematic(isln_pos1,isln_pos2,nil,fname)
			minetest.chat_send_all('saved')
		end
	end
)	

minetest.register_on_chat_message(
	function(name, message)
		if message == 'place' then
			local fname = schem_palm_tree_big
			minetest.chat_send_all(fname)
			minetest.place_schematic(isln_pos1,fname,'random',SCHEM_REPLACEMENTS,false,'place_center_x,place_center_z')
			minetest.chat_send_all('plced')
		end
	end
)	
	--]]


islands.weathertimer = 0

local function get_adjusted_light(atime)
	atime = atime or minetest.get_timeofday()
	atime = math.abs(atime-0.5)
	local light
	if atime < 0.23 then
		return 1
	elseif atime > 0.32 then
		return 0.12
	else
		return (-atime+0.32)/0.09*0.88+0.12
	end
end

minetest.register_on_joinplayer(function(plyr)
	plyr:override_day_night_ratio(get_adjusted_light())
--	plyr:set_sky({sky_color={day_sky="#00D3F0"}})
	plyr:set_sky({sky_color={day_sky="#01C7EC",night_sky="#00FFFF",dawn_sky="#00AAFF"}})
	plyr:set_clouds({density=0.3})
end)

minetest.register_globalstep(function(dtime)
	islands.weathertimer = islands.weathertimer + dtime
	if islands.weathertimer > 5 then
		islands.weathertimer = 0
		
		local curtime = minetest.get_timeofday()
		local prefs = minetest.get_connected_players()
		for _,plyr in ipairs(prefs) do
			plyr:override_day_night_ratio(get_adjusted_light(curtime))
		end
	end
end)	

--[[
minetest.register_globalstep(function(dtime)
	islands.weathertimer = islands.weathertimer + dtime
	if islands.weathertimer > 5 then
		islands.weathertimer = 0
		local atime = math.abs(minetest.get_timeofday()-0.5)
		local light
		if atime < 0.2 then
			light = 1
		elseif atime > 0.32 then
			light = 0.1
		else
			light = (-atime+0.32)/0.12*0.9+0.1
		end
		
		local prefs = minetest.get_connected_players()
		for _,plyr in ipairs(prefs) do
			plyr:override_day_night_ratio(light)
			minetest.chat_send_all(tostring(atime) .. ' ' .. tostring(light))
		end
	end
end)	--]]


local floor = math.floor
local ceil = math.ceil
local min = math.min
local max = math.max
local random = math.random

local convex = false
local mpath = minetest.get_modpath('blocklands')




local mult = 1.0
-- Set the 3D noise parameters for the terrain.


local np_terrain = {
--	offset = -13,
	offset = -11*mult,						-- ratio 2:7 or 1:4 ?
	scale = 40*mult,
--	scale = 30,
	spread = {x = 256*mult, y =256*mult, z = 256*mult},
--	spread = {x = 128, y =128, z = 128},
	seed = 1234,
	octaves = convex and 1 or 5,
	persist = 0.38,
	lacunarity = 2.33,
	--flags = "eased"
}	--]]

local np_var = {
	offset = 0,						
	scale = 6*mult,
	spread = {x = 64*mult, y =64*mult, z = 64*mult},
	seed = 567891,
	octaves = 4,
	persist = 0.4,
	lacunarity = 1.89,
	--flags = "eased"
}

local np_hills = {
	offset = 2.5,					-- off/scale ~ 2:3
	scale = -3.5,
	spread = {x = 64*mult, y =64*mult, z = 64*mult},
--	spread = {x = 32, y =32, z = 32},
	seed = 2345,
	octaves = 3,
	persist = 0.40,
	lacunarity = 2.0,
	flags = "absvalue"
}

local np_cliffs = {
	offset = 0,					
	scale = 0.72,
	spread = {x = 180*mult, y =180*mult, z = 180*mult},
	seed = 78901,
	octaves = 2,
	persist = 0.4,
	lacunarity = 2.11,
--	flags = "absvalue"
}

local np_trees = {
	offset = - 0.003,
	scale = 0.008,
	spread = {x = 64, y = 64, z = 64},
	seed = 2,
	octaves = 5,
	persist = 1,
	lacunarity = 1.91,
--	flags = "absvalue"
}

local hills_offset = np_hills.spread.x*0.5
local hills_thresh = floor((np_terrain.scale)*0.5)
local shelf_thresh = floor((np_terrain.scale)*0.5) 
local cliffs_thresh=10

local function max_height(noiseprm)
	local height = 0
	local scale = noiseprm.scale
	for i=1,noiseprm.octaves do
		height=height + scale
		scale = scale * noiseprm.persist
	end	
	return height+noiseprm.offset
end

local function min_height(noiseprm)
	local height = 0
	local scale = noiseprm.scale
	for i=1,noiseprm.octaves do
		height=height - scale
		scale = scale * noiseprm.persist
	end	
	return height+noiseprm.offset
end

local base_min = min_height(np_terrain)
local base_max = max_height(np_terrain)
local base_rng = base_max-base_min
local easing_factor = 1/(base_max*base_max*4)
local base_heightmap = {}
local result_heightmap = {}


-- Set singlenode mapgen (air nodes only).
-- Disable the engine lighting calculation since that will be done for a
-- mapchunk of air nodes and will be incorrect after we place nodes.

--minetest.set_mapgen_params({mgname = "singlenode", flags = "nolight"})

minetest.set_mapgen_setting('mg_name','singlenode',true)
minetest.set_mapgen_setting('mg_flags','nolight,decorations,ores,biomes',true)


-- Get the content IDs for the nodes used.

local c_stone = minetest.get_content_id("blocklife:stone")
local c_sand = minetest.get_content_id("blocklife:sand")
local c_sand_dark = minetest.get_content_id("blocklife:seabed")
local c_dirt = minetest.get_content_id("blocklife:dirt")
local c_dirt_g = minetest.get_content_id("blocklife:dirt_with_grass")
local c_dirt_l = minetest.get_content_id("blocklife:dirt_with_rainforest_litter")
local c_snow = minetest.get_content_id("blocklife:dirt_with_snow")
local c_water     = minetest.get_content_id("blocklife:water_source")


-- Initialize noise object to nil. It will be created once only during the
-- generation of the first mapchunk, to minimise memory use.

local nobj_terrain = nil
local nobj_var = nil
local nobj_hills = nil
local nobj_cliffs = nil
local nobj_trees = nil


-- Localise noise buffer table outside the loop, to be re-used for all
-- mapchunks, therefore minimising memory use.

local nvals_terrain = {}
local isln_terrain = nil
local isln_var = nil
local isln_hills = nil
local isln_cliffs = nil
local isln_trees = nil


-- Localise data buffer table outside the loop, to be re-used for all
-- mapchunks, therefore minimising memory use.

local data = {}

local function get_terrain_height(theight,hheight,cheight)
		-- parabolic gradient
	if theight > 0 and theight < shelf_thresh then
		theight = theight * (theight*theight/(shelf_thresh*shelf_thresh)*0.5 + 0.5)
	end	
		-- hills
	if theight > hills_thresh then
		theight = theight + max((theight-hills_thresh) * hheight,0)
		-- cliffs
	elseif theight > 1 and theight < hills_thresh then 
		local clifh = max(min(cheight,1),0) 
		if clifh > 0 then
			clifh = -1*(clifh-1)*(clifh-1) + 1
			theight = theight + (hills_thresh-theight) * clifh * ((theight<2) and theight-1 or 1)
		end
	end
	return theight
end
 
-- On generated function.

-- 'minp' and 'maxp' are the minimum and maximum positions of the mapchunk that
-- define the 3D volume.
minetest.register_on_generated(function(minp, maxp, seed)
	-- Start time of mapchunk generation.
	local t0 = os.clock()
	
	local sidelen = maxp.x - minp.x + 1
--	local permapdims3d = {x = sidelen, y = sidelen, z = sidelen}
	local permapdims3d = {x = sidelen, y = sidelen, z = 0}
	
	-- base terrain
	nobj_terrain = nobj_terrain or
		minetest.get_perlin_map(np_terrain, permapdims3d)		
	isln_terrain=nobj_terrain:get_2d_map({x=minp.x,y=minp.z})
	
	-- base variation
	nobj_var = nobj_var or
		minetest.get_perlin_map(np_var, permapdims3d)		
	isln_var=nobj_var:get_2d_map({x=minp.x,y=minp.z})
	
	-- hills
	nobj_hills = nobj_hills or
		minetest.get_perlin_map(np_hills, permapdims3d)
	isln_hills=nobj_hills:get_2d_map({x=minp.x+hills_offset,y=minp.z+hills_offset})
	
	-- cliffs
	nobj_cliffs = nobj_cliffs or
		minetest.get_perlin_map(np_cliffs, permapdims3d)
	isln_cliffs=nobj_cliffs:get_2d_map({x=minp.x,y=minp.z})
	
	-- trees
	nobj_trees = nobj_trees or
		minetest.get_perlin_map(np_trees, permapdims3d)
	isln_trees=nobj_trees:get_2d_map({x=minp.x,y=minp.z})
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	vm:get_data(data)
	
	
	for z = 1, sidelen do
		base_heightmap[z]={}		
		result_heightmap[z]={}
		for x = 1, sidelen do
			local theight = isln_terrain[z][x] + (convex and isln_var[z][x] or 0)
			local hheight = isln_hills[z][x]
			local cheight = isln_cliffs[z][x]
			base_heightmap[z][x]=theight			
			result_heightmap[z][x]=get_terrain_height(theight,hheight,cheight)
		end
	end	

	for z = minp.z, maxp.z do
		for y = minp.y, maxp.y do
			for x = minp.x, maxp.x do
				local vi = area:index(x, y, z)								
				local bheight = base_heightmap[z-minp.z+1][x-minp.x+1]
				local theight = result_heightmap[z-minp.z+1][x-minp.x+1]
				
				local dirt = (theight > 2 and theight < hills_thresh and isln_trees[z-minp.z+1][x-minp.x+1] > 0) and c_dirt_l or c_dirt_g
				
				if theight > y then
					data[vi] = c_stone
				elseif y==ceil(theight) then
					data[vi]= y < -3 and c_sand_dark or y<4 and c_sand or (y<60-random(3) and dirt or c_snow)
				elseif y <= 1 then
					data[vi] = c_water
				end
			end
		end
	end

	vm:set_data(data)
	minetest.generate_decorations(vm)
	minetest.generate_ores(vm)
	vm:update_liquids()
	vm:calc_lighting()
	vm:write_to_map(true)
--	vm:update_liquids()
--	vm:update_liquids()
	minetest.after(0,function()
		minetest.fix_light(minp,maxp)
	end)
	
	-- Print generation time of this mapchunk.
	local chugent = ceil((os.clock() - t0) * 1000)
	print ("[lvm_example] Mapchunk generation time " .. chugent .. " ms")
end)

minetest.register_on_newplayer(function(obj)
	local nobj_terrain = minetest.get_perlin_map(np_terrain, {x=1,y=1,z=0})	
	local nobj_hills = minetest.get_perlin_map(np_hills, {x=1,y=1,z=0})	
	local nobj_cliffs = minetest.get_perlin_map(np_cliffs, {x=1,y=1,z=0})	
	local th=nobj_terrain:get_2d_map({x=1,y=1})
	local hh=nobj_hills:get_2d_map({x=1,y=1})
	local ch=nobj_cliffs:get_2d_map({x=1,y=1})
	local height = get_terrain_height(th[1][1],hh[1][1],ch[1][1])

	minetest.set_timeofday(0.30)
	local inv = obj:get_inventory()
	inv:add_item('main','blocklife:binoculars')
	local pos = obj:get_pos()
	local node = minetest.get_node(pos)
	if height<2 then
		pos.y = 2
		minetest.add_entity(pos,'blocklife:boat')
		pos.y = 3
		obj:set_pos(pos)
	else
		inv:add_item("main", "blocklife:boat")
		pos.y=height+2
		obj:set_pos(pos)
	end
	return true
end
)
