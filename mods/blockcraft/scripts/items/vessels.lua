-- vessels/init.lua

-- Minetest Game mod: vessels
-- See README.txt for licensing and other information.

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")


local vessels_shelf_formspec =
	"size[8,7;]" ..
	"list[context;vessels;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;vessels]" ..
	"listring[current_player;main]" ..
	blockman.get_hotbar_bg(0, 2.85)

local function update_vessels_shelf(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("vessels")

	local formspec = vessels_shelf_formspec
	-- Inventory slots overlay
	local vx, vy = 0, 0.3
	local n_items = 0
	for i = 1, 16 do
		if i == 9 then
			vx = 0
			vy = vy + 1
		end
		if not invlist or invlist[i]:is_empty() then
			formspec = formspec ..
				"image[" .. vx .. "," .. vy .. ";1,1;blocklife_vessels_shelf_slot.png]"
		else
			local stack = invlist[i]
			if not stack:is_empty() then
				n_items = n_items + stack:get_count()
			end
		end
		vx = vx + 1
	end
	meta:set_string("formspec", formspec)
	if n_items == 0 then
		meta:set_string("infotext", S("Empty Vessels Shelf"))
	else
		meta:set_string("infotext", S("Vessels Shelf (@1 items)", n_items))
	end
end

local vessels_shelf_def = {
	description = S("Vessels Shelf"),
	tiles = {"blocklife_wood.png", "blocklife_wood.png", "blocklife_wood.png",
		"blocklife_wood.png", "blocklife_vessels_shelf.png", "blocklife_vessels_shelf.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = blockman.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		update_vessels_shelf(pos)
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("vessels")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_blast = function(pos)
		local drops = {}
		blockman.get_inventory_drops(pos, "vessels", drops)
		drops[#drops + 1] = "blocklife:shelf"
		minetest.remove_node(pos)
		return drops
	end,
	on_metadata_inventory_put = function(pos)
		update_vessels_shelf(pos)
	end,
	on_metadata_inventory_take = function(pos)
		update_vessels_shelf(pos)
	end,
	on_metadata_inventory_move = function(pos)
		update_vessels_shelf(pos)
	end,
}
blockman.set_inventory_action_loggers(vessels_shelf_def, "vessels shelf")
minetest.register_node("blocklife:shelf", vessels_shelf_def)

minetest.register_craft({
	output = "blocklife:shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_node("blocklife:glass_bottle", {
	description = S("Empty Glass Bottle"),
	drawtype = "plantlike",
	tiles = {"blocklife_vessels_glass_bottle.png"},
	inventory_image = "blocklife_vessels_glass_bottle.png",
	wield_image = "blocklife_vessels_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = blockman.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "blocklife:glass_bottle 10",
	recipe = {
		{"blocklife:glass", "", "blocklife:glass"},
		{"blocklife:glass", "", "blocklife:glass"},
		{"", "blocklife:glass", ""}
	}
})

minetest.register_node("blocklife:drinking_glass", {
	description = S("Empty Drinking Glass"),
	drawtype = "plantlike",
	tiles = {"blocklife_vessels_drinking_glass.png"},
	inventory_image = "blocklife_vessels_drinking_glass_inv.png",
	wield_image = "blocklife_vessels_drinking_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = blockman.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "blocklife:drinking_glass 14",
	recipe = {
		{"blocklife:glass", "", "blocklife:glass"},
		{"blocklife:glass", "", "blocklife:glass"},
		{"blocklife:glass", "blocklife:glass", "blocklife:glass"}
	}
})

minetest.register_node("blocklife:steel_bottle", {
	description = S("Empty Heavy Steel Bottle"),
	drawtype = "plantlike",
	tiles = {"blocklife_vessels_steel_bottle.png"},
	inventory_image = "blocklife_vessels_steel_bottle.png",
	wield_image = "blocklife_vessels_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = blockman.node_sound_defaults(),
})

minetest.register_craft( {
	output = "blocklife:steel_bottle 5",
	recipe = {
		{"blocklife:steel_ingot", "", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "", "blocklife:steel_ingot"},
		{"", "blocklife:steel_ingot", ""}
	}
})


-- Glass and steel recycling

minetest.register_craftitem("blocklife:glass_fragments", {
	description = S("Glass Fragments"),
	inventory_image = "blocklife_vessels_glass_fragments.png",
})

minetest.register_craft( {
	type = "shapeless",
	output = "blocklife:glass_fragments",
	recipe = {
		"blocklife:glass_bottle",
		"blocklife:glass_bottle",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "blocklife:glass_fragments",
	recipe = {
		"blocklife:drinking_glass",
		"blocklife:drinking_glass",
	},
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:glass",
	recipe = "blocklife:glass_fragments",
})

minetest.register_craft( {
	type = "cooking",
	output = "blocklife:steel_ingot",
	recipe = "blocklife:steel_bottle",
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:shelf",
	burntime = 30,
})

-- Register glass fragments as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		name = "blocklife:glass_fragments", chance = 0.35, count = {1, 4}
	})
end


minetest.register_alias("vessels:shelf", "blocklife:shelf")
minetest.register_alias("vessels:glass_bottle", "blocklife:glass_bottle")
minetest.register_alias("vessels:drinking_glass", "blocklife:drinking_glass")
minetest.register_alias("vessels:steel_bottle", "blocklife:steel_bottle")
minetest.register_alias("vessels:glass_fragments", "blocklife:glass_fragments")
