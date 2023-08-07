function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- ID del hacha para talar
    local HACHA_TALAR_ID = 2380

    -- IDs de los árboles a considerar
    local ARBOLES_TALAR = {2703, 2705, 2710, 2711, 2700}

    -- Verificar si el ítem utilizado es el hacha de talar
    if item.itemid == HACHA_TALAR_ID then
        -- Verificar si el objeto objetivo es un árbol para talar
        if isInArray(ARBOLES_TALAR, itemEx.itemid) then
            -- Iniciar el proceso de tala del árbol

            -- Aquí puedes poner el código para el proceso de tala
            -- Por ejemplo, eliminar el árbol y otorgar recompensas al jugador
            -- (madera, experiencia, etc.)

            return true
        end
    end

    return false
end
