local modpath = minetest.get_modpath("blockman")
local chat_path = modpath .. "/scripts/chat"

dofile(chat_path .. "/core.lua")
dofile(chat_path .. "/commands.lua")
dofile(chat_path .. "/home.lua")
