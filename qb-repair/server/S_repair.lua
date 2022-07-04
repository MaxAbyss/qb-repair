local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-repair:costRepair', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveMoney('bank', Config.Money, "repair-bill")
        TriggerEvent('qb-bossmenu:server:addAccountMoney', 'mechanic', Config.Money)
        TriggerClientEvent('QBCore:Notify', src, 'Repair Done!!', 'success')
end)
