local seconds, minutes = 1000, 60000
Config = {}

Config.Debug = false

Config.Framework = 'qbx' --// qb or qbx

Config.sellShop = {
    enabled = true,
    coords = vec3(-1612.19, -989.18, 13.01-0.9),
    heading = 45.3,
    ped = 'cs_old_man2'
}

Config.bait = {
    itemName = 'fishbait',
    loseChance = 65
}

Config.fishingRod = {
    itemName = 'fishingrod',
}

Config.timeForBite = {
    min = 5 * seconds,
    max = 20 * seconds
}

Config.FishingZones = {
    [1] = {
        --[[ Grape Seed ]]
        type = 'lake',
        points = {
            vector3(715.80, 4092.08, 34.72),
            vector3(715.74, 4096.27, 34.72),
            vector3(711.44, 4096.38, 34.72),
            vector3(711.36, 4092.04, 34.72)
        }
    },
    [2] = {
        --[[ El Gordo Lighthouse ]]
        type = 'sea',
        points = {
            vector3(3374.74, 5184.72, 1.46),
            vector3(3374.33, 5182.05, 1.46),
            vector3(3365.95, 5183.57, 1.46),
            vector3(3366.25, 5185.80, 1.46)
        }
    },
    [3] = {
        --[[ La Puerta ]]
        type = 'sea',
        points = {
            vector3(-802.58, -1511.94, 1.60),
            vector3(-801.42, -1515.35, 1.60),
            vector3(-797.54, -1513.74, 1.60),
            vector3(-798.82, -1510.54, 1.60)
        }
    },
    [4] = {
        --[[ Vinewood Hills ]]
        type = 'pond',
        points = {
            vector3(27.82, 849.53, 197.67),
            vector3(25.14, 852.31, 197.67),
            vector3(36.65, 863.26, 197.67),
            vector3(39.22, 860.48, 197.67)
        }
    },
}

Config.fish = {
    -- Sea
    { item = 'swordfish', label = 'Swordfish', price = {150, 180}, type = {'sea'}, difficulty = {'medium', 'medium', 'easy'} },
    { item = 'mahimahi', label = 'Mahi Mahi', price = {150, 180}, type = {'sea'}, difficulty = {'medium', 'medium', 'easy'} },
    { item = 'marlin', label = 'Marlin', price = {140, 175}, type = {'sea'}, difficulty = {'medium', 'medium', 'easy'} },
    { item = 'tuna', label = 'Tuna', price = {120, 150}, type = {'sea'}, difficulty = {'medium', 'easy', 'easy'} },
    { item = 'salmon', label = 'Salmon', price = {80, 100}, type = {'sea', 'lake'}, difficulty = {'medium', 'easy'} },
    { item = 'mackerel', label = 'Mackerel', price = {60, 80}, type = {'sea'}, difficulty = {'medium', 'easy'} },
    { item = 'trout', label = 'Trout', price = {50, 70}, type = {'sea', 'lake'}, difficulty = {'easy', 'easy'} },
    { item = 'cod', label = 'Cod', price = {45, 65}, type = {'sea'}, difficulty = {'easy'} },

    -- Lake / Pond
    { item = 'carp', label = 'Carp', price = {90, 110}, type = {'lake', 'pond'}, difficulty = {'medium', 'medium', 'easy'} },
    { item = 'walleye', label = 'Walleye', price = {80, 100}, type = {'lake'}, difficulty = {'medium', 'easy', 'easy'} },
    { item = 'catfish', label = 'Catfish', price = {70, 90}, type = {'lake'}, difficulty = {'medium', 'easy', 'easy'} },
    { item = 'bass', label = 'Bass', price = {75, 95}, type = {'lake', 'sea', 'pond'}, difficulty = {'medium', 'easy'} },
    { item = 'perch', label = 'Perch', price = {40, 60}, type = {'lake', 'pond'}, difficulty = {'easy', 'easy'} },
    { item = 'crappie', label = 'Crappie', price = {35, 55}, type = {'lake', 'pond'}, difficulty = {'easy', 'easy'} },
    { item = 'bluegill', label = 'Bluegill', price = {30, 50}, type = {'lake', 'pond'}, difficulty = {'easy'} },
    { item = 'talapia', label = 'Talapia', price = {30, 50}, type = {'lake', 'pond'}, difficulty = {'easy'} },

    -- Miscellaneous
    { item = 'fishbag', label = 'Bag', price = {5, 10}, type = {'sea', 'lake', 'pond'}, difficulty = {'medium', 'easy', 'easy'} },
    { item = 'fishshoe', label = 'Shoe', price = {25, 45}, type = {'sea', 'lake', 'pond'}, difficulty = {'medium', 'easy', 'easy'} },
}

RegisterNetEvent('rup-fishing:notify')
AddEventHandler('rup-fishing:notify', function(title, message, msgType)
    if not msgType then
        lib.notify({
            title = title,
            description = message,
            type = 'inform'
        })
    else
        lib.notify({
            title = title,
            description = message,
            type = msgType
        })
    end
end)