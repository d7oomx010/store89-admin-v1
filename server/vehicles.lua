--=====================================================
-- Store89 Admin - Vehicle Events
--=====================================================

local function HasPermission(src)
    if Store89 and Store89.HasPermission then
        return Store89.HasPermission(src)
    end

    return IsPlayerAceAllowed(src, "store89.admin")
end

local function Notify(src, msg, type)
    TriggerClientEvent("ox_lib:notify", src, {
        title = "Store89 Admin",
        description = msg,
        type = type or "inform"
    })
end

RegisterNetEvent("store89-admin:spawnVehicle", function(model)
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:spawnVehicle", src, model)
end)

RegisterNetEvent("store89-admin:deleteVehicle", function()
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:deleteVehicle", src)
end)

RegisterNetEvent("store89-admin:repairVehicle", function()
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:repairVehicle", src)
end)

RegisterNetEvent("store89-admin:cleanVehicle", function()
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:cleanVehicle", src)
end)

RegisterNetEvent("store89-admin:flipVehicle", function()
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:flipVehicle", src)
end)

RegisterNetEvent("store89-admin:deleteAllVehicles", function()
    local src = source

    if not HasPermission(src) then
        return
    end

    TriggerClientEvent("store89-admin:deleteAllVehicles", -1)

    Notify(src, "All vehicles have been deleted.", "success")
end)
