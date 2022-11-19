local QBCore = exports['qb-core']:GetCoreObject() 

local function hasLockpick() 
    for k, pick in ipairs(Config.Lockpicks) do
        print(pick)
        if QBCore.Functions.HasItem(pick) then
            return true
        end
    end
    return false
end

--- Create trader joes
CreateThread(function()
    for i,machineType in pairs(Config.VendingMachines) do
        
        local options = {}
        if Config.AllowTheft then
            options[1] = {
                type = 'client',
                icon = "fas fa-unlock",
                label = "Lockpick",
                event = 'cw-vending-machines:client:lockpick',
                params = {
                    machineInventory = machineType.inventory
                },
                canInteract = function() return hasLockpick() end
            }
        end

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
    TriggerEvent('animations:client:EmoteCommandStart', {"dispenser"})
    TriggerServerEvent('cw-vending-machines:server:attemptPurchase', item) 
end)

local machineItems = {}


local function callCops()
    local coordinates = GetEntityCoords(PlayerPedId())
    local s1, s2 = GetStreetNameAtCoord(coordinates.x, coordinates.y, coordinates.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then
        streetLabel = streetLabel .. " " .. street2
    end
    TriggerServerEvent("cw-vending-machines:server:callCops", coordinates,  streetLabel)
end

local function lockpickFinish(success)
    local callChance = math.random(0,100)
    if callChance > 50 then
        callCops()
    end
    if success then
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('cw-vending-machines:server:steal', machineItems)
        QBCore.Functions.Notify('You successfully got into the machine', "success", 2500)
        Wait(4000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent('animations:client:EmoteCommandStart', {"damn"})
        if usingAdvanced then
            if math.random(1, 100) < 5 then
                TriggerServerEvent('cw-vending-machines:server:removeAdvancedLockpick')
            end
        else
            if math.random(1, 100) < 10 then
                TriggerServerEvent("qb-houserobbery:server:removeLockpick")
            end
        end

        QBCore.Functions.Notify("You weren't able to lockpick the machine", "error", 2500)
    end
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

RegisterNetEvent('cw-vending-machines:client:lockpick', function(data)
    machineItems = data.params.machineInventory
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
end)

RegisterNetEvent('cw-vending-machines:client:success', function(item)
    QBCore.Functions.Notify('You bought a '..QBCore.Shared.Items[item.name].label, 'success')
end)

RegisterNetEvent('cw-vending-machines:client:failed', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"damn"})
    QBCore.Functions.Notify('Not enough cash', 'error')
    
end)

RegisterNUICallback('callcops', function(_, cb)
    TriggerEvent("police:SetCopAlert")
    cb('ok')
end)
