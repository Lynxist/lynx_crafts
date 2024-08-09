Config = Config or {}

Config.debug = false -- Set to true to enable target zone debug
Config.boxZone = false -- Set to true to use box zone instead of target entity, might set this to each prop in the future
Config.menu = "qb-menu" -- Menu to use for crafting  /  qb-menu or ox

Config.craftObjects = {
    {   
        name = "Furnace", -- Name will be used in the name of the target zone, example: Craft Furnace
        model = "prop_wooden_barrel", -- Model of the prop
        coords = vector4(-110.25274658203, -13.871084213257, 69.519638061523, 161.33299255371), -- Coords of the prop
        targetCoords = vector4(-110.25274658203, -13.871084213257, 69.519638061523, 161.33299255371), -- Coords of the target zone (if boxZone true, this will be the center of the box)
        targetDist = 30.0, -- Distance of the target zone
        craftType = "food", -- Type of craft, will be used to get the items from Config.craftMenu
    },
    { 
        name = "Workbench", -- Name will be used in the name of the target zone, example: Craft Workbench
        model = "gr_prop_gr_bench_02a", 
        coords = vector4(-506.14105224609, 177.62062072754, 82.157676696777, 89.190635681152),
        targetCoords = vector4(-506.14105224609, 177.62062072754, 83.157676696777, 89.190635681152),
        targetDist = 1.5,
        craftType = "weapons",
    },
}

Config.craftMenu = {
    ["food"] = { -- This key should match the craftType in Config.craftObjects
        label = "Food", -- Label of the category (displayed as a header in the menu)
        items = { -- Items in the category
            ["dried_food"] = { -- This key should match the item name in the items table
                name = "Dried Food", -- Name of the item
                description = "A dried food item.", -- Description of the item
                ingredients = { -- Ingredients required to craft the item
                    { name = "apple", label = "Apple", amount = 1 }, -- name = item name, label = item label, amount = amount required to craft
                    { name = "banana", label = "Banana", amount = 1 },
                    { name = "strawberry", label = "Strawberry", amount = 1 },
                },
                craftTime = 5000, -- Time in milliseconds to craft the item
            },
            ["cooked_meat"] = {
                name = "Cooked Meat",
                description = "A cooked meat item.",
                ingredients = {
                    { name = "raw_meat", label = "Raw Meat", amount = 1 },
                },
                craftTime = 5000,
            },
        }
    },
    ["misc"] = {
        label = "Misc",
        items = {
            ["racing_gps"] = {
                name = "Racing GPS",
                description = "A Racing GPS.",
                ingredients = {
                    { name = "water_bottle", label = "Water Bottle", amount = 1 },
                    { name = "metalscrap", label = "Metal Scrap", amount = 5 },
                },
                craftTime = 5000,
            }
        }
    }
}