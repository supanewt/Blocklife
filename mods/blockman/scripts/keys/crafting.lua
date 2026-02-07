--
-- Crafting recipes
--

minetest.register_craft({
	output = "blocklife:skeleton_key",
	recipe = {
		{"blocklife:gold_ingot"},
	}
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "blocklife:gold_ingot",
	recipe = "blocklife:key",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "blocklife:gold_ingot",
	recipe = "blocklife:skeleton_key",
	cooktime = 5,
})
