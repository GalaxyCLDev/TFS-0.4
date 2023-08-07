function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- ID del hacha para talar
    local HACHA_TALAR_ID = 2380

    -- IDs de los árboles a considerar
    local ARBOLES_TALAR = {2703, 2705, 2710, 2711, 2700}

    -- Verificar si el ítem utilizado es el hacha de talar
    if item.itemid == HACHA_TALAR_ID then
        -- Verificar si el objeto objetivo es un árbol para talar
        if isInArray(ARBOLES_TALAR, itemEx.itemid) then
            -- Calcular la probabilidad de éxito (puedes ajustar este valor según tu preferencia)
            local PROBABILIDAD_EXITO = 80
            if math.random(1, 100) <= PROBABILIDAD_EXITO then
                -- Árbol talado con éxito

                -- Eliminar el árbol del mapa
                doRemoveItem(itemEx.uid)

                -- Recompensas para el jugador (ejemplo: otorgar madera)
                doPlayerAddItem(cid, 1234, 5) -- ID de la madera y cantidad a otorgar

                -- Puedes agregar aquí otras recompensas, como experiencia o ítems adicionales

                -- Mensaje de éxito al jugador
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Has talado el árbol con éxito.")
            else
                -- Fallo al talar el árbol

                -- Mensaje de fallo al jugador
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Has fallado al talar el árbol.")
            end

            return true
        end
    end

    return false
end
