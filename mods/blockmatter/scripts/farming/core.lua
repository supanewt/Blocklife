-- farming/core.lua

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.farming = blockman.farming or {}
local farming = blockman.farming
blockman.expose_global("farming", farming)

-- Load support for MT game translation.
local S = minetest.get_translator("blockmatter")

-- Global farming namespace

farming.path = minetest.get_modpath("blockmatter") .. "/scripts/farming"
farming.get_translator = S

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/tools.lua")


-- Wheat

farming.register_plant("blocklife:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "blocklife_farming_wheat_seed.png",
	texture_name = "farming",
	steps = 8,
	minlight = 13,
	maxlight = blockman.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("blocklife:flour", {
	description = S("Flour"),
	inventory_image = "blocklife_farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("blocklife:bread", {
	description = S("Bread"),
	inventory_image = "blocklife_farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "blocklife:flour",
	recipe = {"blocklife:wheat", "blocklife:wheat", "blocklife:wheat", "blocklife:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "blocklife:bread",
	recipe = "blocklife:flour"
})


-- Cotton

farming.register_plant("blocklife:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "blocklife_farming_cotton_seed.png",
	texture_name = "farming",
	steps = 8,
	minlight = 13,
	maxlight = blockman.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

minetest.register_on_mods_loaded(function()
	if not minetest.get_biome_id("savanna") then
		minetest.log("warning", "[blockmatter] cotton_wild decoration skipped: biome 'savanna' not found")
		return
	end

	minetest.register_decoration({
		name = "blocklife:cotton_wild",
		deco_type = "simple",
		place_on = {"blocklife:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 50, y = 50, z = 50},
			seed = 4242,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "blocklife:cotton_wild",
	})
end)

minetest.register_craftitem("blocklife:string", {
	description = S("String"),
	inventory_image = "blocklife_farming_string.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "blocklife:wool_white",
	recipe = {
		{"blocklife:cotton", "blocklife:cotton"},
		{"blocklife:cotton", "blocklife:cotton"},
	}
})

minetest.register_craft({
	output = "blocklife:string 2",
	recipe = {
		{"blocklife:cotton"},
		{"blocklife:cotton"},
	}
})


-- Straw

minetest.register_craft({
	output = "blocklife:straw 3",
	recipe = {
		{"blocklife:wheat", "blocklife:wheat", "blocklife:wheat"},
		{"blocklife:wheat", "blocklife:wheat", "blocklife:wheat"},
		{"blocklife:wheat", "blocklife:wheat", "blocklife:wheat"},
	}
})

minetest.register_craft({
	output = "blocklife:wheat 3",
	recipe = {
		{"blocklife:straw"},
	}
})


-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:wheat",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:cotton",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:string",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:hoe_wood",
	burntime = 5,
})


-- Register farming items as dungeon loot

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "blocklife:string", chance = 0.5, count = {1, 8}},
		{name = "blocklife:wheat", chance = 0.5, count = {2, 5}},
		{name = "blocklife:seed_cotton", chance = 0.4, count = {1, 4},
			types = {"normal"}},
	})
end

local function alias_crop(pname, steps)
	minetest.register_alias("farming:seed_" .. pname, "blocklife:seed_" .. pname)
	minetest.register_alias("farming:" .. pname, "blocklife:" .. pname)
	for i = 1, steps do
		minetest.register_alias("farming:" .. pname .. "_" .. i, "blocklife:" .. pname .. "_" .. i)
	end
end

alias_crop("wheat", 8)
alias_crop("cotton", 8)

minetest.register_alias("farming:flour", "blocklife:flour")
minetest.register_alias("farming:bread", "blocklife:bread")
minetest.register_alias("farming:string", "blocklife:string")
minetest.register_alias("farming:straw", "blocklife:straw")
