local fishing = false
local hasAlertShown = false
local fishingZones = {}
local waterType = nil
local isInZone = false

if Config.sellShop.enabled then
    CreateThread(function()
        local ped, textUI
        CreateBlip(Config.sellShop.coords, 317, 18, Strings.sell_shop_blip, 0.80, false)
        local point = lib.points.new({
            coords = Config.sellShop.coords,
            distance = 30
        })

        function point:nearby()
            if self.currentDistance < self.distance then
                if not ped then
                    lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                    lib.requestModel(Config.sellShop.ped, 100)
                    ped = CreatePed(28, Config.sellShop.ped, Config.sellShop.coords.x, Config.sellShop.coords.y, Config.sellShop.coords.z, Config.sellShop.heading, false, false)
                    FreezeEntityPosition(ped, true)
                    SetEntityInvincible(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                end
                if self.currentDistance <= 1.8 then
                    if not textUI then
                        lib.showTextUI(Strings.sell_fish)
                        textUI = true
                    end
                    if IsControlJustReleased(0, 38) then
                        FishingSellItems()
                    end
                elseif self.currentDistance >= 1.9 and textUI then
                    lib.hideTextUI()
                    textUI = nil
                end
            end
        end

        function point:onExit()
            if ped then
                local model = GetEntityModel(ped)
                SetModelAsNoLongerNeeded(model)
                DeletePed(ped)
                SetPedAsNoLongerNeeded(ped)
                RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                ped = nil
            end
        end
    end)
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('rup-fishing:client:beginFishing', function(waterType)
    if IsPedInAnyVehicle(cache.ped) or IsPedSwimming(cache.ped) then
        lib.notify({ title = 'Fishing', description = 'You cant fish like this...', type = 'error' })
        return
    end
    local water, waterLoc = WaterCheck()
    if water then
        if not fishing then
            fishing = true
            local model = `prop_fishing_rod_01`
            lib.requestModel(model, 100)
            local pole = CreateObject(model, GetEntityCoords(cache.ped), true, false, false)
            AttachEntityToEntity(pole, cache.ped, GetPedBoneIndex(cache.ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
            SetModelAsNoLongerNeeded(model)
            lib.requestAnimDict('mini@tennis', 100)
            lib.requestAnimDict('amb@world_human_stand_fishing@idle_a', 100)
            TaskPlayAnim(cache.ped, 'mini@tennis', 'forehand_ts_md_far', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
            Wait(3000)
            TaskPlayAnim(cache.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
            while fishing do
                Wait()
                local unarmed = `WEAPON_UNARMED`
                SetCurrentPedWeapon(ped, unarmed)
                alert('Press ~INPUT_ATTACK~ to cast line, ~INPUT_FRONTEND_RRIGHT~ to cancel.')
                DisableControlAction(0, 24, true)
                if IsDisabledControlJustReleased(0, 24) then
                    local hasBait = lib.callback.await('rup-fishing:checkItem', 100, Config.bait.itemName)
                    if not hasBait then
                        ClearPedTasks(cache.ped)
                        fishing = false
                        DeleteObject(pole)
                        RemoveAnimDict('mini@tennis')
                        RemoveAnimDict('amb@world_human_stand_fishing@idle_a')
                        lib.notify({ title = 'Fishing', description = 'You need fishing bait to fish...', type = 'error' })
                        return
                    end
                    TaskPlayAnim(cache.ped, 'mini@tennis', 'forehand_ts_md_far', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
                    lib.notify({ title = 'Fishing', description = 'Wait for the fish to bite...', type = 'warning' })
                    Wait(math.random(Config.timeForBite.min, Config.timeForBite.max))
                    lib.notify({ title = 'Fishing', description = 'The fish is on the hook go!!!', type = 'success' })
                    Wait(1000)
                    local fishData = lib.callback.await('rup-fishing:server:getFishData', 100, waterType)
                    if Config.Debug then
                        print("^5Debug^7: ^3Fish Data^7: ^6"..json.encode(fishData).."")
                    end
                    if lib.skillCheck(fishData.difficulty) then
                        ClearPedTasks(cache.ped)
                        TriggerServerEvent('rup-fishing:server:tryFish', fishData)
                        TaskPlayAnim(cache.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
                    else
                        lib.notify({ title = 'Fishing', description = 'The fish got away...', type = 'error' })
                    end
                elseif IsControlJustReleased(0, 194) then
                    ClearPedTasks(cache.ped)
                    break
                elseif #(GetEntityCoords(cache.ped) - waterLoc) > 30 then
                    break
                end
            end
            fishing = false
            DeleteObject(pole)
            RemoveAnimDict('mini@tennis')
            RemoveAnimDict('amb@world_human_stand_fishing@idle_a')
        end
    else
        lib.notify({ title = 'Fishing', description = 'To far from water...', type = 'error' })
    end
end)

RegisterNetEvent('rup-fishing:client:interupt', function()
    fishing = false
    ClearPedTasks(cache.ped)
end)

function useRod()
    if not isInZone then
        lib.notify({ title = 'Fishing', description = 'You must be near a fishing area to use the rod...', type = 'error' })
        return
    end
    if waterType == nil then
        lib.notify({ title = 'Fishing', description = 'You need a fishing rod to fish...', type = 'error' })
        return
    end
    local hasBait = lib.callback.await('rup-fishing:checkItem', 100, Config.bait.itemName)
    if not hasBait then
        lib.notify({ title = 'Fishing', description = 'You need fishing bait to fish...', type = 'error' })
        return
    end
    TriggerEvent('rup-fishing:client:beginFishing', waterType)
end
exports("useRod", useRod)

function isFishingZone(self)
    waterType = self.water
    if not hasAlertShown then
        isInZone = true
        if Config.Debug then
            print("^5Debug^7: ^3Entered fishing zone of type^7: ^6"..json.encode(self.water).."")
        end
        hasAlertShown = true
    end
end

function isFishingExit(self)
    if hasAlertShown == true then
        waterType = nil
        isInZone = false
        hasAlertShown = false
    end
end

for i, zoneData in ipairs(Config.FishingZones) do
    local poly = lib.zones.poly({
        points = zoneData.points,
        water = zoneData.type,
        thickness = 2,
        debug = Config.Debug,
        inside = isFishingZone,
        onExit = isFishingExit,
    })
    if Config.Debug then
        print("^5Debug^7: ^3Zone Data Type^7: ^6"..json.encode(zoneData.type).."")
    end
    table.insert(fishingZones, poly)
end