-- carts/rails.lua

-- support for MT game translation.
local S = carts.get_translator

carts:register_rail("blocklife:rail", {
	description = S("Rail"),
	tiles = {
		"blocklife_carts_rail_straight.png", "blocklife_carts_rail_curved.png",
		"blocklife_carts_rail_t_junction.png", "blocklife_carts_rail_crossing.png"
	},
	inventory_image = "blocklife_carts_rail_straight.png",
	wield_image = "blocklife_carts_rail_straight.png",
	groups = carts:get_rail_groups(),
}, {})

minetest.register_craft({
	output = "blocklife:rail 18",
	recipe = {
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
	}
})

minetest.register_alias("carts:rail", "blocklife:rail")
minetest.register_alias("carts:powerrail", "blocklife:powerrail")
minetest.register_alias("carts:brakerail", "blocklife:brakerail")


carts:register_rail("blocklife:powerrail", {
	description = S("Powered Rail"),
	tiles = {
		"blocklife_carts_rail_straight_pwr.png", "blocklife_carts_rail_curved_pwr.png",
		"blocklife_carts_rail_t_junction_pwr.png", "blocklife_carts_rail_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = 5})

minetest.register_craft({
	output = "blocklife:powerrail 18",
	recipe = {
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:mese_crystal", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
	}
})


carts:register_rail("blocklife:brakerail", {
	description = S("Brake Rail"),
	tiles = {
		"blocklife_carts_rail_straight_brk.png", "blocklife_carts_rail_curved_brk.png",
		"blocklife_carts_rail_t_junction_brk.png", "blocklife_carts_rail_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = -3})

minetest.register_craft({
	output = "blocklife:brakerail 18",
	recipe = {
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:coal_lump", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "group:wood", "blocklife:steel_ingot"},
	}
})
