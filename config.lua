local seconds, minutes = 1000, 60000
Config = {}

Config.Debug = false

Config.Framework = 'qb' --[ qb, esx, nd, qbx]

Config.timeForBite = { -- Set min and max random range of time it takes for fish to be on the line.
    min = 2 * seconds,
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
        --[[ Lago Zancudo ]]
        type = 'swamp',
        points = {
            vector3(-2081.64, 2605.02, 2.03),
            vector3(-2080.21, 2601.10, 2.03),
            vector3(-2076.41, 2602.48, 2.03),
            vector3(-2077.59, 2606.47, 2.03)
        }
    },
    [3] = {
        --[[ El Gordo Lighthouse ]]
        type = 'sea',
        points = {
            vector3(3374.74, 5184.72, 1.46),
            vector3(3374.33, 5182.05, 1.46),
            vector3(3365.95, 5183.57, 1.46),
            vector3(3366.25, 5185.80, 1.46)
        }
    },
    [4] = {
        --[[ La Puerta ]]
        type = 'sea',
        points = {
            vector3(-802.58, -1511.94, 1.60),
            vector3(-801.42, -1515.35, 1.60),
            vector3(-797.54, -1513.74, 1.60),
            vector3(-798.82, -1510.54, 1.60)
        }
    },
    [5] = {
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

--[[ Gold ~y~ ]]
--[[ Silver ~t~ ]]
--[[ Bronze ~o~ ]]
Config.fish = { -- Rarity is based of color codes see https://docs.fivem.net/docs/game-references/text-formatting/
    -- Sea
    { label = 'Swordfish', price = {850, 950},  type = {'sea'},            difficulty = {'medium', 'medium', 'easy'}, rarity = '~y~' },
    { label = 'Marlin',    price = {850, 950},  type = {'sea'},            difficulty = {'medium', 'medium', 'easy'}, rarity = '~y~' },
    { label = 'Tuna',      price = {600, 750},  type = {'sea'},            difficulty = {'medium', 'easy', 'easy'},   rarity = '~t~' },
    { label = 'Salmon',    price = {300, 380},  type = {'sea', 'lake'},    difficulty = {'medium', 'easy'},           rarity = '~t~' },
    { label = 'Mackerel',  price = {220, 280},  type = {'sea'},            difficulty = {'medium', 'easy'},           rarity = '~t~' },
    { label = 'Trout',     price = {140, 180},  type = {'sea', 'lake'},    difficulty = {'easy', 'easy'},             rarity = '~o~' },
    { label = 'Cod',       price = {140, 180},  type = {'sea'},            difficulty = {'easy'},                     rarity = '~o~' },

    -- Lake
    { label = 'Carp',      price = {400, 500},  type = {'lake'},                  difficulty = {'medium', 'medium', 'easy'},         rarity = '~y~' },
    { label = 'Pike',      price = {300, 400},  type = {'lake', 'swamp'},         difficulty = {'medium', 'medium', 'easy'},         rarity = '~t~' },
    { label = 'Walleye',   price = {280, 380},  type = {'lake'},                  difficulty = {'medium', 'easy', 'easy'},           rarity = '~t~' },
    { label = 'Catfish',   price = {250, 350},  type = {'lake'},                  difficulty = {'medium', 'easy', 'easy'},           rarity = '~t~' },
    { label = 'Bass',      price = {260, 340},  type = {'lake', 'sea', 'swamp'},  difficulty = {'medium', 'easy'},                   rarity = '~o~' },
    { label = 'Perch',     price = {140, 220},  type = {'lake', 'pond'},          difficulty = {'easy', 'easy'},                     rarity = '~o~' },
    { label = 'Crappie',   price = {120, 200},  type = {'lake', 'pond'},          difficulty = {'easy', 'easy'},                     rarity = '~o~' },
    { label = 'Bluegill',  price = {100, 180},  type = {'lake', 'pond'},          difficulty = {'easy'},                             rarity = '~o~' },
    { label = 'Sunfish',   price = {90, 140},   type = {'lake', 'pond'},          difficulty = {'easy'},                             rarity = '~o~' },

    -- Pond
    { label = 'Goldfish',      price = {20, 40},     type = {'pond'},   difficulty = {'easy', 'easy'}, rarity = '~o~' },
    { label = 'Minnow',        price = {12, 24},     type = {'pond'},   difficulty = {'easy', 'easy'}, rarity = '~o~' },
    { label = 'Guppy',         price = {16, 32},     type = {'pond'},   difficulty = {'easy', 'easy'}, rarity = '~o~' },
    { label = 'Mosquito Fish', price = {8, 16},      type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },
    { label = 'Swordtail',     price = {18, 36},     type = {'pond'},   difficulty = {'easy', 'easy'}, rarity = '~o~' },
    { label = 'Platy',         price = {14, 28},     type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },
    { label = 'Tetra',         price = {10, 20},     type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },
    { label = 'Danio',         price = {12, 24},     type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },
    { label = 'Barb',          price = {8, 16},      type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },
    { label = 'Molly',         price = {14, 28},     type = {'pond'},   difficulty = {'easy'},         rarity = '~o~' },

    -- Swamp
    { label = 'Muskellunge',      price = {320, 450},  type = {'swamp'},   difficulty = {'medium', 'medium', 'easy'},  rarity = '~y~' },
    { label = 'Alligator Gar',    price = {240, 350},  type = {'swamp'},   difficulty = {'medium', 'medium', 'easy'},  rarity = '~t~' },
    { label = 'Bowfin',           price = {220, 330},  type = {'swamp'},   difficulty = {'medium', 'easy'},            rarity = '~t~' },
    { label = 'Mudfish',          price = {200, 300},  type = {'swamp'},   difficulty = {'medium', 'easy'},            rarity = '~t~' },
    { label = 'Bullhead Catfish', price = {160, 270},  type = {'swamp'},   difficulty = {'easy', 'easy'},              rarity = '~o~' },
    { label = 'Sucker',           price = {140, 260},  type = {'swamp'},   difficulty = {'easy', 'easy'},              rarity = '~o~' },
    { label = 'Swamp Eel',        price = {150, 250},  type = {'swamp'},   difficulty = {'easy'},                      rarity = '~o~' },
    { label = 'Cricket Frog',     price = {120, 230},  type = {'swamp'},   difficulty = {'easy'},                      rarity = '~o~' }
}
