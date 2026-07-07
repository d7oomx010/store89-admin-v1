Store89 = {}

----------------------------------------------------------
-- Notifications
----------------------------------------------------------

function Store89.Notify(title, description, type)

    lib.notify({

        title = title,

        description = description,

        type = type

    })

end

----------------------------------------------------------
-- Teleport
----------------------------------------------------------

function Store89.Teleport(coords)

    local ped = PlayerPedId()

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

end

----------------------------------------------------------
-- Freeze
----------------------------------------------------------

function Store89.Freeze(state)

    FreezeEntityPosition(PlayerPedId(), state)

end

----------------------------------------------------------
-- Revive
----------------------------------------------------------

function Store89.Revive()

    local ped = PlayerPedId()

    NetworkResurrectLocalPlayer(

        GetEntityCoords(ped),

        GetEntityHeading(ped),

        true,

        false

    )

    ClearPedBloodDamage(ped)

    SetEntityHealth(ped, 200)

end

----------------------------------------------------------
-- Heal
----------------------------------------------------------

function Store89.Heal()

    SetEntityHealth(PlayerPedId(),200)

end

----------------------------------------------------------
-- Close Menu
----------------------------------------------------------

function Store89.Close()

    SetNuiFocus(false,false)

    TriggerScreenblurFadeOut(300)

    SendNUIMessage({

        action="close"

    })

end

----------------------------------------------------------
-- Open Menu
----------------------------------------------------------

function Store89.Open(data)

    SetNuiFocus(true,true)

    TriggerScreenblurFadeIn(300)

    SendNUIMessage({

        action="open",

        player=data.player,

        players=data.players

    })

end