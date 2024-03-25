WaterCheck = function()
    local headPos = GetPedBoneCoords(cache.ped, 31086, 0.0, 0.0, 0.0)
    local offsetPos = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 50.0, -25.0)
    local water, waterPos = TestProbeAgainstWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
    return water, waterPos
end

CreateBlip = function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 317)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Fishing")
    EndTextCommandSetBlipName(blip)

    local radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 50.0)
    SetBlipDisplay(radiusBlip, 2)
    SetBlipColour(radiusBlip, 18)
    SetBlipAlpha(radiusBlip, 100)  -- Adjust the alpha value here (0-255), 255 is fully opaque, 0 is fully transparent
    
    return blip, radiusBlip
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
    local blip, radiusBlip = CreateBlip(coords)
end
