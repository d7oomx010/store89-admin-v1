local panelOpen = false

RegisterCommand("store89_admin", function()

    local hasPermission = lib.callback.await("store89-admin:hasPermission", false)

    if not hasPermission then
        lib.notify({
            title = "Store89",
            description = "ليس لديك صلاحية لفتح لوحة الإدارة.",
            type = "error"
        })
        return
    end

    panelOpen = not panelOpen

    if panelOpen then

        local players = lib.callback.await("store89-admin:getPlayers", false)

        SetNuiFocus(true, true)

        TriggerScreenblurFadeIn(300)

        SendNUIMessage({

            action = "open",

            player = {

                id = GetPlayerServerId(PlayerId()),
                name = GetPlayerName(PlayerId())

            },

            players = players

        })

    else

        SetNuiFocus(false, false)

        TriggerScreenblurFadeOut(300)

        SendNUIMessage({

            action = "close"

        })

    end

end)

RegisterKeyMapping(
    "store89_admin",
    "Store89 Admin Panel",
    "keyboard",
    "F9"
)

RegisterNUICallback("close", function(_, cb)

    panelOpen = false

    SetNuiFocus(false, false)

    TriggerScreenblurFadeOut(300)

    SendNUIMessage({

        action = "close"

    })

    cb("ok")

end)
-- ==========================================
-- Store89 Admin Client Events
-- ==========================================

RegisterNetEvent("store89-admin:teleport", function(coords)

    if not coords then return end

    local ped = PlayerPedId()

    DoScreenFadeOut(300)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    SetEntityCoords(
        ped,
        coords.x,
        coords.y,
        coords.z,
        false,
        false,
        false,
        false
    )

    Wait(500)

    DoScreenFadeIn(300)

end)

RegisterNetEvent("store89-admin:heal", function()

    local ped = PlayerPedId()

    SetEntityHealth(ped, GetEntityMaxHealth(ped))

    ClearPedBloodDamage(ped)

    ClearPedTasksImmediately(ped)

    lib.notify({
        title = "Store89",
        description = "تم علاجك.",
        type = "success"
    })

end)

RegisterNetEvent("store89-admin:revive", function()

    local ped = PlayerPedId()

    NetworkResurrectLocalPlayer(
        GetEntityCoords(ped),
        GetEntityHeading(ped),
        true,
        false
    )

    SetEntityHealth(ped, GetEntityMaxHealth(ped))

    ClearPedBloodDamage(ped)

    lib.notify({
        title = "Store89",
        description = "تم إحياؤك.",
        type = "success"
    })

end)

RegisterNetEvent("store89-admin:freeze", function(state)

    FreezeEntityPosition(PlayerPedId(), state)

    lib.notify({
        title = "Store89",
        description = state and "تم تجميدك." or "تم فك التجميد.",
        type = "inform"
    })

end)

RegisterNetEvent("store89-admin:kill", function()

    SetEntityHealth(PlayerPedId(), 0)

end)

RegisterNUICallback("getPlayers", function(_, cb)

    local players = lib.callback.await("store89-admin:getPlayers", false)

    cb(players)

end)

RegisterNUICallback("kickPlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:kickPlayer",
        data.id,
        data.reason
    )

    cb("ok")

end)

RegisterNUICallback("bringPlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:bringPlayer",
        data.id
    )

    cb("ok")

end)

RegisterNUICallback("gotoPlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:gotoPlayer",
        data.id
    )

    cb("ok")

end)

RegisterNUICallback("healPlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:healPlayer",
        data.id
    )

    cb("ok")

end)

RegisterNUICallback("revivePlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:revivePlayer",
        data.id
    )

    cb("ok")

end)

RegisterNUICallback("freezePlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:freezePlayer",
        data.id,
        data.state
    )

    cb("ok")

end)

RegisterNUICallback("killPlayer", function(data, cb)

    TriggerServerEvent(
        "store89-admin:killPlayer",
        data.id
    )

    cb("ok")

end)
RegisterNUICallback("playerAction", function(data, cb)

    if not data.target then
        cb("ok")
        return
    end

    if data.action == "goto" then
        TriggerServerEvent("store89-admin:gotoPlayer", data.target)

    elseif data.action == "bring" then
        TriggerServerEvent("store89-admin:bringPlayer", data.target)

    elseif data.action == "heal" then
        TriggerServerEvent("store89-admin:healPlayer", data.target)

    elseif data.action == "revive" then
        TriggerServerEvent("store89-admin:revivePlayer", data.target)

    elseif data.action == "freeze" then
        TriggerServerEvent("store89-admin:freezePlayer", data.target, true)

    elseif data.action == "kick" then
        TriggerServerEvent("store89-admin:kickPlayer", data.target)

    elseif data.action == "spectate" then
        TriggerServerEvent("store89-admin:spectatePlayer", data.target)

    end

    cb("ok")

end)