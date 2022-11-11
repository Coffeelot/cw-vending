Config = {}
--[[ 
    if non special ped a:
        label = v.Boss.missionTitle.. ' $'..v.RunCost,
        canInteract = function()
            local playerCoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(playerCoords,v.Boss.coords) > 3 then return false end
        end
]]

Config.DefaultPrice = 10

Config.Items = {
    beverages = {
        "coffee",
        "ecola",
        "ecoladiet",
        "sprunklight",
        "water_bottle"
    },
    food = {
        "twerks_candy",
        "snikkel_candy",
        "crisps",
        "nachos"
    }
}

-- INVENTORIES 
local invCoffee = {
    { name = "coffee", price = 10 }
}

local invSoda = {
    { name = "ecola", price = 10 },
    { name = "ecoladiet", price = 10 },
    { name = "sprunk", price = 10 },
    { name = "sprunklight", price = 10 },
}

local invWater = {
    { name = "water_bottle", price = 10 }
}

local invSnack = {
    { name = "twerks_candy", price = 10 },
    { name = "snikkel_candy", price = 10 },
    { name = "crisps", price = 10 },
    { name = "nachos", price = 10 },
}

-- MACHINES

local sodaMachines = {
    props = {
        "prop_vend_soda_01",
        "prop_vend_soda_02"
    },
    inventory = invSoda
}

local waterMachines = {
    props = { "prop_vend_water_01" },
    inventory = invWater
}

local coffeeMachines = {
    props = { "prop_vend_coffe_01" },
    inventory = invCoffee
}

local snackMachines = {
    props = { "prop_vend_snak_01", "prop_vend_snak_01_tu"},
    inventory = invSnack
}

Config.VendingMachines = {
    sodaMachines,
    waterMachines,
    coffeeMachines,
    snackMachines,
}

Config.CallChance = 50

Config.CashAmount = {
    min = 10,
    max = 100
}

Config.Lockpicks = {
    'lockpick',
    'advancedlockpick'
}