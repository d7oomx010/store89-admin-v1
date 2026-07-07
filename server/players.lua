local ESX = exports["es_extended"]:getSharedObject()

lib.callback.register("store89-admin:getPlayers", function(source)

    local players = {}

    for _, playerId in pairs(GetPlayers()) do

        playerId = tonumber(playerId)

        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer then

            local cash = 0
            local bank = 0

            if xPlayer.getAccount then
                local bankAccount = xPlayer.getAccount("bank")

                if bankAccount then
                    bank = bankAccount.money
                end
            end

            if xPlayer.getMoney then
                cash = xPlayer.getMoney()
            end

            table.insert(players, {

                id = playerId,

                identifier = xPlayer.identifier,

                name = xPlayer.getName(),

                job = xPlayer.job.name,

                jobLabel = xPlayer.job.label,

                grade = xPlayer.job.grade_label,

                ping = GetPlayerPing(playerId),

                cash = cash,

                bank = bank,

                dead = false

            })

        end

    end

    table.sort(players, function(a, b)
        return a.id < b.id
    end)

    return players

end)