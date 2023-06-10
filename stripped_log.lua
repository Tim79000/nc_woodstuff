local include, nodecore
    = include, nodecore

local modname = minetest.get_current_modname()


minetest.register_node(modname .. ":stripped_log", {
		description = "Stripped Log",
		tiles = {
			modname .. "_stripped_tree_top.png",
			modname .. "_stripped_tree_top.png",
			modname .. "_stripped_tree_side.png"
		},
		groups = {
			choppy = 2,
			flammable = 8,
			fire_fuel = 6,
			log = 1,
		},
		sounds = nodecore.sounds("nc_tree_woody"),
		paramtype2 = "facedir",
		on_place = minetest.rotate_node
	})

nodecore.register_craft({
		label = "debark log",
		action = "pummel",
		toolgroups = {choppy = 2},
--                normal {y = normaly},
		nodes = {
			{match = "nc_tree:log", replace = modname .. ":stripped_log"}
		},
		items = {
			{name = modname .. ":bark", count = 4, scatter = 5}
		},
	})

-- Overrides the vanilla recipe to fix a bug.

local function splitrecipe(choppy, normaly)
	nodecore.register_craft({
			label = "split tree to planks",
			action = "pummel",
			toolgroups = {choppy = choppy},
			normal = {y = normaly},
			check = function(_, data)
				local y = nodecore.facedirs[data.node.param2].t.y
				return y == 1 or y == -1
			end,
			indexkeys = {"group:log"},
			nodes = {
				{match = {groups = {log = true}}, replace = "air"}
			},
			items = {
				{name = "nc_woodwork:plank", count = 4, scatter = 5}
			}
		})
end
splitrecipe(1, 1)
splitrecipe(4, -1)
