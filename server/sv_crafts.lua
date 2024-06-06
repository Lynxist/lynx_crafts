local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('lynx_crafts:server:removeItems')
AddEventHandler('lynx_crafts:server:removeItems', function(items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for _, item in pairs(items) do
        if Player.Functions.GetItemByName(item.name) and Player.Functions.GetItemByName(item.name).amount >= item.amount then
            Player.Functions.RemoveItem(item.name, item.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough ' .. item.name, 'error')
            return false
        end
    end

    return true
end)

RegisterNetEvent('lynx_crafts:server:addItem')
AddEventHandler('lynx_crafts:server:addItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem(itemName, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")
    TriggerClientEvent('QBCore:Notify', src, 'You crafted ' .. QBCore.Shared.Items[itemName].label .. '!', 'success')
end)
