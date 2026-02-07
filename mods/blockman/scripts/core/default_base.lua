-- Blockman core helpers (replaces legacy default namespace)

local blockman = rawget(_G, "blockman") or {}
rawset(_G, "blockman", blockman)

-- Load support for MT game translation.
local S = minetest.get_translator("blockman")

blockman.LIGHT_MAX = 14
blockman.get_translator = S

-- Engine compatibility check
if ItemStack("").add_wear_by_uses == nil then
	error("\nThis version of Minetest Game is incompatible with your engine version "..
		"(which is too old). You should download a version of Minetest Game that "..
		"matches the installed engine version.\n")
end

-- UI setup (formspec + hotbar)
minetest.register_on_joinplayer(function(player)
	local formspec = [[
			bgcolor[#080808BB;true]
			listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]]
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;blocklife_gui_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;blocklife_gui_formbg.png;true]"
	end
	player:set_formspec_prepend(formspec)

	player:hud_set_hotbar_image("blocklife_gui_hotbar.png")
	player:hud_set_hotbar_selected_image("blocklife_gui_hotbar_selected.png")
end)

function blockman.get_hotbar_bg(x, y)
	local out = ""
	for i = 0, 7, 1 do
		out = out .. "image[" .. x + i .. "," .. y .. ";1,1;blocklife_gui_hb_bg.png]"
	end
	return out
end

function blockman.destroy_tree_cluster(origin, opts)
	opts = opts or {}
	local max_nodes = opts.max_nodes or 512
	local radius = opts.radius or 8
	local bounds_min = opts.bounds_min
	local bounds_max = opts.bounds_max
	local include_names = opts.include_names or {["blocklife:apple"] = true}
	local tool = opts.tool
	local mode = opts.mode or "connected"
	-- fall_nodes unused: leaves and trunks are removed and dropped

	local function is_tree_node(name)
		if include_names[name] then
			return true
		end
		return minetest.get_item_group(name, "tree") > 0
			or minetest.get_item_group(name, "leaves") > 0
	end

	local origin_pos = vector.new(origin)
	local queue = {}
	local head = 1
	local visited = {}
	local removed = 0

	local function enqueue(pos)
		queue[#queue + 1] = pos
	end

	local function spawn_drops(pos, drops)
		for _, item in ipairs(drops) do
			local obj = minetest.add_item(pos, item)
			if obj then
				local luaent = obj:get_luaentity()
				if luaent then
					luaent.collect = true
				end
			end
		end
	end

	if mode == "radius" then
		local minp = vector.subtract(origin_pos, radius)
		local maxp = vector.add(origin_pos, radius)
		local search = {"group:tree", "group:leaves"}
		for name, _ in pairs(include_names) do
			search[#search + 1] = name
		end
		local positions = minetest.find_nodes_in_area(minp, maxp, search)
		local removed_radius = 0
		for _, pos in ipairs(positions) do
			if removed_radius >= max_nodes then
				break
			end
			local node = minetest.get_node(pos)
			if is_tree_node(node.name) then
				local drops = minetest.get_node_drops(node.name, tool)
				minetest.remove_node(pos)
				spawn_drops(pos, drops)
				removed_radius = removed_radius + 1
			end
		end
		return
	end

	if mode == "schematic_fall" and bounds_min and bounds_max then
		local minp = vector.add(origin_pos, bounds_min)
		local maxp = vector.add(origin_pos, bounds_max)
		local search = {"group:tree", "group:leaves"}
		for name, _ in pairs(include_names) do
			search[#search + 1] = name
		end
		local positions = minetest.find_nodes_in_area(minp, maxp, search)
		local removed_schematic = 0
		for _, pos in ipairs(positions) do
			if removed_schematic >= max_nodes then
				break
			end
			local node = minetest.get_node(pos)
			if is_tree_node(node.name) then
				local drops = minetest.get_node_drops(node.name, tool)
				minetest.remove_node(pos)
				spawn_drops(pos, drops)
				removed_schematic = removed_schematic + 1
			end
		end
		return
	end

	-- Seed 26-neighborhood so diagonal leaf clusters are included.
	for dx = -1, 1 do
		for dy = -1, 1 do
			for dz = -1, 1 do
				if not (dx == 0 and dy == 0 and dz == 0) then
					enqueue({
						x = origin_pos.x + dx,
						y = origin_pos.y + dy,
						z = origin_pos.z + dz,
					})
				end
			end
		end
	end

	while head <= #queue and removed < max_nodes do
		local pos = queue[head]
		head = head + 1

		if math.abs(pos.x - origin_pos.x) > radius
				or math.abs(pos.y - origin_pos.y) > radius
				or math.abs(pos.z - origin_pos.z) > radius then
			goto continue
		end

		local hash = minetest.hash_node_position(pos)
		if visited[hash] then
			goto continue
		end
		visited[hash] = true

		local node = minetest.get_node(pos)
		if not is_tree_node(node.name) then
			goto continue
		end

		local drops = minetest.get_node_drops(node.name, tool)
		minetest.remove_node(pos)
		spawn_drops(pos, drops)
		removed = removed + 1

		for dx = -1, 1 do
			for dy = -1, 1 do
				for dz = -1, 1 do
					if not (dx == 0 and dy == 0 and dz == 0) then
						enqueue({
							x = pos.x + dx,
							y = pos.y + dy,
							z = pos.z + dz,
						})
					end
				end
			end
		end

		::continue::
	end
end

blockman.gui_survival_form = "size[8,8.5]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;blocklife_gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			blockman.get_hotbar_bg(0,4.25)

blockman.tree_schematic_defs = {
	["blocklife:tree"] = {
		bounds_min = {x = -3, y = -1, z = -3},
		bounds_max = {x = 3, y = 12, z = 3},
		include_names = {["blocklife:apple"] = true},
	},
	["blocklife:palm_tree"] = {
		bounds_min = {x = -4, y = -1, z = -4},
		bounds_max = {x = 4, y = 16, z = 4},
		include_names = {
			["blocklife:palm_leaves"] = true,
			["blocklife:palm_leaves2"] = true,
		},
	},
	["blocklife:islands_twigs"] = {
		bounds_min = {x = -4, y = -1, z = -4},
		bounds_max = {x = 4, y = 16, z = 4},
		include_names = {
			["blocklife:islands_leaves"] = true,
			["blocklife:islands_underbrush"] = true,
			["blocklife:islands_grass"] = true,
			["blocklife:islands_cotton_bush"] = true,
		},
	},
}

function blockman.fell_tree_from_trunk(pos, node_name, digger)
	local def = blockman.tree_schematic_defs[node_name]
	if not def then
		def = {
			bounds_min = {x = -4, y = -1, z = -4},
			bounds_max = {x = 4, y = 16, z = 4},
		}
	end
	if def then
		blockman.destroy_tree_cluster(pos, {
			mode = "schematic_fall",
			bounds_min = def.bounds_min,
			bounds_max = def.bounds_max,
			include_names = def.include_names,
			digger = digger,
			tool = digger and digger:get_wielded_item():get_name() or nil,
		})
	else
		blockman.destroy_tree_cluster(pos, {
			digger = digger,
			tool = digger and digger:get_wielded_item():get_name() or nil,
		})
	end
end

function blockman.register_tree_felling()
	for name, def in pairs(minetest.registered_nodes) do
		if def.groups and def.groups.tree then
			local old_after = def.after_dig_node
			minetest.override_item(name, {
				after_dig_node = function(pos, oldnode, oldmeta, digger)
					if old_after then
						old_after(pos, oldnode, oldmeta, digger)
					end
					blockman.fell_tree_from_trunk(pos, oldnode.name, digger)
				end
			})
		end
	end
end

minetest.register_on_mods_loaded(function()
	blockman.register_tree_felling()
end)

function blockman.register_leafdecay_all()
	if not blockman.register_leafdecay then
		return
	end
	local trunks = {}
	local leaves = {}
	for name, def in pairs(minetest.registered_nodes) do
		if def.groups then
			if def.groups.tree then
				trunks[#trunks + 1] = name
			end
			if def.groups.leaves then
				leaves[#leaves + 1] = name
			end
		end
	end
	if #trunks > 0 and #leaves > 0 then
		blockman.register_leafdecay({
			trunks = trunks,
			leaves = leaves,
			radius = 4,
		})
	end
end

minetest.register_on_mods_loaded(function()
	blockman.register_leafdecay_all()
end)

-- Sound helpers
function blockman.node_sound_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "", gain = 1.0}
	tbl.dug = tbl.dug or {name = "blocklife_default_dug_node", gain = 0.25}
	tbl.place = tbl.place or {name = "blocklife_default_place_node_hard", gain = 1.0}
	return tbl
end

function blockman.node_sound_stone_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_hard_footstep", gain = 0.2}
	tbl.dug = tbl.dug or {name = "blocklife_default_hard_footstep", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_dirt_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_dirt_footstep", gain = 0.25}
	tbl.dig = tbl.dig or {name = "blocklife_default_dig_crumbly", gain = 0.4}
	tbl.dug = tbl.dug or {name = "blocklife_default_dirt_footstep", gain = 1.0}
	tbl.place = tbl.place or {name = "blocklife_default_place_node", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_sand_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_sand_footstep", gain = 0.05}
	tbl.dug = tbl.dug or {name = "blocklife_default_sand_footstep", gain = 0.15}
	tbl.place = tbl.place or {name = "blocklife_default_place_node", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_gravel_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_gravel_footstep", gain = 0.25}
	tbl.dig = tbl.dig or {name = "blocklife_default_gravel_dig", gain = 0.35}
	tbl.dug = tbl.dug or {name = "blocklife_default_gravel_dug", gain = 1.0}
	tbl.place = tbl.place or {name = "blocklife_default_place_node", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_wood_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_wood_footstep", gain = 0.15}
	tbl.dig = tbl.dig or {name = "blocklife_default_dig_choppy", gain = 0.4}
	tbl.dug = tbl.dug or {name = "blocklife_default_wood_footstep", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_metal_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_metal_footstep", gain = 0.2}
	tbl.dig = tbl.dig or {name = "blocklife_default_dig_metal", gain = 0.5}
	tbl.dug = tbl.dug or {name = "blocklife_default_dug_metal", gain = 0.5}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_water_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_water_footstep", gain = 0.2}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_ice_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_ice_footstep", gain = 0.15}
	tbl.dig = tbl.dig or {name = "blocklife_default_ice_dig", gain = 0.5}
	tbl.dug = tbl.dug or {name = "blocklife_default_ice_dug", gain = 0.5}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_snow_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_snow_footstep", gain = 0.2}
	tbl.dig = tbl.dig or {name = "blocklife_default_snow_footstep", gain = 0.3}
	tbl.dug = tbl.dug or {name = "blocklife_default_snow_footstep", gain = 0.3}
	tbl.place = tbl.place or {name = "blocklife_default_place_node", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_glass_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_glass_footstep", gain = 0.3}
	tbl.dig = tbl.dig or {name = "blocklife_default_glass_footstep", gain = 0.5}
	tbl.dug = tbl.dug or {name = "blocklife_default_break_glass", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

function blockman.node_sound_leaves_defaults(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name = "blocklife_default_grass_footstep", gain = 0.45}
	tbl.dig = tbl.dig or {name = "blocklife_default_grass_footstep", gain = 0.7}
	tbl.place = tbl.place or {name = "blocklife_default_place_node", gain = 1.0}
	blockman.node_sound_defaults(tbl)
	return tbl
end

-- Log helpers
local log_non_player_actions = minetest.settings:get_bool("log_non_player_actions", false)

local function is_pos(v)
	return type(v) == "table" and type(v.x) == "number" and type(v.y) == "number" and type(v.z) == "number"
end

function blockman.log_player_action(player, ...)
	local msg = player:get_player_name()
	if player.is_fake_player or not player:is_player() then
		if not log_non_player_actions then
			return
		end
		msg = msg .. "(" .. (type(player.is_fake_player) == "string" and player.is_fake_player or "*") .. ")"
	end
	for _, v in ipairs({...}) do
		local part = is_pos(v) and minetest.pos_to_string(v) or v
		msg = msg .. (string.match(part, "^[;,.]") and "" or " ") .. part
	end
	minetest.log("action", msg)
end

local function nop()
end

function blockman.set_inventory_action_loggers(def, name)
	local on_move = def.on_metadata_inventory_move or nop
	def.on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		blockman.log_player_action(player, "moves stuff in", name, "at", pos)
		return on_move(pos, from_list, from_index, to_list, to_index, count, player)
	end
	local on_put = def.on_metadata_inventory_put or nop
	def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
		blockman.log_player_action(player, "moves", stack:get_name(), stack:get_count(), "to", name, "at", pos)
		return on_put(pos, listname, index, stack, player)
	end
	local on_take = def.on_metadata_inventory_take or nop
	def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
		blockman.log_player_action(player, "takes", stack:get_name(), stack:get_count(), "from", name, "at", pos)
		return on_take(pos, listname, index, stack, player)
	end
end
