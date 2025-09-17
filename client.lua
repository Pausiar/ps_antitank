ESX = exports['es_extended']:getSharedObject()

local lastDamageTime = 0
local isInRagdoll = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local player = PlayerPedId()
        
        -- Si está en ragdoll, mantener vida mínima para evitar muerte
        if isInRagdoll then
            local health = GetEntityHealth(player)
            if health <= 100 then
                SetEntityHealth(player, 101) -- Mantener vida mínima
            end
        end

        if IsEntityDead(player) or IsPedBeingStunned(player) then
            goto continue
        end

        -- Detecta si el jugador recibe daño
        if HasEntityBeenDamagedByAnyPed(player) or HasEntityBeenDamagedByAnyVehicle(player) then
            local _, hitBone = GetPedLastDamageBone(player)
            
            -- Comprobamos si el hit fue a la cabeza (bone 31086 = cabeza)
            if hitBone == 31086 then
                local currentTime = GetGameTimer()
                -- Evita que se dispare varias veces en el mismo golpe
                if currentTime - lastDamageTime > 500 and not isInRagdoll then
                    lastDamageTime = currentTime
                    local chance = math.random(1,2)
                    
                    if chance == 1 then
                        -- Muere instantáneamente
                        SetEntityHealth(player, 0)
                    else
                        -- Ragdoll + efecto borracho SIN morir
                        isInRagdoll = true
                        
                        -- Curar al jugador para asegurar que no muera
                        local currentHealth = GetEntityHealth(player)
                        if currentHealth < 150 then
                            SetEntityHealth(player, 150)
                        end
                        
                        -- Aplicar ragdoll y efectos
                        SetPedToRagdoll(player, 4000, 4000, 0, false, false, false)
                        ShakeGameplayCam('DRUNK_SHAKE', 1.0)
                        
                        -- Opcional: logging del headshot
                        TriggerServerEvent('ps_antitank:logHeadshot')
                        
                        -- Esperar y limpiar efectos
                        Citizen.CreateThread(function()
                            Citizen.Wait(2500)
                            StopGameplayCamShaking(true)
                            isInRagdoll = false
                        end)
                    end
                end
            end
        end
        
        -- Limpiar el estado de daño para evitar detecciones múltiples
        if HasEntityBeenDamagedByAnyPed(player) then
            ClearEntityLastDamageEntity(player)
        end
        if HasEntityBeenDamagedByAnyVehicle(player) then
            ClearEntityLastDamageEntity(player)
        end
        
        ::continue::
    end
end)