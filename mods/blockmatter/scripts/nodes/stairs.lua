-- stairs/init.lua

-- Minetest Game mod: stairs
-- See README.txt for licensing and other information.


-- Global namespace for functions

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.stairs = blockman.stairs or {}
local stairs = blockman.stairs
blockman.expose_global("stairs", stairs)

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")
-- Same as S, but will be ignored by translation file update scripts
local T = S


-- Get setting for replace ABM

local replace = minetest.settings:get_bool("enable_stairs_replace_abm")

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			local diff = vector.subtract(p1, placer_pos)
			param2 = minetest.dir_to_facedir(diff)
			-- The player places a node on the side face of the node he is standing on
			if p0.y == p1.y and math.abs(diff.x) <= 0.5 and math.abs(diff.z) <= 0.5 and diff.y < 0 then
				-- reverse node direction
				param2 = (param2 + 2) % 4
			end
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

local function warn_if_exists(nodename)
	if minetest.registered_nodes[nodename] then
		minetest.log("warning", "Overwriting stairs node: " .. nodename)
	end
end

-- Set backface culling and world-aligned textures
local function set_textures(images, worldaligntex)
	local stair_images = {}
	for i, image in ipairs(images) do
		stair_images[i] = type(image) == "string" and {name = image} or table.copy(image)
		if stair_images[i].backface_culling == nil then
			stair_images[i].backface_culling = true
		end
		if worldaligntex and stair_images[i].align_style == nil then
			stair_images[i].align_style = "world"
		end
	end
	return stair_images
end

-- Register stair
-- Node will be called blocklife:stair_<subname>

function stairs.register_stair(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local def = minetest.registered_nodes[recipeitem] or {}
	local stair_images = set_textures(images, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	warn_if_exists("blocklife:stair_" .. subname)
	minetest.register_node(":blocklife:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha,
		sunlight_propagates = def.sunlight_propagates,
		light_source = def.light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds or def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":blocklife:stair_" .. subname .. "upside_down", {
			replace_name = "blocklife:stair_" .. subname,
			groups = {slabs_replace = 1},
		})
	end

	if recipeitem then
		-- Recipe matches appearence in inventory
		minetest.register_craft({
			output = "blocklife:stair_" .. subname .. " 8",
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use stairs to craft full blocks again (1:1)
		minetest.register_craft({
			output = recipeitem .. " 3",
			recipe = {
				{"blocklife:stair_" .. subname, "blocklife:stair_" .. subname},
				{"blocklife:stair_" .. subname, "blocklife:stair_" .. subname},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "blocklife:stair_" .. subname,
				burntime = math.floor(baseburntime * 0.75),
			})
		end
	end
end


-- Register slab
-- Node will be called blocklife:slab_<subname>

function stairs.register_slab(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local def = minetest.registered_nodes[recipeitem] or {}
	local slab_images = set_textures(images, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.slab = 1
	warn_if_exists("blocklife:slab_" .. subname)
	minetest.register_node(":blocklife:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = def.use_texture_alpha,
		sunlight_propagates = def.sunlight_propagates,
		light_source = def.light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds or def.sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			local under = minetest.get_node(pointed_thing.under)
			local wield_item = itemstack:get_name()
			local player_name = placer and placer:get_player_name() or ""

			if under and under.name:find("^blocklife:slab_") then
				-- place slab using under node orientation
				local dir = minetest.dir_to_facedir(vector.subtract(
					pointed_thing.above, pointed_thing.under), true)

				local p2 = under.param2

				-- Placing a slab on an upside down slab should make it right-side up.
				if p2 >= 20 and dir == 8 then
					p2 = p2 - 20
				-- same for the opposite case: slab below normal slab
				elseif p2 <= 3 and dir == 4 then
					p2 = p2 + 20
				end

				-- else attempt to place node with proper param2
				minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
				return itemstack
			else
				return rotate_and_place(itemstack, placer, pointed_thing)
			end
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":blocklife:slab_" .. subname .. "upside_down", {
			replace_name = "blocklife:slab_".. subname,
			groups = {slabs_replace = 1},
		})
	end

	if recipeitem then
		minetest.register_craft({
			output = "blocklife:slab_" .. subname .. " 6",
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use 2 slabs to craft a full block again (1:1)
		minetest.register_craft({
			output = recipeitem,
			recipe = {
				{"blocklife:slab_" .. subname},
				{"blocklife:slab_" .. subname},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "blocklife:slab_" .. subname,
				burntime = math.floor(baseburntime * 0.5),
			})
		end
	end
end


-- Optionally replace old "upside_down" nodes with new param2 versions.
-- Disabled by blockman.

if replace then
	minetest.register_abm({
		label = "Slab replace",
		nodenames = {"group:slabs_replace"},
		interval = 16,
		chance = 1,
		action = function(pos, node)
			node.name = minetest.registered_nodes[node.name].replace_name
			node.param2 = node.param2 + 20
			if node.param2 == 21 then
				node.param2 = 23
			elseif node.param2 == 23 then
				node.param2 = 21
			end
			minetest.set_node(pos, node)
		end,
	})
end


-- Register inner stair
-- Node will be called blocklife:stair_inner_<subname>

function stairs.register_stair_inner(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local def = minetest.registered_nodes[recipeitem] or {}
	local stair_images = set_textures(images, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Inner " .. description
	end
	warn_if_exists("blocklife:stair_inner_" .. subname)
	minetest.register_node(":blocklife:stair_inner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha,
		sunlight_propagates = def.sunlight_propagates,
		light_source = def.light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds or def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = "blocklife:stair_inner_" .. subname .. " 7",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, "", recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "blocklife:stair_inner_" .. subname,
				burntime = math.floor(baseburntime * 0.875),
			})
		end
	end
end


-- Register outer stair
-- Node will be called blocklife:stair_outer_<subname>

function stairs.register_stair_outer(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local def = minetest.registered_nodes[recipeitem] or {}
	local stair_images = set_textures(images, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Outer " .. description
	end
	warn_if_exists("blocklife:stair_outer_" .. subname)
	minetest.register_node(":blocklife:stair_outer_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha,
		sunlight_propagates = def.sunlight_propagates,
		light_source = def.light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds or def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = "blocklife:stair_outer_" .. subname .. " 6",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "blocklife:stair_outer_" .. subname,
				burntime = math.floor(baseburntime * 0.625),
			})
		end
	end
end


-- Stair/slab registration function.
-- Nodes will be called blocklife:{stair,slab}_<subname>

function stairs.register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex,
		desc_stair_inner, desc_stair_outer)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair,
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_inner)
	stairs.register_stair_outer(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_outer)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab,
		sounds, worldaligntex)
end

-- Local function so we can apply translations
local function my_register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex)
	stairs.register_stair(subname, recipeitem, groups, images, S(desc_stair),
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Inner " .. desc_stair))
	stairs.register_stair_outer(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Outer " .. desc_stair))
	stairs.register_slab(subname, recipeitem, groups, images, S(desc_slab),
		sounds, worldaligntex)
end


-- Register default stairs and slabs

my_register_stair_and_slab(
	"wood",
	"blocklife:wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"blocklife_wood.png"},
	"Wooden Stair",
	"Wooden Slab",
	blockman.node_sound_wood_defaults(),
	false
)





my_register_stair_and_slab(
	"stone",
	"blocklife:stone",
	{cracky = 3},
	{"blocklife_stone.png"},
	"Stone Stair",
	"Stone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"cobble",
	"blocklife:cobble",
	{cracky = 3},
	{"blocklife_cobble.png"},
	"Cobblestone Stair",
	"Cobblestone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"mossycobble",
	"blocklife:mossycobble",
	{cracky = 3},
	{"blocklife_mossycobble.png"},
	"Mossy Cobblestone Stair",
	"Mossy Cobblestone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"stonebrick",
	"blocklife:stonebrick",
	{cracky = 2},
	{"blocklife_stone_brick.png"},
	"Stone Brick Stair",
	"Stone Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"stone_block",
	"blocklife:stone_block",
	{cracky = 2},
	{"blocklife_stone_block.png"},
	"Stone Block Stair",
	"Stone Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_stone",
	"blocklife:desert_stone",
	{cracky = 3},
	{"blocklife_desert_stone.png"},
	"Desert Stone Stair",
	"Desert Stone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_cobble",
	"blocklife:desert_cobble",
	{cracky = 3},
	{"blocklife_desert_cobble.png"},
	"Desert Cobblestone Stair",
	"Desert Cobblestone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_stonebrick",
	"blocklife:desert_stonebrick",
	{cracky = 2},
	{"blocklife_desert_stone_brick.png"},
	"Desert Stone Brick Stair",
	"Desert Stone Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"desert_stone_block",
	"blocklife:desert_stone_block",
	{cracky = 2},
	{"blocklife_desert_stone_block.png"},
	"Desert Stone Block Stair",
	"Desert Stone Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"sandstone",
	"blocklife:sandstone",
	{crumbly = 1, cracky = 3},
	{"blocklife_sandstone.png"},
	"Sandstone Stair",
	"Sandstone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"sandstonebrick",
	"blocklife:sandstonebrick",
	{cracky = 2},
	{"blocklife_sandstone_brick.png"},
	"Sandstone Brick Stair",
	"Sandstone Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"sandstone_block",
	"blocklife:sandstone_block",
	{cracky = 2},
	{"blocklife_sandstone_block.png"},
	"Sandstone Block Stair",
	"Sandstone Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_sandstone",
	"blocklife:desert_sandstone",
	{crumbly = 1, cracky = 3},
	{"blocklife_desert_sandstone.png"},
	"Desert Sandstone Stair",
	"Desert Sandstone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_sandstone_brick",
	"blocklife:desert_sandstone_brick",
	{cracky = 2},
	{"blocklife_desert_sandstone_brick.png"},
	"Desert Sandstone Brick Stair",
	"Desert Sandstone Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"desert_sandstone_block",
	"blocklife:desert_sandstone_block",
	{cracky = 2},
	{"blocklife_desert_sandstone_block.png"},
	"Desert Sandstone Block Stair",
	"Desert Sandstone Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"silver_sandstone",
	"blocklife:silver_sandstone",
	{crumbly = 1, cracky = 3},
	{"blocklife_silver_sandstone.png"},
	"Silver Sandstone Stair",
	"Silver Sandstone Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"silver_sandstone_brick",
	"blocklife:silver_sandstone_brick",
	{cracky = 2},
	{"blocklife_silver_sandstone_brick.png"},
	"Silver Sandstone Brick Stair",
	"Silver Sandstone Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"silver_sandstone_block",
	"blocklife:silver_sandstone_block",
	{cracky = 2},
	{"blocklife_silver_sandstone_block.png"},
	"Silver Sandstone Block Stair",
	"Silver Sandstone Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"obsidian",
	"blocklife:obsidian",
	{cracky = 1, level = 2},
	{"blocklife_obsidian.png"},
	"Obsidian Stair",
	"Obsidian Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"obsidianbrick",
	"blocklife:obsidianbrick",
	{cracky = 1, level = 2},
	{"blocklife_obsidian_brick.png"},
	"Obsidian Brick Stair",
	"Obsidian Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"obsidian_block",
	"blocklife:obsidian_block",
	{cracky = 1, level = 2},
	{"blocklife_obsidian_block.png"},
	"Obsidian Block Stair",
	"Obsidian Block Slab",
	blockman.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"brick",
	"blocklife:brick",
	{cracky = 3},
	{"blocklife_brick.png"},
	"Brick Stair",
	"Brick Slab",
	blockman.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"steelblock",
	"blocklife:steelblock",
	{cracky = 1, level = 2},
	{"blocklife_steel_block.png"},
	"Steel Block Stair",
	"Steel Block Slab",
	blockman.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"tinblock",
	"blocklife:tinblock",
	{cracky = 1, level = 2},
	{"blocklife_tin_block.png"},
	"Tin Block Stair",
	"Tin Block Slab",
	blockman.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"copperblock",
	"blocklife:copperblock",
	{cracky = 1, level = 2},
	{"blocklife_copper_block.png"},
	"Copper Block Stair",
	"Copper Block Slab",
	blockman.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"bronzeblock",
	"blocklife:bronzeblock",
	{cracky = 1, level = 2},
	{"blocklife_bronze_block.png"},
	"Bronze Block Stair",
	"Bronze Block Slab",
	blockman.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"goldblock",
	"blocklife:goldblock",
	{cracky = 1},
	{"blocklife_gold_block.png"},
	"Gold Block Stair",
	"Gold Block Slab",
	blockman.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"ice",
	"blocklife:ice",
	{cracky = 3, cools_lava = 1, slippery = 3},
	{"blocklife_ice.png"},
	"Ice Stair",
	"Ice Slab",
	blockman.node_sound_ice_defaults(),
	true
)

my_register_stair_and_slab(
	"snowblock",
	"blocklife:snowblock",
	{crumbly = 3, cools_lava = 1, snowy = 1},
	{"blocklife_snow.png"},
	"Snow Block Stair",
	"Snow Block Slab",
	blockman.node_sound_snow_defaults(),
	true
)

-- Glass stair nodes need to be registered individually to utilize specialized textures.

stairs.register_stair(
	"glass",
	"blocklife:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"blocklife_stairs_glass_split.png", "blocklife_glass.png",
	"blocklife_stairs_glass_stairside.png^[transformFX", "blocklife_stairs_glass_stairside.png",
	"blocklife_glass.png", "blocklife_stairs_glass_split.png"},
	S("Glass Stair"),
	blockman.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"glass",
	"blocklife:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"blocklife_glass.png", "blocklife_glass.png", "blocklife_stairs_glass_split.png"},
	S("Glass Slab"),
	blockman.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"glass",
	"blocklife:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"blocklife_stairs_glass_stairside.png^[transformR270", "blocklife_glass.png",
	"blocklife_stairs_glass_stairside.png^[transformFX", "blocklife_glass.png",
	"blocklife_glass.png", "blocklife_stairs_glass_stairside.png"},
	"",
	blockman.node_sound_glass_defaults(),
	false,
	S("Inner Glass Stair")
)

stairs.register_stair_outer(
	"glass",
	"blocklife:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"blocklife_stairs_glass_stairside.png^[transformR90", "blocklife_glass.png",
	"blocklife_stairs_glass_outer_stairside.png", "blocklife_stairs_glass_stairside.png",
	"blocklife_stairs_glass_stairside.png^[transformR90","blocklife_stairs_glass_outer_stairside.png"},
	"",
	blockman.node_sound_glass_defaults(),
	false,
	S("Outer Glass Stair")
)

stairs.register_stair(
	"obsidian_glass",
	"blocklife:obsidian_glass",
	{cracky = 3},
	{"blocklife_stairs_obsidian_glass_split.png", "blocklife_obsidian_glass.png",
	"blocklife_stairs_obsidian_glass_stairside.png^[transformFX", "blocklife_stairs_obsidian_glass_stairside.png",
	"blocklife_obsidian_glass.png", "blocklife_stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Stair"),
	blockman.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"obsidian_glass",
	"blocklife:obsidian_glass",
	{cracky = 3},
	{"blocklife_obsidian_glass.png", "blocklife_obsidian_glass.png", "blocklife_stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Slab"),
	blockman.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"obsidian_glass",
	"blocklife:obsidian_glass",
	{cracky = 3},
	{"blocklife_stairs_obsidian_glass_stairside.png^[transformR270", "blocklife_obsidian_glass.png",
	"blocklife_stairs_obsidian_glass_stairside.png^[transformFX", "blocklife_obsidian_glass.png",
	"blocklife_obsidian_glass.png", "blocklife_stairs_obsidian_glass_stairside.png"},
	"",
	blockman.node_sound_glass_defaults(),
	false,
	S("Inner Obsidian Glass Stair")
)

stairs.register_stair_outer(
	"obsidian_glass",
	"blocklife:obsidian_glass",
	{cracky = 3},
	{"blocklife_stairs_obsidian_glass_stairside.png^[transformR90", "blocklife_obsidian_glass.png",
	"blocklife_stairs_obsidian_glass_outer_stairside.png", "blocklife_stairs_obsidian_glass_stairside.png",
	"blocklife_stairs_obsidian_glass_stairside.png^[transformR90","blocklife_stairs_obsidian_glass_outer_stairside.png"},
	"",
	blockman.node_sound_glass_defaults(),
	false,
	S("Outer Obsidian Glass Stair")
)

-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this add this code to my_register_stair_and_slab:
-- for _,x in ipairs({"","Inner ","Outer "}) do print(("S(%q)"):format(x..desc_stair)) end
-- print(("S(%q)"):format(desc_slab))

--[[
S("Wooden Stair")
S("Inner Wooden Stair")
S("Outer Wooden Stair")
S("Wooden Slab")
S("Jungle Wood Stair")
S("Inner Jungle Wood Stair")
S("Outer Jungle Wood Stair")
S("Jungle Wood Slab")
S("Pine Wood Stair")
S("Inner Pine Wood Stair")
S("Outer Pine Wood Stair")
S("Pine Wood Slab")
S("Acacia Wood Stair")
S("Inner Acacia Wood Stair")
S("Outer Acacia Wood Stair")
S("Acacia Wood Slab")
S("Aspen Wood Stair")
S("Inner Aspen Wood Stair")
S("Outer Aspen Wood Stair")
S("Aspen Wood Slab")
S("Stone Stair")
S("Inner Stone Stair")
S("Outer Stone Stair")
S("Stone Slab")
S("Cobblestone Stair")
S("Inner Cobblestone Stair")
S("Outer Cobblestone Stair")
S("Cobblestone Slab")
S("Mossy Cobblestone Stair")
S("Inner Mossy Cobblestone Stair")
S("Outer Mossy Cobblestone Stair")
S("Mossy Cobblestone Slab")
S("Stone Brick Stair")
S("Inner Stone Brick Stair")
S("Outer Stone Brick Stair")
S("Stone Brick Slab")
S("Stone Block Stair")
S("Inner Stone Block Stair")
S("Outer Stone Block Stair")
S("Stone Block Slab")
S("Desert Stone Stair")
S("Inner Desert Stone Stair")
S("Outer Desert Stone Stair")
S("Desert Stone Slab")
S("Desert Cobblestone Stair")
S("Inner Desert Cobblestone Stair")
S("Outer Desert Cobblestone Stair")
S("Desert Cobblestone Slab")
S("Desert Stone Brick Stair")
S("Inner Desert Stone Brick Stair")
S("Outer Desert Stone Brick Stair")
S("Desert Stone Brick Slab")
S("Desert Stone Block Stair")
S("Inner Desert Stone Block Stair")
S("Outer Desert Stone Block Stair")
S("Desert Stone Block Slab")
S("Sandstone Stair")
S("Inner Sandstone Stair")
S("Outer Sandstone Stair")
S("Sandstone Slab")
S("Sandstone Brick Stair")
S("Inner Sandstone Brick Stair")
S("Outer Sandstone Brick Stair")
S("Sandstone Brick Slab")
S("Sandstone Block Stair")
S("Inner Sandstone Block Stair")
S("Outer Sandstone Block Stair")
S("Sandstone Block Slab")
S("Desert Sandstone Stair")
S("Inner Desert Sandstone Stair")
S("Outer Desert Sandstone Stair")
S("Desert Sandstone Slab")
S("Desert Sandstone Brick Stair")
S("Inner Desert Sandstone Brick Stair")
S("Outer Desert Sandstone Brick Stair")
S("Desert Sandstone Brick Slab")
S("Desert Sandstone Block Stair")
S("Inner Desert Sandstone Block Stair")
S("Outer Desert Sandstone Block Stair")
S("Desert Sandstone Block Slab")
S("Silver Sandstone Stair")
S("Inner Silver Sandstone Stair")
S("Outer Silver Sandstone Stair")
S("Silver Sandstone Slab")
S("Silver Sandstone Brick Stair")
S("Inner Silver Sandstone Brick Stair")
S("Outer Silver Sandstone Brick Stair")
S("Silver Sandstone Brick Slab")
S("Silver Sandstone Block Stair")
S("Inner Silver Sandstone Block Stair")
S("Outer Silver Sandstone Block Stair")
S("Silver Sandstone Block Slab")
S("Obsidian Stair")
S("Inner Obsidian Stair")
S("Outer Obsidian Stair")
S("Obsidian Slab")
S("Obsidian Brick Stair")
S("Inner Obsidian Brick Stair")
S("Outer Obsidian Brick Stair")
S("Obsidian Brick Slab")
S("Obsidian Block Stair")
S("Inner Obsidian Block Stair")
S("Outer Obsidian Block Stair")
S("Obsidian Block Slab")
S("Brick Stair")
S("Inner Brick Stair")
S("Outer Brick Stair")
S("Brick Slab")
S("Steel Block Stair")
S("Inner Steel Block Stair")
S("Outer Steel Block Stair")
S("Steel Block Slab")
S("Tin Block Stair")
S("Inner Tin Block Stair")
S("Outer Tin Block Stair")
S("Tin Block Slab")
S("Copper Block Stair")
S("Inner Copper Block Stair")
S("Outer Copper Block Stair")
S("Copper Block Slab")
S("Bronze Block Stair")
S("Inner Bronze Block Stair")
S("Outer Bronze Block Stair")
S("Bronze Block Slab")
S("Gold Block Stair")
S("Inner Gold Block Stair")
S("Outer Gold Block Stair")
S("Gold Block Slab")
S("Ice Stair")
S("Inner Ice Stair")
S("Outer Ice Stair")
S("Ice Slab")
S("Snow Block Stair")
S("Inner Snow Block Stair")
S("Outer Snow Block Stair")
S("Snow Block Slab")
--]]



minetest.register_alias("stairs:stair_wood", "blocklife:stair_wood")
minetest.register_alias("stairs:slab_wood", "blocklife:slab_wood")
minetest.register_alias("stairs:stair_stone", "blocklife:stair_stone")
minetest.register_alias("stairs:slab_stone", "blocklife:slab_stone")
minetest.register_alias("stairs:stair_cobble", "blocklife:stair_cobble")
minetest.register_alias("stairs:slab_cobble", "blocklife:slab_cobble")
minetest.register_alias("stairs:stair_mossycobble", "blocklife:stair_mossycobble")
minetest.register_alias("stairs:slab_mossycobble", "blocklife:slab_mossycobble")
minetest.register_alias("stairs:stair_stonebrick", "blocklife:stair_stonebrick")
minetest.register_alias("stairs:slab_stonebrick", "blocklife:slab_stonebrick")
minetest.register_alias("stairs:stair_stone_block", "blocklife:stair_stone_block")
minetest.register_alias("stairs:slab_stone_block", "blocklife:slab_stone_block")
minetest.register_alias("stairs:stair_desert_stone", "blocklife:stair_desert_stone")
minetest.register_alias("stairs:slab_desert_stone", "blocklife:slab_desert_stone")
minetest.register_alias("stairs:stair_desert_cobble", "blocklife:stair_desert_cobble")
minetest.register_alias("stairs:slab_desert_cobble", "blocklife:slab_desert_cobble")
minetest.register_alias("stairs:stair_desert_stonebrick", "blocklife:stair_desert_stonebrick")
minetest.register_alias("stairs:slab_desert_stonebrick", "blocklife:slab_desert_stonebrick")
minetest.register_alias("stairs:stair_desert_stone_block", "blocklife:stair_desert_stone_block")
minetest.register_alias("stairs:slab_desert_stone_block", "blocklife:slab_desert_stone_block")
minetest.register_alias("stairs:stair_sandstone", "blocklife:stair_sandstone")
minetest.register_alias("stairs:slab_sandstone", "blocklife:slab_sandstone")
minetest.register_alias("stairs:stair_sandstonebrick", "blocklife:stair_sandstonebrick")
minetest.register_alias("stairs:slab_sandstonebrick", "blocklife:slab_sandstonebrick")
minetest.register_alias("stairs:stair_sandstone_block", "blocklife:stair_sandstone_block")
minetest.register_alias("stairs:slab_sandstone_block", "blocklife:slab_sandstone_block")
minetest.register_alias("stairs:stair_desert_sandstone", "blocklife:stair_desert_sandstone")
minetest.register_alias("stairs:slab_desert_sandstone", "blocklife:slab_desert_sandstone")
minetest.register_alias("stairs:stair_desert_sandstone_brick", "blocklife:stair_desert_sandstone_brick")
minetest.register_alias("stairs:slab_desert_sandstone_brick", "blocklife:slab_desert_sandstone_brick")
minetest.register_alias("stairs:stair_desert_sandstone_block", "blocklife:stair_desert_sandstone_block")
minetest.register_alias("stairs:slab_desert_sandstone_block", "blocklife:slab_desert_sandstone_block")
minetest.register_alias("stairs:stair_silver_sandstone", "blocklife:stair_silver_sandstone")
minetest.register_alias("stairs:slab_silver_sandstone", "blocklife:slab_silver_sandstone")
minetest.register_alias("stairs:stair_silver_sandstone_brick", "blocklife:stair_silver_sandstone_brick")
minetest.register_alias("stairs:slab_silver_sandstone_brick", "blocklife:slab_silver_sandstone_brick")
minetest.register_alias("stairs:stair_silver_sandstone_block", "blocklife:stair_silver_sandstone_block")
minetest.register_alias("stairs:slab_silver_sandstone_block", "blocklife:slab_silver_sandstone_block")
minetest.register_alias("stairs:stair_obsidian", "blocklife:stair_obsidian")
minetest.register_alias("stairs:slab_obsidian", "blocklife:slab_obsidian")
minetest.register_alias("stairs:stair_obsidianbrick", "blocklife:stair_obsidianbrick")
minetest.register_alias("stairs:slab_obsidianbrick", "blocklife:slab_obsidianbrick")
minetest.register_alias("stairs:stair_obsidian_block", "blocklife:stair_obsidian_block")
minetest.register_alias("stairs:slab_obsidian_block", "blocklife:slab_obsidian_block")
minetest.register_alias("stairs:stair_brick", "blocklife:stair_brick")
minetest.register_alias("stairs:slab_brick", "blocklife:slab_brick")
minetest.register_alias("stairs:stair_steelblock", "blocklife:stair_steelblock")
minetest.register_alias("stairs:slab_steelblock", "blocklife:slab_steelblock")
minetest.register_alias("stairs:stair_tinblock", "blocklife:stair_tinblock")
minetest.register_alias("stairs:slab_tinblock", "blocklife:slab_tinblock")
minetest.register_alias("stairs:stair_copperblock", "blocklife:stair_copperblock")
minetest.register_alias("stairs:slab_copperblock", "blocklife:slab_copperblock")
minetest.register_alias("stairs:stair_bronzeblock", "blocklife:stair_bronzeblock")
minetest.register_alias("stairs:slab_bronzeblock", "blocklife:slab_bronzeblock")
minetest.register_alias("stairs:stair_goldblock", "blocklife:stair_goldblock")
minetest.register_alias("stairs:slab_goldblock", "blocklife:slab_goldblock")
minetest.register_alias("stairs:stair_ice", "blocklife:stair_ice")
minetest.register_alias("stairs:slab_ice", "blocklife:slab_ice")
minetest.register_alias("stairs:stair_snowblock", "blocklife:stair_snowblock")
minetest.register_alias("stairs:slab_snowblock", "blocklife:slab_snowblock")
