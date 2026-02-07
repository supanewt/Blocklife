-- Load support for MT game translation.
local S = minetest.get_translator("blockmatter")

blockman = blockman or {}
blockman.expose_global = blockman.expose_global or function(name, tbl)
	if rawget(_G, name) == nil then
		_G[name] = tbl
	end
end
blockman.dye = blockman.dye or {}
local dye = blockman.dye
blockman.expose_global("dye", dye)

-- Make dye names and descriptions available globally
dye.dyes = {
	{"white",      "White"},
	{"grey",       "Grey"},
	{"dark_grey",  "Dark Grey"},
	{"black",      "Black"},
	{"violet",     "Violet"},
	{"blue",       "Blue"},
	{"cyan",       "Cyan"},
	{"dark_green", "Dark Green"},
	{"green",      "Green"},
	{"yellow",     "Yellow"},
	{"brown",      "Brown"},
	{"orange",     "Orange"},
	{"red",        "Red"},
	{"magenta",    "Magenta"},
	{"pink",       "Pink"},
}

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local description = row[2]
	local groups = {dye = 1}
	groups["color_" .. name] = 1

	minetest.register_alias("dye:" .. name, "blocklife:dye_" .. name)

	minetest.register_craftitem("blocklife:dye_" .. name, {
		inventory_image = "dye_" .. name .. ".png",
		description = S(description .. " Dye"),
		groups = groups
	})

	minetest.register_craft({
		output = "blocklife:dye_" .. name .. " 4",
		recipe = {
			{"group:flower,color_" .. name}
		},
	})
end

-- Manually add coal -> black dye
minetest.register_craft({
	output = "blocklife:dye_black 4",
	recipe = {
		{"group:coal"}
	},
})

-- Manually add blueberries->violet dye
minetest.register_craft({
	output = "blocklife:dye_violet 2",
	recipe = {
		{"blocklife:blueberries"}
	},
})

-- Mix recipes
local dye_recipes = {
	-- src1, src2, dst
	-- RYB mixes
	{"red", "blue", "violet"}, -- "purple"
	{"yellow", "red", "orange"},
	{"yellow", "blue", "green"},
	-- RYB complementary mixes
	{"yellow", "violet", "dark_grey"},
	{"blue", "orange", "dark_grey"},
	-- CMY mixes - approximation
	{"cyan", "yellow", "green"},
	{"cyan", "magenta", "blue"},
	{"yellow", "magenta", "red"},
	-- other mixes that result in a color we have
	{"red", "green", "brown"},
	{"magenta", "blue", "violet"},
	{"green", "blue", "cyan"},
	{"pink", "violet", "magenta"},
	-- mixes with black
	{"white", "black", "grey"},
	{"grey", "black", "dark_grey"},
	{"green", "black", "dark_green"},
	{"orange", "black", "brown"},
	-- mixes with white
	{"white", "red", "pink"},
	{"white", "dark_grey", "grey"},
	{"white", "dark_green", "green"},
}

for _, mix in pairs(dye_recipes) do
	minetest.register_craft({
		type = "shapeless",
		output = "blocklife:dye_" .. mix[3] .. " 2",
		recipe = {"blocklife:dye_" .. mix[1], "blocklife:dye_" .. mix[2]},
	})
end

-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this run:
-- for _,e in ipairs(dye.dyes) do print(("S(%q)"):format(e[2].." Dye")) end

--[[
S("White Dye")
S("Grey Dye")
S("Dark Grey Dye")
S("Black Dye")
S("Violet Dye")
S("Blue Dye")
S("Cyan Dye")
S("Dark Green Dye")
S("Green Dye")
S("Yellow Dye")
S("Brown Dye")
S("Orange Dye")
S("Red Dye")
S("Magenta Dye")
S("Pink Dye")
--]]
