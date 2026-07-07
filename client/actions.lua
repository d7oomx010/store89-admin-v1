RegisterNetEvent("store89-admin:goto", function(coords)

    local ped = PlayerPedId()

    SetEntityCoords(
        ped,
        coords.x,
        coords.y,
        coords.z
    )

end)

RegisterNetEvent("store89-admin:bring", function(coords)

    local ped = PlayerPedId()

    SetEntityCoords(
        ped,
        coords.x,
        coords.y,
        coords.z
    )

end)

RegisterNetEvent("store89-admin:freeze", function()

    local ped = PlayerPedId()

    FreezeEntityPosition(
        ped,
        not IsEntityPositionFrozen(ped)
    )

end)

RegisterNetEvent("store89-admin:heal", function()

    local ped = PlayerPedId()

    SetEntityHealth(
        ped,
        GetEntityMaxHealth(ped)
    )

end)

RegisterNetEvent("store89-admin:revive", function()

    local ped = PlayerPedId()

    NetworkResurrectLocalPlayer(
        GetEntityCoords(ped),
        GetEntityHeading(ped),
        true,
        false
    )

    SetEntityHealth(
        ped,
        GetEntityMaxHealth(ped)
    )

end)