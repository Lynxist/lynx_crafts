QBCore = exports['qb-core']:GetCoreObject()

function spawnProps()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for k, v in pairs(Config.craftObjects) do
        RequestModel(v.model)
        while not HasModelLoaded(v.model) do
            Wait(500)
        end

        print('Spawning prop: '..v.model..' at coords: '..v.coords.x..', '..v.coords.y..', '..v.coords.z..', '..v.coords.w)
        local prop = CreateObject(v.model, v.coords, false, false, false)
        SetEntityHeading(prop, v.coords.w)
        FreezeEntityPosition(prop, true)
        SetModelAsNoLongerNeeded(v.model)

        if Config.boxZone then
            exports['qb-target']:AddBoxZone('craft_'..v.name, vector3(v.targetCoords.x, v.targetCoords.y, v.targetCoords.z), 1.5, 1.5, {
                name = 'craft_'..v.name,
                heading = v.targetCoords.w,
                debugPoly = Config.debug,
                minZ = v.targetCoords.z - 1.0,
                maxZ = v.targetCoords.z + 1.0,
            }, {
                options = {
                    {
                        event = "lynx_crafts:client:createMenu",
                        icon = "fas fa-hammer",
                        label = "Craft "..v.name,
                        craftType = v.craftType,
                    },
                },
                distance = 1.5,
            })
        else
            exports['qb-target']:AddTargetEntity(prop, {
                options = {
                    {
                        event = "lynx_crafts:client:createMenu",
                        icon = "fas fa-hammer",
                        label = "Craft "..v.name,
                        craftType = v.craftType,
                    },
                },
                distance = v.targetDist,
            })
        end
    end
end

function GenerateCraftMenu(craftType)
    print('Generating menu for craft type: ' .. craftType)
    local menu = {}
    if Config.menu == "qb-menu" then
        if Config.craftMenu[craftType] then
            local category = Config.craftMenu[craftType]
            table.insert(menu, {
                header = category.label,
                isMenuHeader = true
            })

            for itemName, item in pairs(category.items) do

                local ingredientsText = "Ingredients: <br>"
                for _, ingredient in pairs(item.ingredients) do
                    ingredientsText = ingredientsText .. ingredient.amount .. "x " .. ingredient.label .. "<br>"
                end

                ingredientsText = ingredientsText:sub(1, -5)

                table.insert(menu, {
                    header = item.name,
                    txt = item.description .. "<br><br>" .. ingredientsText,
                    params = {
                        event = "lynx_crafts:client:craftItem",
                        args = {
                            itemName = itemName,
                            craftType = craftType
                        }
                    }
                })
            end
        else
            print('No menu found for craft type: ' .. craftType)
        end
    elseif Config.menu == "ox" then
        if Config.craftMenu[craftType] then
            local category = Config.craftMenu[craftType]

            for itemName, item in pairs(category.items) do

                local ingredientsText = "Ingredients: \n"
                for _, ingredient in pairs(item.ingredients) do
                    ingredientsText = ingredientsText .. ingredient.amount .. "x " .. ingredient.label .. "\n"
                end

                table.insert(menu, {
                    id = itemName,
                    title = item.name,
                    icon = "fas fa-hammer",
                    description = item.description .. "\n\n" .. ingredientsText,
                    onSelect = function()
                        TriggerEvent("lynx_crafts:client:craftItem", {itemName = itemName, craftType = craftType})
                    end
                })
            end
            local aids = Config.craftMenu[craftType]
            lib.registerContext({
                id = "crafting",
                title = aids.label .. " Crafting",
                options = menu
            })
        else
            print('No menu found for craft type: ' .. craftType)
        end
    end

    return menu
end


RegisterNetEvent("lynx_crafts:client:createMenu")
AddEventHandler("lynx_crafts:client:createMenu", function(data)
    local craftType = data.craftType
    print('Opening craft menu for type: ' .. craftType)
    local menu = GenerateCraftMenu(craftType)
    if #menu > 0 then
        if Config.menu == "qb-menu" then
            exports['qb-menu']:openMenu(menu)
        elseif Config.menu == "ox" then
            lib.showContext("crafting")
        end
    else
        print("No items found for this crafting station type")
    end
end)

RegisterNetEvent("lynx_crafts:client:craftItem")
AddEventHandler("lynx_crafts:client:craftItem", function(data)
    local itemName = data.itemName
    local craftType = data.craftType
    local player = QBCore.Functions.GetPlayerData()
    local itemConfig = Config.craftMenu[craftType].items[itemName]

    print('Crafting item: ' .. itemName .. ' of type: ' .. craftType)

    local hasIngredients = true
    for _, ingredient in pairs(itemConfig.ingredients) do
        local item = QBCore.Functions.HasItem(ingredient.name, ingredient.amount)
        if not item then
            hasIngredients = false
            break
        end
    end

    if hasIngredients then

        TriggerServerEvent('lynx_crafts:server:removeItems', itemConfig.ingredients)

        QBCore.Functions.Progressbar('crafting_item', 'Crafting ' .. itemConfig.name .. '...', itemConfig.craftTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('lynx_crafts:server:addItem', itemName)
        end, function() -- Cancel
            QBCore.Functions.Notify('Crafting cancelled.', 'error')
        end)
    else
        QBCore.Functions.Notify('You don\'t have the required ingredients.', 'error')
    end
end)

Citizen.CreateThread(function()
    spawnProps()
end)