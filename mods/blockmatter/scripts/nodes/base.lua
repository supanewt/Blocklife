-- mods/default/nodes.lua

-- support for MT game translation.
local S = blockman.get_translator

--[[ Node name convention:

Although many node names are in combined-word form, the required form for new
node names is words separated by underscores. If both forms are used in written
language the underscore form should be used.

--]]


--[[ Index:

Stone
-----
(1. Material 2. Cobble variant 3. Brick variant 4. Modified forms)

blocklife:stone
blocklife:cobble
blocklife:stonebrick
blocklife:stone_block
blocklife:mossycobble

blocklife:desert_stone
blocklife:desert_cobble
blocklife:desert_stonebrick
blocklife:desert_stone_block

blocklife:sandstone
blocklife:sandstonebrick
blocklife:sandstone_block
blocklife:desert_sandstone
blocklife:desert_sandstone_brick
blocklife:desert_sandstone_block
blocklife:silver_sandstone
blocklife:silver_sandstone_brick
blocklife:silver_sandstone_block

blocklife:obsidian
blocklife:obsidianbrick
blocklife:obsidian_block

Soft / Non-Stone
----------------
(1. Material 2. Modified forms)

blocklife:dirt
blocklife:dirt_with_grass
blocklife:dirt_with_grass_footsteps
blocklife:dirt_with_dry_grass
blocklife:dirt_with_snow
blocklife:dirt_with_rainforest_litter
blocklife:dirt_with_coniferous_litter
blocklife:dry_dirt
blocklife:dry_dirt_with_dry_grass

blocklife:permafrost
blocklife:permafrost_with_stones
blocklife:permafrost_with_moss

blocklife:sand
blocklife:desert_sand
blocklife:silver_sand

blocklife:gravel

blocklife:clay

blocklife:snow
blocklife:snowblock
blocklife:ice
blocklife:cave_ice

Trees
-----
(1. Trunk 2. Fabricated trunk 3. Leaves 4. Sapling 5. Fruits)

blocklife:tree
blocklife:wood
blocklife:leaves
blocklife:sapling
blocklife:apple


Ores
----
(1. In stone 2. Blocks)

blocklife:stone_with_coal
blocklife:coalblock

blocklife:stone_with_iron
blocklife:steelblock

blocklife:stone_with_copper
blocklife:copperblock

blocklife:stone_with_tin
blocklife:tinblock

blocklife:bronzeblock

blocklife:stone_with_gold
blocklife:goldblock

blocklife:stone_with_mese
blocklife:mese

blocklife:stone_with_diamond
blocklife:diamondblock

Plantlife
---------

blocklife:cactus

blocklife:papyrus
blocklife:dry_shrub
blocklife:grass_1
blocklife:grass_2
blocklife:grass_3
blocklife:grass_4
blocklife:grass_5

blocklife:dry_grass_1
blocklife:dry_grass_2
blocklife:dry_grass_3
blocklife:dry_grass_4
blocklife:dry_grass_5

blocklife:fern_1
blocklife:fern_2
blocklife:fern_3

blocklife:marram_grass_1
blocklife:marram_grass_2
blocklife:marram_grass_3

blocklife:bush_stem
blocklife:bush_leaves
blocklife:bush_sapling
blocklife:blueberry_bush_leaves_with_berries
blocklife:blueberry_bush_leaves
blocklife:blueberry_bush_sapling

blocklife:sand_with_kelp

Corals
------

blocklife:coral_green
blocklife:coral_pink
blocklife:coral_cyan
blocklife:coral_brown
blocklife:coral_orange
blocklife:coral_skeleton

Liquids
-------
(1. Source 2. Flowing)

blocklife:water_source
blocklife:water_flowing

blocklife:river_water_source
blocklife:river_water_flowing

blocklife:lava_source
blocklife:lava_flowing

Tools / "Advanced" crafting / Non-"natural"
-------------------------------------------

blocklife:bookshelf

blocklife:sign_wall_wood
blocklife:sign_wall_steel

blocklife:ladder_wood
blocklife:ladder_steel

blocklife:fence_wood

blocklife:fence_rail_wood

blocklife:glass
blocklife:obsidian_glass

blocklife:brick

blocklife:meselamp
blocklife:mese_post_light

Misc
----

blocklife:cloud

--]]

-- Required wrapper to allow customization of blockman.after_place_leaves
local function after_place_leaves(...)
	return blockman.after_place_leaves(...)
end

-- Required wrapper to allow customization of blockman.grow_sapling
local function grow_sapling(...)
	return blockman.grow_sapling(...)
end

--
-- Stone
--

minetest.register_node("blocklife:stone", {
	description = S("Stone"),
	tiles = {"blocklife_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocklife:cobble",
	legacy_mineral = true,
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:cobble", {
	description = S("Cobblestone"),
	tiles = {"blocklife_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = blockman.node_sound_stone_defaults(),
	_tnt_loss = 4,
})

minetest.register_node("blocklife:stonebrick", {
	description = S("Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:stone_block", {
	description = S("Stone Block"),
	tiles = {"blocklife_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"blocklife_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = blockman.node_sound_stone_defaults(),
	_tnt_loss = 4,
})

minetest.register_node("blocklife:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"blocklife_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocklife:desert_cobble",
	legacy_mineral = true,
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"blocklife_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = blockman.node_sound_stone_defaults(),
	_tnt_loss = 4,
})

minetest.register_node("blocklife:desert_stonebrick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_desert_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"blocklife_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:sandstone", {
	description = S("Sandstone"),
	tiles = {"blocklife_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:sandstonebrick", {
	description = S("Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = {"blocklife_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"blocklife_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"blocklife_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"blocklife_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_silver_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = {"blocklife_silver_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:obsidian", {
	description = S("Obsidian"),
	tiles = {"blocklife_obsidian.png"},
	sounds = blockman.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("blocklife:obsidianbrick", {
	description = S("Obsidian Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_obsidian_brick.png"},
	is_ground_content = false,
	sounds = blockman.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("blocklife:obsidian_block", {
	description = S("Obsidian Block"),
	tiles = {"blocklife_obsidian_block.png"},
	is_ground_content = false,
	sounds = blockman.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

--
-- Soft / Non-Stone
--

minetest.register_node("blocklife:dirt", {
	description = S("Dirt"),
	tiles = {"blocklife_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	_tnt_loss = 3,
})

minetest.register_node("blocklife:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles = {"blocklife_grass.png", "blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocklife:dirt_with_grass_footsteps", {
	description = S("Dirt with Grass and Footsteps"),
	tiles = {"blocklife_grass.png^blocklife_footprint.png", "blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocklife:dirt_with_dry_grass", {
	description = S("Dirt with Savanna Grass"),
	tiles = {"blocklife_dry_grass.png",
		"blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocklife:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"blocklife_snow.png", "blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_snow_footstep", gain = 0.2},
	}),
})

minetest.register_node("blocklife:dirt_with_rainforest_litter", {
	description = S("Dirt with Rainforest Litter"),
	tiles = {
		"blocklife_rainforest_litter.png",
		"blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_rainforest_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocklife:dirt_with_coniferous_litter", {
	description = S("Dirt with Coniferous Litter"),
	tiles = {
		"blocklife_coniferous_litter.png",
		"blocklife_dirt.png",
		{name = "blocklife_dirt.png^blocklife_coniferous_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocklife:dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocklife:dry_dirt", {
	description = S("Savanna Dirt"),
	tiles = {"blocklife_dry_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	_tnt_loss = 3,
})

minetest.register_node("blocklife:dry_dirt_with_dry_grass", {
	description = S("Savanna Dirt with Savanna Grass"),
	tiles = {"blocklife_dry_grass.png", "blocklife_dry_dirt.png",
		{name = "blocklife_dry_dirt.png^blocklife_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = "blocklife:dry_dirt",
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocklife:permafrost", {
	description = S("Permafrost"),
	tiles = {"blocklife_permafrost.png"},
	groups = {cracky = 3},
	sounds = blockman.node_sound_dirt_defaults(),
})

minetest.register_node("blocklife:permafrost_with_stones", {
	description = S("Permafrost with Stones"),
	tiles = {"blocklife_permafrost.png^blocklife_stones.png",
		"blocklife_permafrost.png",
		"blocklife_permafrost.png^blocklife_stones_side.png"},
	groups = {cracky = 3},
	sounds = blockman.node_sound_gravel_defaults(),
})

minetest.register_node("blocklife:permafrost_with_moss", {
	description = S("Permafrost with Moss"),
	tiles = {"blocklife_moss.png", "blocklife_permafrost.png",
		{name = "blocklife_permafrost.png^blocklife_moss_side.png",
			tileable_vertical = false}},
	groups = {cracky = 3},
	sounds = blockman.node_sound_dirt_defaults({
		footstep = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocklife:sand", {
	description = S("Sand"),
	tiles = {"blocklife_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = blockman.node_sound_sand_defaults(),
	_tnt_loss = 2,
})

minetest.register_node("blocklife:desert_sand", {
	description = S("Desert Sand"),
	tiles = {"blocklife_desert_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = blockman.node_sound_sand_defaults(),
	_tnt_loss = 2,
})

minetest.register_node("blocklife:silver_sand", {
	description = S("Silver Sand"),
	tiles = {"blocklife_silver_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = blockman.node_sound_sand_defaults(),
	_tnt_loss = 2,
})


minetest.register_node("blocklife:gravel", {
	description = S("Gravel"),
	tiles = {"blocklife_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = blockman.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:flint"}, rarity = 16},
			{items = {"blocklife:gravel"}}
		}
	},
	_tnt_loss = 3,
})

minetest.register_node("blocklife:clay", {
	description = S("Clay"),
	tiles = {"blocklife_clay.png"},
	groups = {crumbly = 3},
	drop = "blocklife:clay_lump 4",
	sounds = blockman.node_sound_dirt_defaults(),
})


minetest.register_node("blocklife:snow", {
	description = S("Snow"),
	tiles = {"blocklife_snow.png"},
	inventory_image = "blocklife_snowball.png",
	wield_image = "blocklife_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = blockman.node_sound_snow_defaults(),
	_tnt_loss = 1, -- means it will disappear entirely

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "blocklife:dirt_with_grass" then
			minetest.set_node(pos, {name = "blocklife:dirt_with_snow"})
		end
	end,
})

minetest.register_node("blocklife:snowblock", {
	description = S("Snow Block"),
	tiles = {"blocklife_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = blockman.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "blocklife:dirt_with_grass" then
			minetest.set_node(pos, {name = "blocklife:dirt_with_snow"})
		end
	end,
})

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("blocklife:ice", {
	description = S("Ice"),
	tiles = {"blocklife_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = blockman.node_sound_ice_defaults(),
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("blocklife:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"blocklife_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "blocklife:ice",
	sounds = blockman.node_sound_ice_defaults(),
})

--
-- Trees
--

minetest.register_node("blocklife:tree", {
	description = S("Apple Tree"),
	tiles = {"blocklife_tree_top.png", "blocklife_tree_top.png", "blocklife_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = blockman.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("blocklife:wood", {
	description = S("Apple Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocklife_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = blockman.node_sound_wood_defaults(),
})

minetest.register_node("blocklife:sapling", {
	description = S("Apple Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"blocklife_sapling.png"},
	inventory_image = "blocklife_sapling.png",
	wield_image = "blocklife_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = blockman.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = blockman.sapling_on_place(itemstack, placer, pointed_thing,
			"blocklife:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("blocklife:leaves", {
	description = S("Apple Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"blocklife_leaves.png"},
	special_tiles = {"blocklife_leaves_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"blocklife:sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"blocklife:leaves"},
				rarity = 5,
			}
		}
	},
	sounds = blockman.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("blocklife:apple", {
	description = S("Apple"),
	drawtype = "plantlike",
	tiles = {"blocklife_apple.png"},
	inventory_image = "blocklife_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1, food_apple = 1},
	on_use = minetest.item_eat(2),
	sounds = blockman.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "blocklife:apple", param2 = 1})
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			minetest.set_node(pos, {name = "blocklife:apple_mark"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end
	end,
})

minetest.register_node("blocklife:apple_mark", {
	description = S("Apple Marker"),
	inventory_image = "blocklife_apple.png^blocklife_invisible_node_overlay.png",
	wield_image = "blocklife_apple.png^blocklife_invisible_node_overlay.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_timer = function(pos, elapsed)
		if not minetest.find_node_near(pos, 1, "blocklife:leaves") then
			minetest.remove_node(pos)
		elseif minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "blocklife:apple"})
		end
	end
})





--
-- Ores
--

minetest.register_node("blocklife:stone_with_coal", {
	description = S("Coal Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_coal.png"},
	groups = {cracky = 3},
	drop = "blocklife:coal_lump",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:coalblock", {
	description = S("Coal Block"),
	tiles = {"blocklife_coal_block.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})


minetest.register_node("blocklife:stone_with_iron", {
	description = S("Iron Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_iron.png"},
	groups = {cracky = 2},
	drop = "blocklife:iron_lump",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:steelblock", {
	description = S("Steel Block"),
	tiles = {"blocklife_steel_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = blockman.node_sound_metal_defaults(),
})


minetest.register_node("blocklife:stone_with_copper", {
	description = S("Copper Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_copper.png"},
	groups = {cracky = 2},
	drop = "blocklife:copper_lump",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:copperblock", {
	description = S("Copper Block"),
	tiles = {"blocklife_copper_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = blockman.node_sound_metal_defaults(),
})


minetest.register_node("blocklife:stone_with_tin", {
	description = S("Tin Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_tin.png"},
	groups = {cracky = 2},
	drop = "blocklife:tin_lump",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:tinblock", {
	description = S("Tin Block"),
	tiles = {"blocklife_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = blockman.node_sound_metal_defaults(),
})


minetest.register_node("blocklife:bronzeblock", {
	description = S("Bronze Block"),
	tiles = {"blocklife_bronze_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = blockman.node_sound_metal_defaults(),
})


minetest.register_node("blocklife:stone_with_mese", {
	description = S("Mese Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_mese.png"},
	groups = {cracky = 1},
	drop = "blocklife:mese_crystal",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:mese", {
	description = S("Mese Block"),
	tiles = {"blocklife_mese_block.png"},
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	sounds = blockman.node_sound_stone_defaults(),
	light_source = 3,
})


minetest.register_node("blocklife:stone_with_gold", {
	description = S("Gold Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_gold.png"},
	groups = {cracky = 2},
	drop = "blocklife:gold_lump",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:goldblock", {
	description = S("Gold Block"),
	tiles = {"blocklife_gold_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = blockman.node_sound_metal_defaults(),
})


minetest.register_node("blocklife:stone_with_diamond", {
	description = S("Diamond Ore"),
	tiles = {"blocklife_stone.png^blocklife_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = "blocklife:diamond",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"blocklife_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = blockman.node_sound_stone_defaults(),
})

--
-- Plantlife (non-cubic)
--

minetest.register_node("blocklife:cactus", {
	description = S("Cactus"),
	tiles = {"blocklife_cactus_top.png", "blocklife_cactus_top.png",
		"blocklife_cactus_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 3},
	sounds = blockman.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_node("blocklife:papyrus", {
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"blocklife_papyrus.png"},
	inventory_image = "blocklife_papyrus.png",
	wield_image = "blocklife_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = blockman.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		blockman.dig_up(pos, node, digger)
	end,
})

minetest.register_node("blocklife:dry_shrub", {
	description = S("Dry Shrub"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_dry_shrub.png"},
	inventory_image = "blocklife_dry_shrub.png",
	wield_image = "blocklife_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})


minetest.register_node("blocklife:grass_1", {
	description = S("Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_grass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "blocklife_grass_3.png",
	wield_image = "blocklife_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1},
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("blocklife:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("blocklife:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("blocklife:grass_" .. i, {
		description = S("Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"blocklife_grass_" .. i .. ".png"},
		inventory_image = "blocklife_grass_" .. i .. ".png",
		wield_image = "blocklife_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "blocklife:grass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1, flammable = 1},
		sounds = blockman.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end


minetest.register_node("blocklife:dry_grass_1", {
	description = S("Savanna Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_dry_grass_1.png"},
	inventory_image = "blocklife_dry_grass_3.png",
	wield_image = "blocklife_dry_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, grass = 1, dry_grass = 1},
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("blocklife:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("blocklife:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("blocklife:dry_grass_" .. i, {
		description = S("Savanna Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"blocklife_dry_grass_" .. i .. ".png"},
		inventory_image = "blocklife_dry_grass_" .. i .. ".png",
		wield_image = "blocklife_dry_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, dry_grass = 1},
		drop = "blocklife:dry_grass_1",
		sounds = blockman.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end


minetest.register_node("blocklife:fern_1", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_fern_1.png"},
	inventory_image = "blocklife_fern_1.png",
	wield_image = "blocklife_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1,
		fern = 1, attached_node = 1},
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("blocklife:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("blocklife:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("blocklife:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"blocklife_fern_" .. i .. ".png"},
		inventory_image = "blocklife_fern_" .. i .. ".png",
		wield_image = "blocklife_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "blocklife:fern_1",
		sounds = blockman.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end


minetest.register_node("blocklife:marram_grass_1", {
	description = S("Marram Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_marram_grass_1.png"},
	inventory_image = "blocklife_marram_grass_1.png",
	wield_image = "blocklife_marram_grass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1, marram_grass = 1,
		attached_node = 1},
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("blocklife:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("blocklife:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("blocklife:marram_grass_" .. i, {
		description = S("Marram Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"blocklife_marram_grass_" .. i .. ".png"},
		inventory_image = "blocklife_marram_grass_" .. i .. ".png",
		wield_image = "blocklife_marram_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, marram_grass = 1, not_in_creative_inventory = 1},
		drop = "blocklife:marram_grass_1",
		sounds = blockman.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end


minetest.register_node("blocklife:bush_stem", {
	description = S("Bush Stem"),
	drawtype = "plantlike",
	visual_scale = 1.41,
	tiles = {"blocklife_bush_stem.png"},
	inventory_image = "blocklife_bush_stem.png",
	wield_image = "blocklife_bush_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = blockman.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
	},
})

minetest.register_node("blocklife:bush_leaves", {
	description = S("Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"blocklife_leaves_simple.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:bush_sapling"}, rarity = 5},
			{items = {"blocklife:bush_leaves"}}
		}
	},
	sounds = blockman.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("blocklife:bush_sapling", {
	description = S("Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"blocklife_bush_sapling.png"},
	inventory_image = "blocklife_bush_sapling.png",
	wield_image = "blocklife_bush_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = blockman.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = blockman.sapling_on_place(itemstack, placer, pointed_thing,
			"blocklife:bush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})

minetest.register_node("blocklife:blueberry_bush_leaves_with_berries", {
	description = S("Blueberry Bush Leaves with Berries"),
	drawtype = "allfaces_optional",
	tiles = {"blocklife_blueberry_bush_leaves.png^blocklife_blueberry_overlay.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1, dig_immediate = 3},
	drop = "blocklife:blueberries",
	sounds = blockman.node_sound_leaves_defaults(),
	node_dig_prediction = "blocklife:blueberry_bush_leaves",

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blocklife:blueberry_bush_leaves"})
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
})

minetest.register_node("blocklife:blueberry_bush_leaves", {
	description = S("Blueberry Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"blocklife_blueberry_bush_leaves.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:blueberry_bush_sapling"}, rarity = 5},
			{items = {"blocklife:blueberry_bush_leaves"}}
		}
	},
	sounds = blockman.node_sound_leaves_defaults(),

	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "blocklife:blueberry_bush_leaves_with_berries"})
		end
	end,

	after_place_node = after_place_leaves,
})

minetest.register_node("blocklife:blueberry_bush_sapling", {
	description = S("Blueberry Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"blocklife_blueberry_bush_sapling.png"},
	inventory_image = "blocklife_blueberry_bush_sapling.png",
	wield_image = "blocklife_blueberry_bush_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = blockman.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = blockman.sapling_on_place(itemstack, placer, pointed_thing,
			"blocklife:blueberry_bush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})


minetest.register_node("blocklife:sand_with_kelp", {
	description = S("Kelp"),
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"blocklife_sand.png"},
	special_tiles = {{name = "blocklife_kelp.png", tileable_vertical = true}},
	inventory_image = "blocklife_kelp.png",
	wield_image = "blocklife_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "blocklife:sand",
	node_placement_prediction = "",
	sounds = blockman.node_sound_sand_defaults({
		dig = {name = "blocklife_default_dig_snappy", gain = 0.2},
		dug = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and not (placer and placer:is_player()
				and placer:get_player_control().sneak) then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "blocklife:sand" then
			return itemstack
		end

		local height = math.random(4, 6)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "blocklife:sand_with_kelp",
					param2 = height * 16})
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blocklife:sand"})
	end
})


--
-- Corals
--

local function coral_on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	local player_name = placer and placer:get_player_name()
	local pos_under = pointed_thing.under
	local pos_above = pointed_thing.above
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick and not (
		placer and placer:is_player() and placer:get_player_control().sneak) then
		return def_under.on_rightclick(pos_under, node_under,
				placer, itemstack, pointed_thing)
	end

	if node_under.name ~= "blocklife:coral_skeleton" or
			minetest.get_node(pos_above).name ~= "blocklife:water_source" then
		return itemstack
	end

	if minetest.is_protected(pos_under, player_name) or
			minetest.is_protected(pos_above, player_name) then
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	node_under.name = itemstack:get_name()
	minetest.set_node(pos_under, node_under)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

minetest.register_node("blocklife:coral_green", {
	description = S("Green Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"blocklife_coral_skeleton.png"},
	special_tiles = {{name = "blocklife_coral_green.png", tileable_vertical = true}},
	inventory_image = "blocklife_coral_green.png",
	wield_image = "blocklife_coral_green.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "blocklife:coral_skeleton",
	node_placement_prediction = "",
	sounds = blockman.node_sound_stone_defaults({
		dig = {name = "blocklife_default_dig_snappy", gain = 0.2},
		dug = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blocklife:coral_skeleton"})
	end,
})

minetest.register_node("blocklife:coral_pink", {
	description = S("Pink Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"blocklife_coral_skeleton.png"},
	special_tiles = {{name = "blocklife_coral_pink.png", tileable_vertical = true}},
	inventory_image = "blocklife_coral_pink.png",
	wield_image = "blocklife_coral_pink.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "blocklife:coral_skeleton",
	node_placement_prediction = "",
	sounds = blockman.node_sound_stone_defaults({
		dig = {name = "blocklife_default_dig_snappy", gain = 0.2},
		dug = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blocklife:coral_skeleton"})
	end,
})

minetest.register_node("blocklife:coral_cyan", {
	description = S("Cyan Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"blocklife_coral_skeleton.png"},
	special_tiles = {{name = "blocklife_coral_cyan.png", tileable_vertical = true}},
	inventory_image = "blocklife_coral_cyan.png",
	wield_image = "blocklife_coral_cyan.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "blocklife:coral_skeleton",
	node_placement_prediction = "",
	sounds = blockman.node_sound_stone_defaults({
		dig = {name = "blocklife_default_dig_snappy", gain = 0.2},
		dug = {name = "blocklife_default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "blocklife:coral_skeleton"})
	end,
})

minetest.register_node("blocklife:coral_brown", {
	description = S("Brown Coral"),
	tiles = {"blocklife_coral_brown.png"},
	groups = {cracky = 3},
	drop = "blocklife:coral_skeleton",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:coral_orange", {
	description = S("Orange Coral"),
	tiles = {"blocklife_coral_orange.png"},
	groups = {cracky = 3},
	drop = "blocklife:coral_skeleton",
	sounds = blockman.node_sound_stone_defaults(),
})

minetest.register_node("blocklife:coral_skeleton", {
	description = S("Coral Skeleton"),
	tiles = {"blocklife_coral_skeleton.png"},
	groups = {cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})


--
-- Liquids
--

minetest.register_node("blocklife:water_source", {
	description = S("Water Source"),
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
	use_texture_alpha = "blend",
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
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = blockman.node_sound_water_defaults(),
})

minetest.register_node("blocklife:water_flowing", {
	description = S("Flowing Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"blocklife_water.png"},
	special_tiles = {
		{
			name = "blocklife_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "blocklife_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "blocklife:water_flowing",
	liquid_alternative_source = "blocklife:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = blockman.node_sound_water_defaults(),
})


minetest.register_node("blocklife:river_water_source", {
	description = S("River Water Source"),
	drawtype = "liquid",
	tiles = {
		{
			name = "blocklife_river_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "blocklife_river_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "blocklife:river_water_flowing",
	liquid_alternative_source = "blocklife:river_water_source",
	liquid_viscosity = 1,
	-- Not renewable to avoid horizontal spread of water sources in sloping
	-- rivers that can cause water to overflow riverbanks and cause floods.
	-- River water source is instead made renewable by the 'force renew'
	-- option used in the 'bucket' mod by the river water bucket.
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = blockman.node_sound_water_defaults(),
})

minetest.register_node("blocklife:river_water_flowing", {
	description = S("Flowing River Water"),
	drawtype = "flowingliquid",
	tiles = {"blocklife_river_water.png"},
	special_tiles = {
		{
			name = "blocklife_river_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "blocklife_river_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "blocklife:river_water_flowing",
	liquid_alternative_source = "blocklife:river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = blockman.node_sound_water_defaults(),
})


minetest.register_node("blocklife:lava_source", {
	description = S("Lava Source"),
	drawtype = "liquid",
	tiles = {
		{
			name = "blocklife_lava_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "blocklife_lava_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = blockman.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "blocklife:lava_flowing",
	liquid_alternative_source = "blocklife:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1},
})

minetest.register_node("blocklife:lava_flowing", {
	description = S("Flowing Lava"),
	drawtype = "flowingliquid",
	tiles = {"blocklife_lava.png"},
	special_tiles = {
		{
			name = "blocklife_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "blocklife_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = blockman.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "blocklife:lava_flowing",
	liquid_alternative_source = "blocklife:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

--
-- Tools / "Advanced" crafting / Non-"natural"
--

local bookshelf_formspec =
	"size[8,7;]" ..
	"list[context;books;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	blockman.get_hotbar_bg(0,2.85)

local function update_bookshelf(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("books")

	local formspec = bookshelf_formspec
	-- Inventory slots overlay
	local bx, by = 0, 0.3
	local n_written, n_empty = 0, 0
	for i = 1, 16 do
		if i == 9 then
			bx = 0
			by = by + 1
		end
		local stack = invlist[i]
		if stack:is_empty() then
			formspec = formspec ..
				"image[" .. bx .. "," .. by .. ";1,1;blocklife_bookshelf_slot.png]"
		else
			local metatable = stack:get_meta():to_table() or {}
			if metatable.fields and metatable.fields.text then
				n_written = n_written + stack:get_count()
			else
				n_empty = n_empty + stack:get_count()
			end
		end
		bx = bx + 1
	end
	meta:set_string("formspec", formspec)
	if n_written + n_empty == 0 then
		meta:set_string("infotext", S("Empty Bookshelf"))
	else
		meta:set_string("infotext", S("Bookshelf (@1 written, @2 empty books)", n_written, n_empty))
	end
end

local default_bookshelf_def = {
	description = S("Bookshelf"),
	tiles = {"blocklife_wood.png", "blocklife_wood.png", "blocklife_wood.png",
		"blocklife_wood.png", "blocklife_bookshelf.png", "blocklife_bookshelf.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = blockman.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
		update_bookshelf(pos)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_put = function(pos)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_move = function(pos)
		update_bookshelf(pos)
	end,
	on_blast = function(pos)
		local drops = {}
		blockman.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "blocklife:bookshelf"
		minetest.remove_node(pos)
		return drops
	end,
}
blockman.set_inventory_action_loggers(default_bookshelf_def, "bookshelf")
minetest.register_node("blocklife:bookshelf", default_bookshelf_def)

local function register_sign(material, desc, def)
	minetest.register_node("blocklife:sign_wall_" .. material, {
		description = desc,
		drawtype = "nodebox",
		tiles = {"blocklife_sign_wall_" .. material .. ".png"},
		inventory_image = "blocklife_sign_" .. material .. ".png",
		wield_image = "blocklife_sign_" .. material .. ".png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "opaque",
		node_box = {
			type = "wallmounted",
			wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
			wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
			wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
		},
		groups = def.groups,
		legacy_wallmounted = true,
		sounds = def.sounds,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "field[text;;${text}]")
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if not fields.quit then
				return -- workaround for https://github.com/luanti-org/luanti/issues/16187
			end
			local player_name = sender:get_player_name()
			if minetest.is_protected(pos, player_name) then
				minetest.record_protection_violation(pos, player_name)
				return
			end
			local text = fields.text
			if not text then
				return
			end
			if #text > 512 then
				minetest.chat_send_player(player_name, S("Text too long"))
				return
			end
			text = text:gsub("[%z\1-\8\11-\31\127]", "") -- strip naughty control characters (keeps \t and \n)
			blockman.log_player_action(sender, ("wrote %q to the sign at"):format(text), pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("text", text)

			if #text > 0 then
				meta:set_string("infotext", S('"@1"', text))
			else
				meta:set_string("infotext", '')
			end
		end,
	})
end

register_sign("wood", S("Wooden Sign"), {
	sounds = blockman.node_sound_wood_defaults(),
	groups = {choppy = 2, attached_node = 1, flammable = 2, oddly_breakable_by_hand = 3}
})

register_sign("steel", S("Steel Sign"), {
	sounds = blockman.node_sound_metal_defaults(),
	groups = {cracky = 2, attached_node = 1}
})

minetest.register_node("blocklife:ladder_wood", {
	description = S("Wooden Ladder"),
	drawtype = "signlike",
	tiles = {"blocklife_ladder_wood.png"},
	inventory_image = "blocklife_ladder_wood.png",
	wield_image = "blocklife_ladder_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = blockman.node_sound_wood_defaults(),
})

minetest.register_node("blocklife:ladder_steel", {
	description = S("Steel Ladder"),
	drawtype = "signlike",
	tiles = {"blocklife_ladder_steel.png"},
	inventory_image = "blocklife_ladder_steel.png",
	wield_image = "blocklife_ladder_steel.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky = 2},
	sounds = blockman.node_sound_metal_defaults(),
})

blockman.register_fence("blocklife:fence_wood", {
	description = S("Apple Wood Fence"),
	texture = "blocklife_fence_wood.png",
	inventory_image = "blocklife_fence_overlay.png^blocklife_wood.png^" ..
				"blocklife_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "blocklife_fence_overlay.png^blocklife_wood.png^" ..
				"blocklife_fence_overlay.png^[makealpha:255,126,126",
	material = "blocklife:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = blockman.node_sound_wood_defaults()
})





blockman.register_fence_rail("blocklife:fence_rail_wood", {
	description = S("Apple Wood Fence Rail"),
	texture = "blocklife_fence_rail_wood.png",
	inventory_image = "blocklife_fence_rail_overlay.png^blocklife_wood.png^" ..
				"blocklife_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "blocklife_fence_rail_overlay.png^blocklife_wood.png^" ..
				"blocklife_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "blocklife:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = blockman.node_sound_wood_defaults()
})





minetest.register_node("blocklife:glass", {
	description = S("Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocklife_glass.png", "blocklife_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = blockman.node_sound_glass_defaults(),
	_tnt_loss = 2,
})

minetest.register_node("blocklife:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocklife_obsidian_glass.png", "blocklife_obsidian_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = blockman.node_sound_glass_defaults(),
	groups = {cracky = 3},
})


minetest.register_node("blocklife:brick", {
	description = S("Brick Block"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"blocklife_brick.png^[transformFX",
		"blocklife_brick.png",
	},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = blockman.node_sound_stone_defaults(),
})


minetest.register_node("blocklife:meselamp", {
	description = S("Mese Lamp"),
	drawtype = "glasslike",
	tiles = {"blocklife_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = blockman.node_sound_glass_defaults(),
	light_source = blockman.LIGHT_MAX,
})

blockman.register_mesepost("blocklife:mese_post_light", {
	description = S("Apple Wood Mese Post Light"),
	texture = "blocklife_fence_wood.png",
	material = "blocklife:wood",
})





--
-- Misc
--

minetest.register_node("blocklife:cloud", {
	description = S("Cloud"),
	tiles = {"blocklife_cloud.png"},
	is_ground_content = false,
	sounds = blockman.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
})

--
-- register trees for leafdecay
--

if minetest.get_mapgen_setting("mg_name") == "v6" then
	blockman.register_leafdecay({
		trunks = {"blocklife:tree"},
		leaves = {"blocklife:apple", "blocklife:leaves"},
		radius = 2,
	})

else
	blockman.register_leafdecay({
		trunks = {"blocklife:tree"},
		leaves = {"blocklife:apple", "blocklife:leaves"},
		radius = 3,
	})

end




blockman.register_leafdecay({
	trunks = {"blocklife:bush_stem"},
	leaves = {"blocklife:bush_leaves"},
	radius = 1,
})
