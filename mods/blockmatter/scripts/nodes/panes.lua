-- panes.lua

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")


local function is_pane(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
end

local function connects_dir(pos, name, dir)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside) then
		return true
	end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then
		return false
	end
	local list = minetest.find_nodes_in_area(aside, aside, connects_to)

	if #list > 0 then
		return true
	end

	return false
end

local function swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then
		return
	end

	minetest.swap_node(pos, {name = name, param2 = param2})
end

local function update_pane(pos)
	if not is_pane(pos) then
		return
	end
	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = connects_dir(pos, name, dir)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			swap(pos, node, name, 0)
		end
	else
		swap(pos, node, name, 0)
	end
end

minetest.register_on_placenode(function(pos, node)
	if minetest.get_item_group(node, "pane") then
		update_pane(pos)
	end
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

minetest.register_on_dignode(function(pos)
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.xpanes = blockman.xpanes or {}
local xpanes = blockman.xpanes
blockman.expose_global("xpanes", xpanes)
function xpanes.register_pane(name, def)
	for i = 1, 15 do
		minetest.register_alias("blocklife:" .. name .. "_" .. i, "blocklife:" .. name .. "_flat")
	end

	local flatgroups = table.copy(def.groups)
	flatgroups.pane = 1
	minetest.register_node(":blocklife:" .. name .. "_flat", {
		description = def.description,
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		paramtype2 = "facedir",
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[1],
			def.textures[1]
		},
		groups = flatgroups,
		drop = "blocklife:" .. name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connect_sides = { "left", "right" },
	})

	local groups = table.copy(def.groups)
	groups.pane = 1
	groups.not_in_creative_inventory = 1
	minetest.register_node(":blocklife:" .. name, {
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		description = def.description,
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[1]
		},
		groups = groups,
		drop = "blocklife:" .. name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "connected",
			fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
			connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
			connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
			connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
			connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree"},
	})

	minetest.register_craft({
		output = "blocklife:" .. name .. "_flat 16",
		recipe = def.recipe
	})
end

xpanes.register_pane("pane", {
	description = S("Glass Pane"),
	textures = {"blocklife_glass.png", "", "blocklife_xpanes_edge.png"},
	inventory_image = "blocklife_glass.png",
	wield_image = "blocklife_glass.png",
	sounds = blockman.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"blocklife:glass", "blocklife:glass", "blocklife:glass"},
		{"blocklife:glass", "blocklife:glass", "blocklife:glass"}
	}
})

xpanes.register_pane("obsidian_pane", {
	description = S("Obsidian Glass Pane"),
	textures = {"blocklife_obsidian_glass.png", "", "blocklife_xpanes_edge_obsidian.png"},
	inventory_image = "blocklife_obsidian_glass.png",
	wield_image = "blocklife_obsidian_glass.png",
	sounds = blockman.node_sound_glass_defaults(),
	groups = {snappy=2, cracky=3},
	recipe = {
		{"blocklife:obsidian_glass", "blocklife:obsidian_glass", "blocklife:obsidian_glass"},
		{"blocklife:obsidian_glass", "blocklife:obsidian_glass", "blocklife:obsidian_glass"}
	}
})

xpanes.register_pane("bar", {
	description = S("Steel Bars"),
	textures = {"blocklife_xpanes_bar.png", "", "blocklife_xpanes_bar_top.png"},
	inventory_image = "blocklife_xpanes_bar.png",
	wield_image = "blocklife_xpanes_bar.png",
	groups = {cracky=2},
	sounds = blockman.node_sound_metal_defaults(),
	recipe = {
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"},
		{"blocklife:steel_ingot", "blocklife:steel_ingot", "blocklife:steel_ingot"}
	}
})

minetest.register_lbm({
	name = "blocklife:gen2",
	nodenames = {"group:pane"},
	action = function(pos, node)
		update_pane(pos)
		for i = 0, 3 do
			local dir = minetest.facedir_to_dir(i)
			update_pane(vector.add(pos, dir))
		end
	end
})

-- Register steel bar doors and trapdoors

if doors then

	doors.register("blocklife:door_steel_bar", {
		tiles = {{name = "blocklife_xpanes_door_steel_bar.png", backface_culling = true}},
		description = S("Steel Bar Door"),
		inventory_image = "blocklife_xpanes_item_steel_bar.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = blockman.node_sound_metal_defaults(),
		sound_open = "blocklife_xpanes_steel_bar_door_open",
		sound_close = "blocklife_xpanes_steel_bar_door_close",
		gain_open = 0.15,
		gain_close = 0.13,
		recipe = {
			{"blocklife:bar_flat", "blocklife:bar_flat"},
			{"blocklife:bar_flat", "blocklife:bar_flat"},
			{"blocklife:bar_flat", "blocklife:bar_flat"},
		},
	})

	doors.register_trapdoor("blocklife:trapdoor_steel_bar", {
		description = S("Steel Bar Trapdoor"),
		inventory_image = "blocklife_xpanes_trapdoor_steel_bar.png",
		wield_image = "blocklife_xpanes_trapdoor_steel_bar.png",
		tile_front = "blocklife_xpanes_trapdoor_steel_bar.png",
		tile_side = "blocklife_xpanes_trapdoor_steel_bar_side.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2, door = 1},
		sounds = blockman.node_sound_metal_defaults(),
		sound_open = "blocklife_xpanes_steel_bar_door_open",
		sound_close = "blocklife_xpanes_steel_bar_door_close",
		gain_open = 0.15,
		gain_close = 0.13,
	})

	minetest.register_craft({
		output = "blocklife:trapdoor_steel_bar",
		recipe = {
			{"blocklife:bar_flat", "blocklife:bar_flat"},
			{"blocklife:bar_flat", "blocklife:bar_flat"},
		}
	})
end


minetest.register_alias("xpanes:pane_flat", "blocklife:pane_flat")
minetest.register_alias("xpanes:pane", "blocklife:pane")
minetest.register_alias("xpanes:obsidian_pane_flat", "blocklife:obsidian_pane_flat")
minetest.register_alias("xpanes:obsidian_pane", "blocklife:obsidian_pane")
minetest.register_alias("xpanes:bar_flat", "blocklife:bar_flat")
minetest.register_alias("xpanes:bar", "blocklife:bar")
minetest.register_alias("xpanes:door_steel_bar", "blocklife:door_steel_bar")
minetest.register_alias("xpanes:trapdoor_steel_bar", "blocklife:trapdoor_steel_bar")
