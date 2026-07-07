local MenuOpen = false

function OpenAdminMenu(data)
    if MenuOpen then return end

    MenuOpen = true

    SetNuiFocus(true, true)

    if Config.UI.Blur then
        TriggerScreenblurFadeIn(250)
    end

    SendNUIMessage({
        action = "open",
        player = data.player,
        players = data.players
    })
end

function CloseAdminMenu()
    if not MenuOpen then return end

    MenuOpen = false

    SetNuiFocus(false, false)

    if Config.UI.Blur then
        TriggerScreenblurFadeOut(250)
    end

    SendNUIMessage({
        action = "close"
    })
end

RegisterNUICallback("close", function(_, cb)
    CloseAdminMenu()
    cb("ok")
end)

RegisterNUICallback("playerAction", function(data, cb)
    TriggerServerEvent("store89-admin:playerAction", data)
    cb("ok")
end)

RegisterNUICallback("worldAction", function(data, cb)
    TriggerServerEvent("store89-admin:worldAction", data)
    cb("ok")
end)