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

                -- Actualizar estadísticas de tala de árboles y otorgar recompensas adicionales
                local playerId = getPlayerGUID(cid)
                local stats = db.getResult("SELECT * FROM player_tree_cutting_stats WHERE player_id = " .. playerId)
                if stats:getID() ~= -1 then
                    local treesCut = stats:getDataInt("trees_cut")
                    local currentLevel = stats:getDataInt("tree_cutting_level")
                    local nextLevelTrees = stats:getDataInt("next_level_trees")

                    treesCut = treesCut + 1
                    db.executeQuery("UPDATE player_tree_cutting_stats SET trees_cut = " .. treesCut .. " WHERE player_id = " .. playerId)

                    -- Verificar si el jugador sube de nivel
                    if treesCut >= nextLevelTrees and currentLevel < 5 then
                        -- Subir de nivel y reiniciar estadísticas
                        local newLevel = currentLevel + 1
                        local newNextLevelTrees = nextLevelTrees + 150

                        -- Actualizar nivel en la tabla players
                        db.executeQuery("UPDATE players SET tree_cutting_level = " .. newLevel .. " WHERE id = " .. playerId)

                        -- Reiniciar estadísticas en la tabla player_tree_cutting_stats
                        db.executeQuery("UPDATE player_tree_cutting_stats SET trees_cut = 0, tree_cutting_level = " .. newLevel .. ", next_level_trees = " .. newNextLevelTrees .. " WHERE player_id = " .. playerId)

                        -- Otorgar recompensas adicionales según el nivel
                        if newLevel == 2 then
                            doPlayerAddItem(cid, 1234, 10) -- Otorgar 10 unidades de madera adicional
                        elseif newLevel == 3 then
                            doPlayerAddItem(cid, 1234, 15) -- Otorgar 15 unidades de madera adicional
                        elseif newLevel == 4 then
                            doPlayerAddItem(cid, 1234, 20) -- Otorgar 20 unidades de madera adicional
                        elseif newLevel == 5 then
                            doPlayerAddItem(cid, 1234, 25) -- Otorgar 25 unidades de madera adicional
                        end

                        -- Mensaje al jugador
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "¡Has subido al nivel " .. newLevel .. " de tala de árboles!")
                    end
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


------------------------------------ agregar en talk actions ----


-- En tu archivo commands.lua, agrega el siguiente código:

function onSay(cid, words, param)
    if param == "" then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Uso: !treeinfo")
        return true
    end

    local player = Player(cid)
    if player then
        local stats = db.getResult("SELECT * FROM player_tree_cutting_stats WHERE player_id = " .. player:getGUID())
        if stats:getID() ~= -1 then
            local treesCut = stats:getDataInt("trees_cut")
            local currentLevel = stats:getDataInt("tree_cutting_level")
            local nextLevelTrees = stats:getDataInt("next_level_trees")

            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Tala de Árboles - Nivel: " .. currentLevel)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Árboles talados: " .. treesCut)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Árboles para próximo nivel: " .. nextLevelTrees)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Aún no tienes estadísticas de tala de árboles.")
        end
    end

    return true
end





---- TABLA DE BASE DE DATOS QUE DEBES CREAR ----

ALTER TABLE `players`
ADD COLUMN `tree_cutting_level` TINYINT(1) NOT NULL DEFAULT 1;

CREATE TABLE `player_tree_cutting_stats`
(
    `player_id` INT NOT NULL,
    `trees_cut` INT NOT NULL DEFAULT 0,
    `tree_cutting_level` TINYINT(1) NOT NULL DEFAULT 1,
    `next_level_trees` INT NOT NULL DEFAULT 100,
    PRIMARY KEY (`player_id`),
    FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

