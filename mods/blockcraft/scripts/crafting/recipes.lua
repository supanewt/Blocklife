-- mods/default/crafting.lua

minetest.register_craft({
	output = "blocklife:wood 4",
	recipe = {
		{"blocklife:tree"},
	}
})



minetest.register_craft({
	output = "blocklife:wood",
	recipe = {
		{"blocklife:bush_stem"},
	}
})



minetest.register_craft({
	output = "blocklife:sign_wall_steel 3",
	recipe = {
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "blocklife:sign_wall_wood 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "blocklife:coalblock",
	recipe = {
		{"blocklife:coal_lump", "blocklife:coal_lump", "blocklife:coal_lump"},
		{"blocklife:coal_lump", "blocklife:coal_lump", "blocklife:coal_lump"},
		{"blocklife:coal_lump", "blocklife:coal_lump", "blocklife:coal_lump"},
	}
})

minetest.register_craft({
	output = "blocklife:steelblock",
	recipe = {
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:copperblock",
	recipe = {
		{"blocklife:copper_ingot", "blocklife:copper_ingot", "blocklife:copper_ingot"},
		{"blocklife:copper_ingot", "blocklife:copper_ingot", "blocklife:copper_ingot"},
		{"blocklife:copper_ingot", "blocklife:copper_ingot", "blocklife:copper_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:tinblock",
	recipe = {
		{"blocklife:tin_ingot", "blocklife:tin_ingot", "blocklife:tin_ingot"},
		{"blocklife:tin_ingot", "blocklife:tin_ingot", "blocklife:tin_ingot"},
		{"blocklife:tin_ingot", "blocklife:tin_ingot", "blocklife:tin_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:bronzeblock",
	recipe = {
		{"blocklife:bronze_ingot", "blocklife:bronze_ingot", "blocklife:bronze_ingot"},
		{"blocklife:bronze_ingot", "blocklife:bronze_ingot", "blocklife:bronze_ingot"},
		{"blocklife:bronze_ingot", "blocklife:bronze_ingot", "blocklife:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:bronze_ingot 9",
	recipe = {
		{"blocklife:bronzeblock"},
	}
})

minetest.register_craft({
	output = "blocklife:goldblock",
	recipe = {
		{"blocklife:gold_ingot", "blocklife:gold_ingot", "blocklife:gold_ingot"},
		{"blocklife:gold_ingot", "blocklife:gold_ingot", "blocklife:gold_ingot"},
		{"blocklife:gold_ingot", "blocklife:gold_ingot", "blocklife:gold_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:diamondblock",
	recipe = {
		{"blocklife:diamond", "blocklife:diamond", "blocklife:diamond"},
		{"blocklife:diamond", "blocklife:diamond", "blocklife:diamond"},
		{"blocklife:diamond", "blocklife:diamond", "blocklife:diamond"},
	}
})

minetest.register_craft({
	output = "blocklife:sandstone",
	recipe = {
		{"blocklife:sand", "blocklife:sand"},
		{"blocklife:sand", "blocklife:sand"},
	}
})

minetest.register_craft({
	output = "blocklife:sand 4",
	recipe = {
		{"blocklife:sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:sandstonebrick 4",
	recipe = {
		{"blocklife:sandstone", "blocklife:sandstone"},
		{"blocklife:sandstone", "blocklife:sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:sandstone_block 9",
	recipe = {
		{"blocklife:sandstone", "blocklife:sandstone", "blocklife:sandstone"},
		{"blocklife:sandstone", "blocklife:sandstone", "blocklife:sandstone"},
		{"blocklife:sandstone", "blocklife:sandstone", "blocklife:sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_sandstone",
	recipe = {
		{"blocklife:desert_sand", "blocklife:desert_sand"},
		{"blocklife:desert_sand", "blocklife:desert_sand"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_sand 4",
	recipe = {
		{"blocklife:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_sandstone_brick 4",
	recipe = {
		{"blocklife:desert_sandstone", "blocklife:desert_sandstone"},
		{"blocklife:desert_sandstone", "blocklife:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_sandstone_block 9",
	recipe = {
		{"blocklife:desert_sandstone", "blocklife:desert_sandstone", "blocklife:desert_sandstone"},
		{"blocklife:desert_sandstone", "blocklife:desert_sandstone", "blocklife:desert_sandstone"},
		{"blocklife:desert_sandstone", "blocklife:desert_sandstone", "blocklife:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:silver_sandstone",
	recipe = {
		{"blocklife:silver_sand", "blocklife:silver_sand"},
		{"blocklife:silver_sand", "blocklife:silver_sand"},
	}
})

minetest.register_craft({
	output = "blocklife:silver_sand 4",
	recipe = {
		{"blocklife:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:silver_sandstone_brick 4",
	recipe = {
		{"blocklife:silver_sandstone", "blocklife:silver_sandstone"},
		{"blocklife:silver_sandstone", "blocklife:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:silver_sandstone_block 9",
	recipe = {
		{"blocklife:silver_sandstone", "blocklife:silver_sandstone", "blocklife:silver_sandstone"},
		{"blocklife:silver_sandstone", "blocklife:silver_sandstone", "blocklife:silver_sandstone"},
		{"blocklife:silver_sandstone", "blocklife:silver_sandstone", "blocklife:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "blocklife:clay",
	recipe = {
		{"blocklife:clay_lump", "blocklife:clay_lump"},
		{"blocklife:clay_lump", "blocklife:clay_lump"},
	}
})

minetest.register_craft({
	output = "blocklife:brick",
	recipe = {
		{"blocklife:clay_brick", "blocklife:clay_brick"},
		{"blocklife:clay_brick", "blocklife:clay_brick"},
	}
})

minetest.register_craft({
	output = "blocklife:bookshelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"blocklife:book", "blocklife:book", "blocklife:book"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "blocklife:ladder_wood 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = "blocklife:ladder_steel 15",
	recipe = {
		{"blocklife:steel_ingot", "", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "", "blocklife:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocklife:mese",
	recipe = {
		{"blocklife:mese_crystal", "blocklife:mese_crystal", "blocklife:mese_crystal"},
		{"blocklife:mese_crystal", "blocklife:mese_crystal", "blocklife:mese_crystal"},
		{"blocklife:mese_crystal", "blocklife:mese_crystal", "blocklife:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocklife:meselamp",
	recipe = {
		{"blocklife:glass"},
		{"blocklife:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocklife:obsidian",
	recipe = {
		{"blocklife:obsidian_shard", "blocklife:obsidian_shard", "blocklife:obsidian_shard"},
		{"blocklife:obsidian_shard", "blocklife:obsidian_shard", "blocklife:obsidian_shard"},
		{"blocklife:obsidian_shard", "blocklife:obsidian_shard", "blocklife:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "blocklife:obsidianbrick 4",
	recipe = {
		{"blocklife:obsidian", "blocklife:obsidian"},
		{"blocklife:obsidian", "blocklife:obsidian"}
	}
})

minetest.register_craft({
	output = "blocklife:obsidian_block 9",
	recipe = {
		{"blocklife:obsidian", "blocklife:obsidian", "blocklife:obsidian"},
		{"blocklife:obsidian", "blocklife:obsidian", "blocklife:obsidian"},
		{"blocklife:obsidian", "blocklife:obsidian", "blocklife:obsidian"},
	}
})

minetest.register_craft({
	output = "blocklife:stonebrick 4",
	recipe = {
		{"blocklife:stone", "blocklife:stone"},
		{"blocklife:stone", "blocklife:stone"},
	}
})

minetest.register_craft({
	output = "blocklife:stone_block 9",
	recipe = {
		{"blocklife:stone", "blocklife:stone", "blocklife:stone"},
		{"blocklife:stone", "blocklife:stone", "blocklife:stone"},
		{"blocklife:stone", "blocklife:stone", "blocklife:stone"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_stonebrick 4",
	recipe = {
		{"blocklife:desert_stone", "blocklife:desert_stone"},
		{"blocklife:desert_stone", "blocklife:desert_stone"},
	}
})

minetest.register_craft({
	output = "blocklife:desert_stone_block 9",
	recipe = {
		{"blocklife:desert_stone", "blocklife:desert_stone", "blocklife:desert_stone"},
		{"blocklife:desert_stone", "blocklife:desert_stone", "blocklife:desert_stone"},
		{"blocklife:desert_stone", "blocklife:desert_stone", "blocklife:desert_stone"},
	}
})

minetest.register_craft({
	output = "blocklife:snowblock",
	recipe = {
		{"blocklife:snow", "blocklife:snow", "blocklife:snow"},
		{"blocklife:snow", "blocklife:snow", "blocklife:snow"},
		{"blocklife:snow", "blocklife:snow", "blocklife:snow"},
	}
})

minetest.register_craft({
	output = "blocklife:snow 9",
	recipe = {
		{"blocklife:snowblock"},
	}
})



--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})


--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "blocklife:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:obsidian_glass",
	recipe = "blocklife:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:stone",
	recipe = "blocklife:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:stone",
	recipe = "blocklife:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:desert_stone",
	recipe = "blocklife:desert_cobble",
})


--
-- Fuels
--

-- Support use of group:tree, includes blocklife:tree which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 30,
})

-- Burn time for all woods are in order of wood density,
-- which is also the order of wood colour darkness:
-- apple





-- Support use of group:wood, includes blocklife:wood which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})






-- Support use of group:sapling, includes blocklife:sapling which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:bush_sapling",
	burntime = 3,
})










minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:fence_wood",
	burntime = 7,
})






minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:fence_rail_wood",
	burntime = 5,
})



minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:bush_stem",
	burntime = 7,
})




minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:papyrus",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:ladder_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:lava_source",
	burntime = 60,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:sign_wall_wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:dry_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:fern_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:marram_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:dry_shrub",
	burntime = 2,
})
