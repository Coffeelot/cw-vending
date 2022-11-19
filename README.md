# Vending Machines 🍫
This script makes all vending machines available and adds a qb-target based system for instant purchases. Easily customizable in the Config.lua 

**For QB-Core**

# Preview 
![Really cool image](https://i.imgur.com/5bCwpKc.png)
video coming soon... maybe

# Developed by Coffeelot and Wuggie
[More scripts by us](https://github.com/stars/Coffeelot/lists/cw-scripts)  👈

**Support, updates and script previews**:

[![Join The discord!](https://cdn.discordapp.com/attachments/977876510620909579/1013102122985857064/discordJoin.png)](https://discord.gg/FJY4mtjaKr )

**All our scripts are and will remain free**. If you want to support what we do, you can buy us a coffee here:

[![Buy Us a Coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/cwscriptbois )

# Config 🔧
## If you want to add to the existing machines

For all of these you just need the item name. Price will default to the `Config.DefaultPrice` if you do not assign a price.

Add items to `invSoda` to add to all soda machines.\
Add items to `invWater` if you want to add to the water machines.\
Add items to `invSnack` if you want to add to the water machines.\

## If you want to add machines
Copy one of the existing Machine objects (`sodaMachines` for example), add the prop you want the script to run on and set the inventory to the one you want it to use. Then add the machine in the Config.VendingMachines.


# Add to qb-core
(only needed if you want the default ones that come with the script)
## items.lua
```
	-- snacks 
	['twerks_candy'] 				 = {['name'] = 'twerks_candy', 			  	  	['label'] = 'Twerks', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'twerks_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy'},
	['snikkel_candy'] 				 = {['name'] = 'snikkel_candy', 			  	['label'] = 'Snikkel', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'snikkel_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy'},
	['crisps'] 				 = {['name'] = 'crisps', 			  	['label'] = 'Phat Chips', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'crisps.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Crispy crisps'},
	['egochaser'] 				 = {['name'] = 'egochaser', 			  	['label'] = 'Ego Chaser', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'egochaser.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Chocolate bar'},
	['nachos'] 				 = {['name'] = 'nachos', 			  	['label'] = 'Nacho Chips', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'nachos.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Salty Crisps'},
	-- beverages
	['water_bottle'] 				 = {['name'] = 'water_bottle', 			  	  	['label'] = 'Bottle of Water', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'water_bottle.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['coffee'] 				 		 = {['name'] = 'coffee', 			  	  		['label'] = 'Coffee', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'coffee.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pump 4 Caffeine'},
	['ecola'] 				 	 = {['name'] = 'ecola', 			  	  	['label'] = 'ECola', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'cola.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['ecoladiet'] 				 	 = {['name'] = 'ecoladiet', 			  	  	['label'] = 'ECola Diet', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coladiet.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['sprunk'] 				 	 = {['name'] = 'sprunk', 			  	  	['label'] = 'Sprunk', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'sprunk.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['sprunklight'] 				 	 = {['name'] = 'sprunklight', 			  	  	['label'] = 'Sprunk Light', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'sprunklight.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
```

## qb-smallresources/config.lua

Any items you add in `Config.Items` will automatically become eat/drinkable, but to make these actually remove hunger/thirst you need to add this also.
Add these into their respective list if you want the default items (some of these you might already have)
```
ConsumeablesEat = {
    ...
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["crisps"] = math.random(20, 50),
    ["egochaser"] = math.random(20, 50),
    ["nachos"] = math.random(20, 50),
}

ConsumeablesDrink = {
    ...
    ["water_bottle"] = math.random(35, 54),
    ["ecola"] = math.random(35, 54),
    ["ecoladiet"] = math.random(35, 54),
    ["sprunk"] = math.random(35, 54),
    ["sprunklight"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
}
```



# Dependencies
* qb-target - https://github.com/BerkieBb/qb-target
