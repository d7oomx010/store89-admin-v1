local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("store89-admin:playerAction", function(data)

    local src = source

    if not data then return end

    local target = tonumber(data.target)

    if not target or GetPlayerPing(target) == 0 then
        return
    end

    local action = data.action

    if action == "goto" then

        local targetPed = GetPlayerPed(target)

        if targetPed == 0 then return end

        local coords = GetEntityCoords(targetPed)

        TriggerClientEvent("store89-admin:goto", src, coords)

    elseif action == "bring" then

        local adminPed = GetPlayerPed(src)

        if adminPed == 0 then return end

        local coords = GetEntityCoords(adminPed)

        TriggerClientEvent("store89-admin:bring", target, coords)

    elseif action == "freeze" then

        TriggerClientEvent("store89-admin:freeze", target)

    elseif action == "heal" then

        TriggerClientEvent("store89-admin:heal", target)

    elseif action == "revive" then

        TriggerClientEvent("store89-admin:revive", target)

    elseif action == "kick" then

        DropPlayer(target, "تم طردك بواسطة الإدارة")

    end

end)