local include, nodecore
    = include, nodecore

local modname = minetest.get_current_modname()

minetest.register_craftitem(modname..":bark", { -- Bark
	description = "Bark",
	inventory_image = "nc_tree_tree_side.png^[mask:" .. modname .. "_bark.png",
	wield_image = "nc_tree_tree_side.png^[mask:" .. modname .. "_bark.png",
	sounds = nodecore.sounds("nc_tree_woody"),
	groups = {
		choppy = 1,
		bark = 1
		}
})

minetest.register_node(modname .. ":bark_block", {
		description = "Bark Block",
		tiles = {"nc_tree_tree_side.png^nc_woodstuff_bark_overlay.png"}, --Currently having issues with "modname .."
		groups = {
			choppy = 2,
			flammable = 2,
			fire_fuel = 5,
			log = 1,
			scaling_time = 75
		},
		sounds = nodecore.sounds("nc_tree_woody")
	})

nodecore.register_craft({
		label = "compress bark into a block",
		action = "pummel",
		indexkeys = {modname .. ":bark"},
		nodes = {
			{
				match = {name = modname .. ":bark", count = 8},
				replace = modname .. ":bark_block"
			}
		},
		toolgroups = {thumpy = 2}
	})

nodecore.register_craft({
		label = "break bark block apart",
		action = "pummel",
		indexkeys = {modname .. ":bark_block"},
		nodes = {
			{match = {name = modname .. ":bark_block"}, replace = "air"}
		},
		items = {
			{name = modname .. ":bark 2", count = 4, scatter = 5}
		},
		toolgroups = {choppy = 2},
		itemscatter = 5
	})