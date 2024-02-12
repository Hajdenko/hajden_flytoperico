ESX = exports["es_extended"]:getSharedObject()

lib.callback.register('hajden_flytocayo:pay', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        local price = 1000
        local xPlayerMoney = xPlayer.getMoney()

        if xPlayerMoney >= price then
            lib.callback('hajden_flytocayo:flyperico', source, function() xPlayer.removeMoney(price) end)
            return price
        else
            TriggerClientEvent('okokNotify:Alert', source, "Fly to Cayo Perico", "You don't have enough money.", 5000, 'error', true)
        end

        return false
    else
        return false
    end
end)