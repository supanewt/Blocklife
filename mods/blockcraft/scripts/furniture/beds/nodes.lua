-- beds/nodes.lua

-- support for MT game translation.
local S = beds.get_translator

-- Fancy shaped bed

beds.register_bed("blocklife:fancy_bed", {
	description = S("Fancy Bed"),
	inventory_image = "blocklife_beds_bed_fancy.png",
	wield_image = "blocklife_beds_bed_fancy.png",
	tiles = {
		bottom = {
			"blocklife_beds_bed_top1.png",
			"blocklife_beds_bed_under.png",
			"blocklife_beds_bed_side1.png",
			"blocklife_beds_bed_side1.png^[transformFX",
			"blocklife_beds_bed_foot.png",
			"blocklife_beds_bed_foot.png",
		},
		top = {
			"blocklife_beds_bed_top2.png",
			"blocklife_beds_bed_under.png",
			"blocklife_beds_bed_side2.png",
			"blocklife_beds_bed_side2.png^[transformFX",
			"blocklife_beds_bed_head.png",
			"blocklife_beds_bed_head.png",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		},
		top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		}
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"blocklife:wool_white", "blocklife:wool_white", "blocklife:wool_white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Simple shaped bed

beds.register_bed("blocklife:bed", {
	description = S("Simple Bed"),
	inventory_image = "blocklife_beds_bed.png",
	wield_image = "blocklife_beds_bed.png",
	tiles = {
		bottom = {
			"blocklife_beds_bed_top_bottom.png^[transformR90",
			"blocklife_beds_bed_under.png",
			"blocklife_beds_bed_side_bottom_r.png",
			"blocklife_beds_bed_side_bottom_r.png^[transformFX",
			"blank.png",
			"blocklife_beds_bed_side_bottom.png"
		},
		top = {
			"blocklife_beds_bed_top_top.png^[transformR90",
			"blocklife_beds_bed_under.png",
			"blocklife_beds_bed_side_top_r.png",
			"blocklife_beds_bed_side_top_r.png^[transformFX",
			"blocklife_beds_bed_side_top.png",
			"blank.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
	recipe = {
		{"blocklife:wool_white", "blocklife:wool_white", "blocklife:wool_white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Aliases for PilzAdam's beds mod

minetest.register_alias("blocklife:bed_bottom_red", "blocklife:bed_bottom")
minetest.register_alias("blocklife:bed_top_red", "blocklife:bed_top")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:fancy_bed_bottom",
	burntime = 13,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:bed_bottom",
	burntime = 12,
})
