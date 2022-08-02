local QBCore = exports['qb-core']:GetCoreObject() 

RegisterServerEvent('cw-vending-machines:server:attemptPurchase', function(item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.Functions.GetMoney('cash')
    if cash < item.price then
        TriggerClientEvent('cw-vending-machines:client:failed', src)
    else
        Player.Functions.RemoveMoney("cash", item.price, "Vending Machine")
        Player.Functions.AddItem(item.name, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "add")
        TriggerClientEvent('cw-vending-machines:client:success', item)
    end
end)

for i, drinkItem in ipairs(Config.Items.beverages) do
    QBCore.Functions.CreateUseableItem(drinkItem, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1, item.slot) then
            TriggerClientEvent("consumables:client:Drink", source, item.name)
        end
    end)
end

for i, foodItem in ipairs(Config.Items.food) do
    QBCore.Functions.CreateUseableItem(foodItem, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1, item.slot) then
            TriggerClientEvent("consumables:client:Eat", source, item.name)
        end
    end)
end
