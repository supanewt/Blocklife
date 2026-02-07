-- farming/nodes.lua

-- support for MT game translation.
local S = farming.get_translator

minetest.override_item("blocklife:dirt", {
	soil = {
		base = "blocklife:dirt",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.override_item("blocklife:dirt_with_grass", {
	soil = {
		base = "blocklife:dirt_with_grass",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.override_item("blocklife:dirt_with_dry_grass", {
	soil = {
		base = "blocklife:dirt_with_dry_grass",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.override_item("blocklife:dirt_with_rainforest_litter", {
	soil = {
		base = "blocklife:dirt_with_rainforest_litter",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.override_item("blocklife:dirt_with_coniferous_litter", {
	soil = {
		base = "blocklife:dirt_with_coniferous_litter",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.override_item("blocklife:dry_dirt", {
	soil = {
		base = "blocklife:dry_dirt",
		dry = "blocklife:dry_soil",
		wet = "blocklife:dry_soil_wet"
	}
})

minetest.override_item("blocklife:dry_dirt_with_dry_grass", {
	soil = {
		base = "blocklife:dry_dirt_with_dry_grass",
		dry = "blocklife:dry_soil",
		wet = "blocklife:dry_soil_wet"
	}
})

minetest.register_node("blocklife:soil", {
	description = S("Soil"),
	tiles = {"blocklife_dirt.png^blocklife_farming_soil.png", "blocklife_dirt.png"},
	drop = "blocklife:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	soil = {
		base = "blocklife:dirt",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.register_node("blocklife:soil_wet", {
	description = S("Wet Soil"),
	tiles = {"blocklife_dirt.png^blocklife_farming_soil_wet.png", "blocklife_dirt.png^blocklife_farming_soil_wet_side.png"},
	drop = "blocklife:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	soil = {
		base = "blocklife:dirt",
		dry = "blocklife:soil",
		wet = "blocklife:soil_wet"
	}
})

minetest.register_node("blocklife:dry_soil", {
	description = S("Savanna Soil"),
	tiles = {"blocklife_dry_dirt.png^blocklife_farming_soil.png", "blocklife_dry_dirt.png"},
	drop = "blocklife:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	soil = {
		base = "blocklife:dry_dirt",
		dry = "blocklife:dry_soil",
		wet = "blocklife:dry_soil_wet"
	}
})

minetest.register_node("blocklife:dry_soil_wet", {
	description = S("Wet Savanna Soil"),
	tiles = {"blocklife_dry_dirt.png^blocklife_farming_soil_wet.png", "blocklife_dry_dirt.png^blocklife_farming_soil_wet_side.png"},
	drop = "blocklife:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = blockman.node_sound_dirt_defaults(),
	soil = {
		base = "blocklife:dry_dirt",
		dry = "blocklife:dry_soil",
		wet = "blocklife:dry_soil_wet"
	}
})

minetest.override_item("blocklife:desert_sand", {
	groups = {crumbly=3, falling_node=1, sand=1, soil = 1},
	soil = {
		base = "blocklife:desert_sand",
		dry = "blocklife:desert_sand_soil",
		wet = "blocklife:desert_sand_soil_wet"
	}
})
minetest.register_node("blocklife:desert_sand_soil", {
	description = S("Desert Sand Soil"),
	drop = "blocklife:desert_sand",
	tiles = {"blocklife_farming_desert_sand_soil.png", "blocklife_desert_sand.png"},
	groups = {crumbly=3, not_in_creative_inventory = 1, falling_node=1, sand=1, soil = 2, desert = 1, field = 1},
	sounds = blockman.node_sound_sand_defaults(),
	soil = {
		base = "blocklife:desert_sand",
		dry = "blocklife:desert_sand_soil",
		wet = "blocklife:desert_sand_soil_wet"
	}
})

minetest.register_node("blocklife:desert_sand_soil_wet", {
	description = S("Wet Desert Sand Soil"),
	drop = "blocklife:desert_sand",
	tiles = {"blocklife_farming_desert_sand_soil_wet.png", "blocklife_farming_desert_sand_soil_wet_side.png"},
	groups = {crumbly=3, falling_node=1, sand=1, not_in_creative_inventory=1, soil=3, wet = 1, desert = 1, field = 1},
	sounds = blockman.node_sound_sand_defaults(),
	soil = {
		base = "blocklife:desert_sand",
		dry = "blocklife:desert_sand_soil",
		wet = "blocklife:desert_sand_soil_wet"
	}
})

minetest.register_node("blocklife:straw", {
	description = S("Straw"),
	tiles = {"blocklife_farming_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = blockman.node_sound_leaves_defaults(),
})

-- Registered before the stairs so the stairs get fuel recipes.
minetest.register_craft({
	type = "fuel",
	recipe = "blocklife:straw",
	burntime = 3,
})

do
	local recipe = "blocklife:straw"
	local groups = {snappy = 3, flammable = 4}
	local images = {"blocklife_farming_straw.png"}
	local sounds = blockman.node_sound_leaves_defaults()

	if minetest.global_exists("stairs") then
		stairs.register_stair("straw", recipe, groups, images, S("Straw Stair"),
			sounds, true)
		stairs.register_stair_inner("straw", recipe, groups, images, "",
			sounds, true, S("Inner Straw Stair"))
		stairs.register_stair_outer("straw", recipe, groups, images, "",
			sounds, true, S("Outer Straw Stair"))
		stairs.register_slab("straw", recipe, groups, images, S("Straw Slab"),
			sounds, true)
	end
end

minetest.register_abm({
	label = "Farming soil",
	nodenames = {"group:field"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		local n_def = minetest.registered_nodes[node.name] or nil
		local wet = n_def.soil.wet or nil
		local base = n_def.soil.base or nil
		local dry = n_def.soil.dry or nil
		if not n_def or not n_def.soil or not wet or not base or not dry then
			return
		end

		pos.y = pos.y + 1
		local nn = minetest.get_node_or_nil(pos)
		if not nn or not nn.name then
			return
		end
		local nn_def = minetest.registered_nodes[nn.name] or nil
		pos.y = pos.y - 1

		if nn_def and nn_def.walkable and minetest.get_item_group(nn.name, "plant") == 0 then
			minetest.set_node(pos, {name = base})
			return
		end
		-- check if there is water nearby
		local wet_lvl = minetest.get_item_group(node.name, "wet")
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil and not base node, turn it into wet soil
			if wet_lvl == 0 then
				minetest.set_node(pos, {name = wet})
			end
		else
			-- only turn back if there are no unloaded blocks (and therefore
			-- possible water sources) nearby
			if not minetest.find_node_near(pos, 3, {"ignore"}) then
				-- turn it back into base if it is already dry
				if wet_lvl == 0 then
					-- only turn it back if there is no plant/seed on top of it
					if minetest.get_item_group(nn.name, "plant") == 0 and minetest.get_item_group(nn.name, "seed") == 0 then
						minetest.set_node(pos, {name = base})
					end

				-- if its wet turn it back into dry soil
				elseif wet_lvl == 1 then
					minetest.set_node(pos, {name = dry})
				end
			end
		end
	end,
})


-- Make blocklife:grass_* occasionally drop wheat seed

for i = 1, 5 do
	minetest.override_item("blocklife:grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {"blocklife:seed_wheat"}, rarity = 5},
			{items = {"blocklife:grass_1"}},
		}
	}})
end


-- Wild cotton as a source of cotton seed

minetest.register_node("blocklife:cotton_wild", {
	description = S("Wild Cotton"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"blocklife_farming_cotton_wild.png"},
	inventory_image = "blocklife_farming_cotton_wild.png",
	wield_image = "blocklife_farming_cotton_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1, flammable = 4},
	drop = "blocklife:seed_cotton",
	sounds = blockman.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})

minetest.register_alias("farming:soil", "blocklife:soil")
minetest.register_alias("farming:soil_wet", "blocklife:soil_wet")
minetest.register_alias("farming:dry_soil", "blocklife:dry_soil")
minetest.register_alias("farming:dry_soil_wet", "blocklife:dry_soil_wet")
minetest.register_alias("farming:cotton_wild", "blocklife:cotton_wild")
