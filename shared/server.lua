local QBCore = exports['qb-core']:GetCoreObject()

function GetPlayer(source)
    if Config.Framework == 'qbx' then
        return exports.qbx_core:GetPlayer(source)
    elseif Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    else
        print("^5Debug^7: ^3Set Framework In Config!!!^7: ^6 shared/server.lua line: 9^7")
    end
end

function KickPlayer(source, reason)
    if Config.Framework == 'qbx' then
        DropPlayer(source, 'Fishing Exploit')
    elseif Config.Framework == 'qb' then
        QBCore.Functions.Kick(source, reason, true, true)
    else
        print("^5Debug^7: ^3Set Framework In Config!!!^7: ^6 shared/server.lua line: 19^7")
    end
end

function HasItem(source, item)
    local player = GetPlayer(source)
    local item = player.Functions.GetItemByName(item)
    if GetResourceState('ox_inventory') == 'started' then
        return item?.count or 0
    else
        return item?.amount or 0
    end
end

function AddItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    return player.Functions.AddItem(item, count, slot, metadata)
end

function RemoveItem(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    player.Functions.RemoveItem(item, count, slot, metadata)
end

function AddMoney(source, type, amount)
    if type == 'money' then type = 'cash' end
    local player = GetPlayer(source)
    if GetResourceState('Renewed-Banking') == 'started' then
        player.Functions.AddMoney(type, amount, 'Rup-Fishing')
    else
        player.Functions.AddMoney(type, amount)
    end
end