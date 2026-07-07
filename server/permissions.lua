local ESX = exports["es_extended"]:getSharedObject()

Store89 = Store89 or {}

function Store89.HasPermission(source)
    if source == 0 then
        return true
    end

    if IsPlayerAceAllowed(source, "store89.admin") then
        return true
    end

    return false
end

lib.callback.register("store89-admin:hasPermission", function(source)
    return Store89.HasPermission(source)
end)