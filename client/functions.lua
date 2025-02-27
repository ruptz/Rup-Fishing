WaterCheck = function()
    local headPos = GetPedBoneCoords(cache.ped, 31086, 0.0, 0.0, 0.0)
    local offsetPos = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 50.0, -25.0)
    local water, waterPos = TestProbeAgainstWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
    return water, waterPos
end

CreateBlip = function(coords, sprite, colour, text, scale, radius)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
	AddTextEntry(text, text)
	BeginTextCommandSetBlipName(text)
	EndTextCommandSetBlipName(blip)

    if radius then
        local radiusBlip = AddBlipForRadius(coords, 50.0)
        SetBlipDisplay(radiusBlip, 2)
        SetBlipColour(radiusBlip, 18)
        SetBlipAlpha(radiusBlip, 100)
    end
    return blip
end

for i, blipLoc in ipairs(Config.FishingZones) do
    local centerX, centerY, centerZ = 0, 0, 0
    for _, point in ipairs(blipLoc.points) do
        centerX = centerX + point.x
        centerY = centerY + point.y
        centerZ = centerZ + point.z
    end
    local numPoints = #blipLoc.points
    centerX = centerX / numPoints
    centerY = centerY / numPoints
    centerZ = centerZ / numPoints
    
    local coords = vector3(centerX, centerY, centerZ)
    local blip, radiusBlip = CreateBlip(coords, 317, 18, 'Fishing', 0.7, true)
end

FishingSellItems = function()
	TriggerServerEvent('rup-fishing:sellFish')
end
