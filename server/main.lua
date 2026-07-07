ESX = exports["es_extended"]:getSharedObject()

lib.callback.register("store89-admin:getPlayers", function(source)

    local players = {}

    for _, playerId in ipairs(GetPlayers()) do

        local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))

        if xPlayer then

            table.insert(players, {
                id = xPlayer.source,
                name = xPlayer.getName(),
                job = xPlayer.job.name,
                jobLabel = xPlayer.job.label,
                ping = GetPlayerPing(xPlayer.source)
            })
        end
    end

    table.sort(players, function(a, b)
        return a.id < b.id
    end)

    return players
end)
-- =====================================================
-- Store89 Admin - Core Functions
-- =====================================================

local function HasPermission(src)
    if Store89 and Store89.HasPermission then
        return Store89.HasPermission(src)
    end

    return IsPlayerAceAllowed(src, "store89.admin")
end

local function GetPlayer(target)
    target = tonumber(target)

    if not target then
        return nil
    end

    return ESX.GetPlayerFromId(target)
end

local function Notify(src, message, type)
    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Store89 Admin',
        description = message,
        type = type or 'inform'
    })
end

RegisterNetEvent("store89-admin:kickPlayer", function(target, reason)

    local src = source

    if not HasPermission(src) then return end

    target = tonumber(target)

    if not GetPlayerName(target) then
        Notify(src, "Player not found", "error")
        return
    end

    DropPlayer(target, reason or "Kicked by Staff")

end)

RegisterNetEvent("store89-admin:bringPlayer", function(target)

    local src = source

    if not HasPermission(src) then return end

    local adminPed = GetPlayerPed(src)

    if adminPed == 0 then return end

    local coords = GetEntityCoords(adminPed)

    TriggerClientEvent("store89-admin:teleport", tonumber(target), coords)

end)

RegisterNetEvent("store89-admin:gotoPlayer", function(target)

    local src = source

    if not HasPermission(src) then return end

    local ped = GetPlayerPed(tonumber(target))

    if ped == 0 then return end

    local coords = GetEntityCoords(ped)

    TriggerClientEvent("store89-admin:teleport", src, coords)

end)

RegisterNetEvent("store89-admin:healPlayer", function(target)

    if not HasPermission(source) then return end

    TriggerClientEvent("store89-admin:heal", tonumber(target))

end)

RegisterNetEvent("store89-admin:revivePlayer", function(target)

    if not HasPermission(source) then return end

    TriggerClientEvent("store89-admin:revive", tonumber(target))

end)

RegisterNetEvent("store89-admin:freezePlayer", function(target, state)

    if not HasPermission(source) then return end

    TriggerClientEvent("store89-admin:freeze", tonumber(target), state)

end)

RegisterNetEvent("store89-admin:killPlayer", function(target)

    if not HasPermission(source) then return end

    TriggerClientEvent("store89-admin:kill", tonumber(target))

end)