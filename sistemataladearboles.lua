function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- Verificar si el ítem utilizado es un hacha de madera (ID 2001)
    if item.itemid == 2380 then
        -- Verificar si el objeto objetivo es un árbol (ID 1001)
        if itemEx.itemid == 2703 then
            -- Iniciar el proceso de tala del árbol

            -- Aquí puedes poner el código para el proceso de tala
            -- Por ejemplo, eliminar el árbol y otorgar recompensas al jugador
            -- (madera, experiencia, etc.)

            return true
        end
    end

    return false
end
