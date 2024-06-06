Config = Config or {}

Config.debug = false
Config.boxZone = false

Config.craftObjects = {
    {   
        name = "Furnace",
        model = "prop_wooden_barrel",
        coords = vector4(-110.25274658203, -13.871084213257, 69.519638061523, 161.33299255371),
        targetCoords = vector4(-110.25274658203, -13.871084213257, 69.519638061523, 161.33299255371),
        targetDist = 30.0,
        craftType = "food",
    },
    { 
        name = "Workbench", 
        model = "gr_prop_gr_bench_02a", 
        coords = vector4(-506.14105224609, 177.62062072754, 82.157676696777, 89.190635681152),
        targetCoords = vector4(-506.14105224609, 177.62062072754, 83.157676696777, 89.190635681152),
        targetDist = 1.5,
        craftType = "weapons",
    },
}

Config.craftMenu = {
    ["food"] = {
        label = "Food",
        items = {
            ["dried_food"] = {
                name = "Dried Food",
                description = "A dried food item.",
                ingredients = {
                    { name = "apple", label = "Apple", amount = 1 },
                    { name = "banana", label = "Banana", amount = 1 },
                    { name = "strawberry", label = "Strawberry", amount = 1 },
                },
                craftTime = 5000,
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
    ["weapons"] = {
        label = "Weapons",
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