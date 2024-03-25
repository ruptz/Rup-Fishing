lib.callback.register('rup-fishing:server:getFishData', function(source, waterType)
    local fishTable = {}
    for _, fish in ipairs(Config.fish) do
        for _, type in ipairs(fish.type) do
            if type == waterType then
                if Config.Debug then
                    print("^5Debug^7: ^2Water Area^7: '^6"..json.encode(waterType).."^7'")
                end
                table.insert(fishTable, fish)
                break
            end
        end
    end

    local data = fishTable[math.random(#fishTable)]
    if Config.Debug then
        print("^5Debug^7: ^3Selected Fish^7: `^6"..json.encode(data.label).."^7`^3 Type^7: '^6"..json.encode(data.type).."^7'")
    end
    return data
end)

RegisterNetEvent('rup-fishing:server:tryFish', function(data)
    local src = source
    if Config.Framework == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            TriggerClientEvent('rup-fishing:client:ChatNotification', src, "CHAR_RON", "Fishing", "", "You caught a " .. data.rarity .. data.label .. "~s~!")
            local payoutAmount = math.random(data.price[1], data.price[2])
            Player.Functions.AddMoney("cash", payoutAmount, "Fishing")
        end
        if Config.Debug then
            print("^5Debug^7: ^2"..GetPlayerName(src).."^7: ^6Caught Fish^7: " ..data.label)
        end
    elseif Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            TriggerClientEvent('rup-fishing:client:ChatNotification', src, "CHAR_RON", "Fishing", "", "You caught a " .. data.rarity .. data.label .. "~s~!")
            local payoutAmount = math.random(data.price[1], data.price[2])
            xPlayer.addAccountMoney("cash", payoutAmount)
        end
        if Config.Debug then
            print("^5Debug^7: ^2"..GetPlayerName(src).."^7: ^6Caught Fish^7: " ..data.label)
        end
    elseif Config.Framework == 'nd' then
        local Player = NDCore.getPlayer(src)
        if Player then
            TriggerClientEvent('rup-fishing:client:ChatNotification', src, "CHAR_RON", "Fishing", "", "You caught a " .. data.rarity .. data.label .. "~s~!")
            local payoutAmount = math.random(data.price[1], data.price[2])
            Player.addMoney("cash", payoutAmount, "Fishing")
        end
        if Config.Debug then
            print("^5Debug^7: ^2"..GetPlayerName(src).."^7: ^6Caught Fish^7: " ..data.label)
        end
    elseif Config.Framework == 'qbx' then
        local Player = exports.qbx_core:GetPlayer(source)
        if Player then
            TriggerClientEvent('rup-fishing:client:ChatNotification', src, "CHAR_RON", "Fishing", "", "You caught a " .. data.rarity .. data.label .. "~s~!")
            local payoutAmount = math.random(data.price[1], data.price[2])
            Player.Functions.AddMoney("cash", payoutAmount, "Fishing")
        end
        if Config.Debug then
            print("^5Debug^7: ^2"..GetPlayerName(src).."^7: ^6Caught Fish^7: " ..data.label)
        end
    end
end)