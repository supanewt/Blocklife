-- Blocklands worldgen systems

local modpath = minetest.get_modpath("blocklands")

local function load(script)
	dofile(modpath .. "/scripts/" .. script)
end

local function force_default_prefix(name)
	if type(name) ~= "string" then
		return name
	end
	if name:sub(1, 1) == ":" then
		return name
	end
	if name:sub(1, 10) == "blocklife:" then
		return ":" .. name
	end
	return name
end

local function with_default_prefix_registration(fn)
	local reg = {
		register_node = minetest.register_node,
		register_craftitem = minetest.register_craftitem,
		register_tool = minetest.register_tool,
		register_item = minetest.register_item,
		register_entity = minetest.register_entity,
		register_abm = minetest.register_abm,
		register_lbm = minetest.register_lbm,
		register_decoration = minetest.register_decoration,
		register_ore = minetest.register_ore,
		register_biome = minetest.register_biome,
	}

	minetest.register_node = function(name, def)
		return reg.register_node(force_default_prefix(name), def)
	end
	minetest.register_craftitem = function(name, def)
		return reg.register_craftitem(force_default_prefix(name), def)
	end
	minetest.register_tool = function(name, def)
		return reg.register_tool(force_default_prefix(name), def)
	end
	minetest.register_item = function(name, def)
		return reg.register_item(force_default_prefix(name), def)
	end
	minetest.register_entity = function(name, def)
		return reg.register_entity(force_default_prefix(name), def)
	end
	minetest.register_abm = function(def)
		if def and def.name then
			def.name = force_default_prefix(def.name)
		end
		return reg.register_abm(def)
	end
	minetest.register_lbm = function(def)
		if def and def.name then
			def.name = force_default_prefix(def.name)
		end
		return reg.register_lbm(def)
	end
	minetest.register_decoration = function(def)
		if def and def.name then
			def.name = force_default_prefix(def.name)
		end
		return reg.register_decoration(def)
	end
	minetest.register_ore = function(def)
		if def and def.name then
			def.name = force_default_prefix(def.name)
		end
		return reg.register_ore(def)
	end
	minetest.register_biome = function(def)
		if def and def.name then
			def.name = force_default_prefix(def.name)
		end
		return reg.register_biome(def)
	end

	fn()

	minetest.register_node = reg.register_node
	minetest.register_craftitem = reg.register_craftitem
	minetest.register_tool = reg.register_tool
	minetest.register_item = reg.register_item
	minetest.register_entity = reg.register_entity
	minetest.register_abm = reg.register_abm
	minetest.register_lbm = reg.register_lbm
	minetest.register_decoration = reg.register_decoration
	minetest.register_ore = reg.register_ore
	minetest.register_biome = reg.register_biome
end

with_default_prefix_registration(function()
	-- Worldgen and decorations
	load("worldgen/init.lua")

	-- Dungeon generation
	load("dungeons/init.lua")

	-- Ambient decorations
	load("ambient/init.lua")
end)

-- Flowers mapgen needs flowers API
if blockman and blockman.flowers then
	load("worldgen/flowers.lua")
else
	minetest.register_on_mods_loaded(function()
		load("worldgen/flowers.lua")
	end)
end
