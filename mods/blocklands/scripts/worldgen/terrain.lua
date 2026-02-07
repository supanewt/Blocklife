--
-- Aliases for map generators
--

-- All mapgens

minetest.register_alias("mapgen_stone", "blocklife:stone")
minetest.register_alias("mapgen_water_source", "blocklife:water_source")
minetest.register_alias("mapgen_river_water_source", "blocklife:river_water_source")

-- Additional aliases needed for mapgen v6

minetest.register_alias("mapgen_lava_source", "blocklife:lava_source")
minetest.register_alias("mapgen_dirt", "blocklife:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "blocklife:dirt_with_grass")
minetest.register_alias("mapgen_sand", "blocklife:sand")
minetest.register_alias("mapgen_gravel", "blocklife:gravel")
minetest.register_alias("mapgen_desert_stone", "blocklife:desert_stone")
minetest.register_alias("mapgen_desert_sand", "blocklife:desert_sand")
minetest.register_alias("mapgen_dirt_with_snow", "blocklife:dirt_with_snow")
minetest.register_alias("mapgen_snowblock", "blocklife:snowblock")
minetest.register_alias("mapgen_snow", "blocklife:snow")
minetest.register_alias("mapgen_ice", "blocklife:ice")

minetest.register_alias("mapgen_tree", "blocklife:tree")
minetest.register_alias("mapgen_leaves", "blocklife:leaves")
minetest.register_alias("mapgen_apple", "blocklife:apple")

minetest.register_alias("mapgen_cobble", "blocklife:cobble")
minetest.register_alias("mapgen_stair_cobble", "blocklife:stair_cobble")
minetest.register_alias("mapgen_mossycobble", "blocklife:mossycobble")
minetest.register_alias("mapgen_stair_desert_stone", "blocklife:stair_desert_stone")


--
-- Register ores
--

-- Mgv6

function blockman.register_mgv6_ores()
	if blockshine and blockshine.register_mgv6_ores then
		return blockshine.register_mgv6_ores()
	end
end

-- All mapgens except mgv6

function blockman.register_ores()
	if blockshine and blockshine.register_ores then
		return blockshine.register_ores()
	end
end


--
-- Register biomes
--

-- All mapgens except mgv6

function blockman.register_biomes()

	-- Icesheet

	minetest.register_biome({
		name = "icesheet",
		node_dust = "blocklife:snowblock",
		node_top = "blocklife:snowblock",
		depth_top = 1,
		node_filler = "blocklife:snowblock",
		depth_filler = 3,
		node_stone = "blocklife:cave_ice",
		node_water_top = "blocklife:ice",
		depth_water_top = 10,
		node_river_water = "blocklife:ice",
		node_riverbed = "blocklife:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocklife:ice",
		node_dungeon_stair = "stairs:stair_ice",
		y_max = 31000,
		y_min = -8,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_ocean",
		node_dust = "blocklife:snowblock",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_water_top = "blocklife:ice",
		depth_water_top = 10,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -9,
		y_min = -255,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 0,
		humidity_point = 73,
	})

	-- Tundra

	minetest.register_biome({
		name = "tundra_highland",
		node_dust = "blocklife:snow",
		node_riverbed = "blocklife:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 47,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra",
		node_top = "blocklife:permafrost_with_stones",
		depth_top = 1,
		node_filler = "blocklife:permafrost",
		depth_filler = 1,
		node_riverbed = "blocklife:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_beach",
		node_top = "blocklife:gravel",
		depth_top = 1,
		node_filler = "blocklife:gravel",
		depth_filler = 2,
		node_riverbed = "blocklife:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 1,
		y_min = -3,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:gravel",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = -4,
		y_min = -255,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 0,
		humidity_point = 40,
	})

	-- Taiga

	minetest.register_biome({
		name = "taiga",
		node_dust = "blocklife:snow",
		node_top = "blocklife:dirt_with_snow",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_ocean",
		node_dust = "blocklife:snow",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 25,
		humidity_point = 70,
	})

	-- Snowy grassland

	minetest.register_biome({
		name = "snowy_grassland",
		node_dust = "blocklife:snow",
		node_top = "blocklife:dirt_with_snow",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 1,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 4,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_ocean",
		node_dust = "blocklife:snow",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 20,
		humidity_point = 35,
	})

	-- Grassland

	minetest.register_biome({
		name = "grassland",
		node_top = "blocklife:dirt_with_grass",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 1,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 6,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_dunes",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 2,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 3,
		y_min = -255,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 50,
		humidity_point = 35,
	})

	-- Coniferous forest

	minetest.register_biome({
		name = "coniferous_forest",
		node_top = "blocklife:dirt_with_coniferous_litter",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_dunes",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 3,
		y_min = -255,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 45,
		humidity_point = 70,
	})

	-- Deciduous forest

	minetest.register_biome({
		name = "deciduous_forest",
		node_top = "blocklife:dirt_with_grass",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_shore",
		node_top = "blocklife:dirt",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 0,
		y_min = -1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 68,
	})

	-- Desert

	minetest.register_biome({
		name = "desert",
		node_top = "blocklife:desert_sand",
		depth_top = 1,
		node_filler = "blocklife:desert_sand",
		depth_filler = 1,
		node_stone = "blocklife:desert_stone",
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:desert_stone",
		node_dungeon_stair = "stairs:stair_desert_stone",
		y_max = 31000,
		y_min = 4,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_stone = "blocklife:desert_stone",
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:desert_stone",
		node_dungeon_stair = "stairs:stair_desert_stone",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 92,
		humidity_point = 16,
	})

	-- Sandstone desert

	minetest.register_biome({
		name = "sandstone_desert",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 1,
		node_stone = "blocklife:sandstone",
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_max = 31000,
		y_min = 4,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_stone = "blocklife:sandstone",
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_max = 3,
		y_min = -255,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 0,
	})

	-- Cold desert

	minetest.register_biome({
		name = "cold_desert",
		node_top = "blocklife:silver_sand",
		depth_top = 1,
		node_filler = "blocklife:silver_sand",
		depth_filler = 1,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 4,
		heat_point = 40,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "cold_desert_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 40,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "cold_desert_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 40,
		humidity_point = 0,
	})

	-- Savanna

	minetest.register_biome({
		name = "savanna",
		node_top = "blocklife:dry_dirt_with_dry_grass",
		depth_top = 1,
		node_filler = "blocklife:dry_dirt",
		depth_filler = 1,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_shore",
		node_top = "blocklife:dry_dirt",
		depth_top = 1,
		node_filler = "blocklife:dry_dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 0,
		y_min = -1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 89,
		humidity_point = 42,
	})

	-- Rainforest

	minetest.register_biome({
		name = "rainforest",
		node_top = "blocklife:dirt_with_rainforest_litter",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_swamp",
		node_top = "blocklife:dirt",
		depth_top = 1,
		node_filler = "blocklife:dirt",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 0,
		y_min = -1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_ocean",
		node_top = "blocklife:sand",
		depth_top = 1,
		node_filler = "blocklife:sand",
		depth_filler = 3,
		node_riverbed = "blocklife:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocklife:water_source",
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_under",
		node_cave_liquid = {"blocklife:water_source", "blocklife:lava_source"},
		node_dungeon = "blocklife:cobble",
		node_dungeon_alt = "blocklife:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 86,
		humidity_point = 65,
	})
end


--
-- Register decorations
--

-- Mgv6

function blockman.register_mgv6_decorations()

	-- Papyrus

	minetest.register_decoration({
		name = "blocklife:papyrus",
		deco_type = "simple",
		place_on = {"blocklife:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 100, y = 100, z = 100},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		y_max = 1,
		y_min = 1,
		decoration = "blocklife:papyrus",
		height = 2,
		height_max = 4,
		spawn_by = "blocklife:water_source",
		num_spawn_by = 1,
	})

	-- Cacti

	minetest.register_decoration({
		name = "blocklife:cactus",
		deco_type = "simple",
		place_on = {"blocklife:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 30,
		y_min = 1,
		decoration = "blocklife:cactus",
		height = 3,
	        height_max = 4,
	})

	-- Long grasses

	for length = 1, 5 do
		minetest.register_decoration({
			name = "blocklife:grass_"..length,
			deco_type = "simple",
			place_on = {"blocklife:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.007,
				spread = {x = 100, y = 100, z = 100},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			y_max = 30,
			y_min = 1,
			decoration = "blocklife:grass_"..length,
		})
	end

	-- Dry shrubs

	minetest.register_decoration({
		name = "blocklife:dry_shrub",
		deco_type = "simple",
		place_on = {"blocklife:desert_sand", "blocklife:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_max = 30,
		y_min = 1,
		decoration = "blocklife:dry_shrub",
		param2 = 4,
	})
end


-- All mapgens except mgv6

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "blocklife:grass_" .. length,
		deco_type = "simple",
		place_on = {"blocklife:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "blocklife:grass_" .. length,
	})
end

local function register_dry_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "blocklife:dry_grass_" .. length,
		deco_type = "simple",
		place_on = {"blocklife:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "blocklife:dry_grass_" .. length,
	})
end

local function register_fern_decoration(seed, length)
	minetest.register_decoration({
		name = "blocklife:fern_" .. length,
		deco_type = "simple",
		place_on = {"blocklife:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"coniferous_forest"},
		y_max = 31000,
		y_min = 6,
		decoration = "blocklife:fern_" .. length,
	})
end


function blockman.register_decorations()
	-- Savanna bare dirt patches.
	-- Must come before all savanna decorations that are placed on dry grass.
	-- Noise is similar to long dry grass noise, but scale inverted, to appear
	-- where long dry grass is least dense and shortest.

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"blocklife:dry_dirt_with_dry_grass"},
		sidelen = 4,
		noise_params = {
			offset = -1.5,
			scale = -1.5,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 4,
			persist = 1.0
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "blocklife:dry_dirt",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Apple tree and log

	minetest.register_decoration({
		name = "blocklife:apple_tree",
		deco_type = "schematic",
		place_on = {"blocklife:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.024,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("blockfx") .. "/schematics/blocklife_apple_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		name = "blocklife:apple_log",
		deco_type = "schematic",
		place_on = {"blocklife:dirt_with_grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("blockfx") .. "/schematics/blocklife_apple_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "blocklife:dirt_with_grass",
		num_spawn_by = 8,
	})

	-- Acacia tree and log

	-- Cactus

	minetest.register_decoration({
		name = "blocklife:cactus",
		deco_type = "simple",
		place_on = {"blocklife:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert"},
		y_max = 31000,
		y_min = 4,
		decoration = "blocklife:cactus",
		height = 2,
		height_max = 5,
	})

	-- Papyrus

	-- Dirt version for rainforest swamp

	minetest.register_decoration({
		name = "blocklife:papyrus_on_dirt",
		deco_type = "schematic",
		place_on = {"blocklife:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"rainforest_swamp"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("blockfx") .. "/schematics/blocklife_papyrus_on_dirt.mts",
	})

	-- Dry dirt version for savanna shore

	minetest.register_decoration({
		name = "blocklife:papyrus_on_dry_dirt",
		deco_type = "schematic",
		place_on = {"blocklife:dry_dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"savanna_shore"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("blockfx") ..
			"/schematics/blocklife_papyrus_on_dry_dirt.mts",
	})

	-- Bush

	minetest.register_decoration({
		name = "blocklife:bush",
		deco_type = "schematic",
		place_on = {"blocklife:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("blockfx") .. "/schematics/blocklife_bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Blueberry bush

	minetest.register_decoration({
		name = "blocklife:blueberry_bush",
		deco_type = "schematic",
		place_on = {"blocklife:dirt_with_grass", "blocklife:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 697,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"grassland", "snowy_grassland"},
		y_max = 31000,
		y_min = 1,
		place_offset_y = 1,
		schematic = minetest.get_modpath("blockfx") .. "/schematics/blocklife_blueberry_bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Acacia bush

	-- Grasses

	register_grass_decoration(-0.03,  0.09,  5)
	register_grass_decoration(-0.015, 0.075, 4)
	register_grass_decoration(0,      0.06,  3)
	register_grass_decoration(0.015,  0.045, 2)
	register_grass_decoration(0.03,   0.03,  1)

	-- Dry grasses

	register_dry_grass_decoration(0.01, 0.05,  5)
	register_dry_grass_decoration(0.03, 0.03,  4)
	register_dry_grass_decoration(0.05, 0.01,  3)
	register_dry_grass_decoration(0.07, -0.01, 2)
	register_dry_grass_decoration(0.09, -0.03, 1)

	-- Ferns

	register_fern_decoration(14936, 3)
	register_fern_decoration(801,   2)
	register_fern_decoration(5,     1)

	-- Dry shrub

	minetest.register_decoration({
		name = "blocklife:dry_shrub",
		deco_type = "simple",
		place_on = {"blocklife:desert_sand",
			"blocklife:sand", "blocklife:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert", "sandstone_desert", "cold_desert"},
		y_max = 31000,
		y_min = 2,
		decoration = "blocklife:dry_shrub",
		param2 = 4,
	})

	-- Marram grass

	minetest.register_decoration({
		name = "blocklife:marram_grass",
		deco_type = "simple",
		place_on = {"blocklife:sand"},
		sidelen = 4,
		noise_params = {
			offset = -0.7,
			scale = 4.0,
			spread = {x = 16, y = 16, z = 16},
			seed = 513337,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
		biomes = {"coniferous_forest_dunes", "grassland_dunes"},
		y_max = 6,
		y_min = 4,
		decoration = {
			"blocklife:marram_grass_1",
			"blocklife:marram_grass_2",
			"blocklife:marram_grass_3",
		},
	})

	-- Tundra moss

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"blocklife:permafrost_with_stones"},
		sidelen = 4,
		noise_params = {
			offset = -0.8,
			scale = 2.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 53995,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra"},
		y_max = 50,
		y_min = 2,
		decoration = "blocklife:permafrost_with_moss",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Tundra patchy snow

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {
			"blocklife:permafrost_with_moss",
			"blocklife:permafrost_with_stones",
			"blocklife:stone",
			"blocklife:gravel"
		},
		sidelen = 4,
		noise_params = {
			offset = 0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 172555,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra", "tundra_beach"},
		y_max = 50,
		y_min = 1,
		decoration = "blocklife:snow",
	})

	-- Coral reef

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
		biomes = {
			"desert_ocean",
			"savanna_ocean",
			"rainforest_ocean",
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
		place_on = {"blocklife:sand"},
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
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "blocklife:sand_with_kelp",
		param2 = 48,
		param2_max = 96,
	})
end


--
-- Detect mapgen to select functions
--


local mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name == "v6" then
	blockman.register_mgv6_ores()
	blockman.register_mgv6_decorations()
else
	blockman.register_biomes()
	blockman.register_ores()
	blockman.register_decorations()
end
