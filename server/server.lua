local QBCore = exports['qb-core']:GetCoreObject() 

local function callPolice()
    if not isLoggedIn then return end
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name == "police" and PlayerJob.onduty then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        TriggerServerEvent('police:server:policeAlert', "Theft (Vending machine)")
    end
end

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


RegisterNetEvent('cw-vending-machines:server:steal', function(machineItems)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    for j, item in pairs(machineItems) do
        if QBCore.Shared.Items[item.name] then
            local price = Config.DefaultPrice
            if item.price then
                price = item.price
            end
            local amount = math.random(0,10)
            Player.Functions.AddItem(item.name, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item.name], "add")
        else
            print(item.name.. " seems to be missing from your items.lua")
        end
    end
end)

RegisterNetEvent('cw-vending-machines:server:removeAdvancedLockpick', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem('advancedlockpick', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['advancedlockpick'], "add")

end)

RegisterNetEvent('cw-vending-machines:server:removeLockpick', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem('lockpick', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lockpick'], "add")
end)

RegisterNetEvent('cw-vending-machines:server:callCops', function(coords, streetLabel)
    local alertData = {
        title = "10-33 | Robbery (Vending Machine)",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = 'Vending machine break in at '..streetLabel
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
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
