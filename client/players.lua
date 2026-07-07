SelectedPlayer = nil

RegisterNetEvent("store89-admin:selectPlayer", function(id)
    SelectedPlayer = id
end)

function GetSelectedPlayer()
    return SelectedPlayer
end