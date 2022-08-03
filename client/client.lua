local QBCore = exports['qb-core']:GetCoreObject() 

--- Create trader joes
CreateThread(function()
    for i,machineType in pairs(Config.VendingMachines) do
        
        local options = {}
        for j, item in pairs(machineType.inventory) do
            if QBCore.Shared.Items[item.name] then
                local price = Config.DefaultPrice
                if item.price then
                    price = item.price
                end
                options[#options+1] = {
                    type = 'client',
                    icon = "fas fa-cash-register",
                    label = QBCore.Shared.Items[item.name].label.. ' $' ..price,
                    event = 'cw-vending-machines:client:buy',
                    params = {
                        item = item
                    }
                }
            else
                print(item.name.. " seems to be missing from your items.lua")
            end
        end
        exports['qb-target']:AddTargetModel(machineType.props, {
            options = options,
            distance = 2.0
        })
    end
end)

RegisterNetEvent('cw-vending-machines:client:buy', function(data)
    local item = data.params.item
    TriggerEvent('animations:client:EmoteCommandStart', {"id"})
    TriggerServerEvent('cw-vending-machines:server:attemptPurchase', item) 
end)

RegisterNetEvent('cw-vending-machines:client:success', function(item)
    QBCore.Functions.Notify('You bought a '..QBCore.Shared.Items[item.name].label, 'success')
end)

RegisterNetEvent('cw-vending-machines:client:failed', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"damn"})
    QBCore.Functions.Notify('Not enough cash', 'error')
    
end)