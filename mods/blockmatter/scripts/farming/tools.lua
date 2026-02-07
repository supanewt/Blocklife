-- farming/hoes.lua

-- support for MT game translation.
local S = farming.get_translator

farming.register_hoe(":blocklife:hoe_wood", {
	description = S("Wooden Hoe"),
	inventory_image = "blocklife_farming_tool_woodhoe.png",
	max_uses = 30,
	material = "group:wood",
	groups = {hoe = 1, flammable = 2},
})

farming.register_hoe(":blocklife:hoe_stone", {
	description = S("Stone Hoe"),
	inventory_image = "blocklife_farming_tool_stonehoe.png",
	max_uses = 90,
	material = "group:stone",
	groups = {hoe = 1}
})

farming.register_hoe(":blocklife:hoe_steel", {
	description = S("Steel Hoe"),
	inventory_image = "blocklife_farming_tool_steelhoe.png",
	max_uses = 500,
	material = "blocklife:steel_ingot",
	groups = {hoe = 1}
})

-- The following are deprecated by removing the 'material' field to prevent
-- crafting and removing from creative inventory, to cause them to eventually
-- disappear from worlds. The registrations should be removed in a future
-- release.

farming.register_hoe(":blocklife:hoe_bronze", {
	description = S("Bronze Hoe"),
	inventory_image = "blocklife_farming_tool_bronzehoe.png",
	max_uses = 220,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})

farming.register_hoe(":blocklife:hoe_mese", {
	description = S("Mese Hoe"),
	inventory_image = "blocklife_farming_tool_mesehoe.png",
	max_uses = 350,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})

farming.register_hoe(":blocklife:hoe_diamond", {
	description = S("Diamond Hoe"),
	inventory_image = "blocklife_farming_tool_diamondhoe.png",
	max_uses = 500,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})

minetest.register_alias("farming:hoe_wood", "blocklife:hoe_wood")
minetest.register_alias("farming:hoe_stone", "blocklife:hoe_stone")
minetest.register_alias("farming:hoe_steel", "blocklife:hoe_steel")
minetest.register_alias("farming:hoe_bronze", "blocklife:hoe_bronze")
minetest.register_alias("farming:hoe_mese", "blocklife:hoe_mese")
minetest.register_alias("farming:hoe_diamond", "blocklife:hoe_diamond")
