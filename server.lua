ESX = exports['es_extended']:getSharedObject()


-- Este script no necesita hacer mucho en el server, todo se maneja en client
-- Pero si quieres loggear headshots puedes usar esto

RegisterNetEvent('ps_antitank:logHeadshot')
AddEventHandler('ps_antitank:logHeadshot', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    print('[PS_ANTITANK] ' .. xPlayer.getName() .. ' recibió un disparo a la cabeza.')
end)
