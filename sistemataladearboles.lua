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

                -- Verificar y actualizar el nivel del jugador
                local playerGUID = getPlayerGUID(cid)
                local treesCut = db.getResult("SELECT trees_cut FROM player_tree_cutting_stats WHERE player_id = " .. playerGUID):getDataInt("trees_cut")

                local nextLevelTrees = 0
                local nextLevel = 0

                if treesCut >= 100 and treesCut < 250 then
                    nextLevelTrees = 250
                    nextLevel = 2
                elseif treesCut >= 250 and treesCut < 500 then
                    nextLevelTrees = 500
                    nextLevel = 3
                -- Agrega más niveles según sea necesario
                end

                if nextLevel > 0 then
                    db.executeQuery("UPDATE player_tree_cutting_stats SET tree_cutting_level = " .. nextLevel .. ", next_level_trees = " .. nextLevelTrees .. " WHERE player_id = " .. playerGUID)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "¡Has subido al nivel " .. nextLevel .. " de tala de árboles!")
                end

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

---- TABLA DE BASE DE DATOS QUE DEBES CREAR ----

CREATE TABLE `player_tree_cutting_stats`
(
    `player_id` INT NOT NULL,
    `trees_cut` INT NOT NULL DEFAULT 0,
    `tree_cutting_level` TINYINT(1) NOT NULL DEFAULT 1,
    `next_level_trees` INT NOT NULL DEFAULT 100,
    PRIMARY KEY (`player_id`),
    FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

