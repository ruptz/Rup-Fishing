local fishing = false
local hasAlertShown = false

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('rup-fishing:client:ChatNotification', function(icon, title, subtitle, message)
    if not icon then
        icon = "CHAR_LESTER"
    end
    if not title then
        title = ""
    end
    if not subtitle then
        subtitle = ""
    end
    if not message then
        message = ""
    end

    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage(icon, icon, false, 2, title, subtitle, "")
    DrawNotification(false, true)
    PlaySoundFrontend(-1, "GOON_PAID_SMALL", "GTAO_Boss_Goons_FM_SoundSet", 0)
end)

RegisterNetEvent('rup-fishing:client:beginFishing', function(waterType)
    if IsPedInAnyVehicle(cache.ped) or IsPedSwimming(cache.ped) then
        TriggerEvent("rup-fishing:client:ChatNotification", "CHAR_RON", "Fishing", "", "You can't fish like this...")
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
                    TaskPlayAnim(cache.ped, 'mini@tennis', 'forehand_ts_md_far', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
                    TriggerEvent("rup-fishing:client:ChatNotification","CHAR_RON", "Fishing", "", "Wait for the fish to bite...")
                    Wait(math.random(Config.timeForBite.min, Config.timeForBite.max))
                    TriggerEvent("rup-fishing:client:ChatNotification","CHAR_RON", "Fishing", "", "The fish is on the hook go!!!")
                    Wait(1000)
                    local fishData = lib.callback.await('rup-fishing:server:getFishData', 100, waterType)
                    print("Fish Data:", json.encode(fishData))
                    if lib.skillCheck(fishData.difficulty) then
                        ClearPedTasks(cache.ped)
                        TriggerServerEvent('rup-fishing:server:tryFish', fishData)
                        TaskPlayAnim(cache.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
                    else
                        TriggerEvent("rup-fishing:client:ChatNotification","CHAR_RON", "Fishing", "", "The fish got away...")
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
        TriggerEvent("rup-fishing:client:ChatNotification","CHAR_RON", "Fishing", "", "You cant catch a fish on land dumbass...")
    end
end)

RegisterNetEvent('rup-fishing:client:interupt', function()
    fishing = false
    ClearPedTasks(cache.ped)
end)

function isFishingZone(self)
    local waterType = self.water
    if not hasAlertShown then
        alert("Press ~INPUT_CONTEXT~ to start fishing.")
        print("Entered fishing zone of type:", self.water)
        hasAlertShown = true
    end
    
    if IsControlJustPressed(1, 38) then
        TriggerEvent('rup-fishing:client:beginFishing', waterType)
    end
end

function isFishingExit(self)
    if hasAlertShown == true then
        hasAlertShown = false
    end
end

local fishingZones = {}

for i, zoneData in ipairs(Config.FishingZones) do
    local poly = lib.zones.poly({
        points = zoneData.points,
        water = zoneData.type,
        thickness = 2,
        debug = Config.Debug,
        inside = isFishingZone,
        onExit = isFishingExit,
    })
    print(zoneData.type)
    table.insert(fishingZones, poly)
end