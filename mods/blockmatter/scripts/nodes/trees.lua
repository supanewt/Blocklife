-- default/trees.lua

-- support for MT game translation.
local S = blockman.get_translator

local random = math.random

--
-- Grow trees from saplings
--

-- 'can grow' function

function blockman.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

function blockman.on_grow_failed(pos)
	minetest.get_node_timer(pos):start(300)
end


-- 'is snow nearby' function

local function is_snow_nearby(pos)
	return minetest.find_node_near(pos, 1, {"group:snowy"})
end



--
-- Tree generation
--

-- Apple tree trunk and leaves function

local function add_trunk_and_leaves(data, a, pos, tree_cid, leaves_cid,
		height, size, iters, is_apple_tree)
	local x, y, z = pos.x, pos.y, pos.z
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_apple = minetest.get_content_id("blocklife:apple")

	-- Trunk
	data[a:index(x, y, z)] = tree_cid -- Force-place lowest trunk node to replace sapling
	for yy = y + 1, y + height - 1 do
		local vi = a:index(x, yy, z)
		local node_id = data[vi]
		if node_id == c_air or node_id == c_ignore or node_id == leaves_cid then
			data[vi] = tree_cid
		end
	end

	-- Force leaves near the trunk
	for z_dist = -1, 1 do
	for y_dist = -size, 1 do
		local vi = a:index(x - 1, y + height + y_dist, z + z_dist)
		for x_dist = -1, 1 do
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
			vi = vi + 1
		end
	end
	end

	-- Randomly add leaves in 2x2x2 clusters.
	for i = 1, iters do
		local clust_x = x + random(-size, size - 1)
		local clust_y = y + height + random(-size, 0)
		local clust_z = z + random(-size, size - 1)

		for xi = 0, 1 do
		for yi = 0, 1 do
		for zi = 0, 1 do
			local vi = a:index(clust_x + xi, clust_y + yi, clust_z + zi)
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
		end
		end
		end
	end
end


-- Apple tree

function blockman.grow_tree(pos, is_apple_tree, bad)
	--[[
		NOTE: Tree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	if bad then
		error("Deprecated use of blockman.grow_tree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(4, 5)
	local c_tree = minetest.get_content_id("blocklife:tree")
	local c_leaves = minetest.get_content_id("blocklife:leaves")

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - 2, y = y, z = z - 2},
		{x = x + 2, y = y + height + 1, z = z + 2}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_tree, c_leaves, height, 2, 8, is_apple_tree)

	vm:set_data(data)
	vm:write_to_map()
	if vm.close ~= nil then
		vm:close()
	end
end

-- New apple tree

function blockman.grow_new_apple_tree(pos)
	local path = minetest.get_modpath("blockfx") ..
		"/schematics/blocklife_apple_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
end


-- Bushes do not need 'from sapling' schematic variants because
-- only the stem node is force-placed in the schematic.

-- Bush

function blockman.grow_bush(pos)
	local path = minetest.get_modpath("blockfx") ..
		"/schematics/blocklife_bush.mts"
	minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
		path, "0", nil, false)
end

-- Blueberry bush

function blockman.grow_blueberry_bush(pos)
	local path = minetest.get_modpath("blockfx") ..
		"/schematics/blocklife_blueberry_bush.mts"
	minetest.place_schematic({x = pos.x - 1, y = pos.y, z = pos.z - 1},
		path, "0", nil, false)
end


--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function blockman.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
		minetest.chat_send_player(player_name,
		    S("@1 will intersect protection on growth.",
			itemstack:get_definition().description))
		return itemstack
	end

	if placer then
		blockman.log_player_action(placer, "places node", sapling_name, "at", pos)
	end

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end

-- Grow sapling

blockman.sapling_growth_defs = {}

function blockman.register_sapling_growth(name, def)
	blockman.sapling_growth_defs[name] = {
		can_grow = def.can_grow or blockman.can_grow,
		on_grow_failed = def.on_grow_failed or blockman.on_grow_failed,
		grow = assert(def.grow)
	}
end

function blockman.grow_sapling(pos)
	local node = minetest.get_node(pos)
	local sapling_def = blockman.sapling_growth_defs[node.name]

	if not sapling_def then
		minetest.log("warning", "blockman.grow_sapling called on undefined sapling " .. node.name)
		return
	end

	if not sapling_def.can_grow(pos) then
		sapling_def.on_grow_failed(pos)
		return
	end

	minetest.log("action", "Growing sapling " .. node.name .. " at " .. minetest.pos_to_string(pos))
	sapling_def.grow(pos)
end

local function register_sapling_growth(nodename, grow)
	blockman.register_sapling_growth("blocklife:" .. nodename, {grow = grow})
end

if minetest.get_mapgen_setting("mg_name") == "v6" then
	register_sapling_growth("sapling", function(pos)
		blockman.grow_tree(pos, random(1, 4) == 1)
	end)
else
	register_sapling_growth("sapling", blockman.grow_new_apple_tree)
end

register_sapling_growth("bush_sapling", blockman.grow_bush)
register_sapling_growth("blueberry_bush_sapling", blockman.grow_blueberry_bush)

-- Backwards compatibility for saplings that used to use ABMs; does not need to include newer saplings.
	minetest.register_lbm({
		name = "blocklife:convert_saplings_to_node_timer",
	nodenames = {"blocklife:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end
})
