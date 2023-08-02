local skullStorage = 1234 -- ID de storage para el contador de calaveras del jugador
local skullTypeStorage = 5678 -- ID de storage para el tipo de calavera del jugador
local skulls = {
    [1] = {kills = 1, skullType = SKULL_YELLOW}, -- 1 kill para calavera amarilla
    [2] = {kills = 3, skullType = SKULL_GREEN},  -- 3 kills para calavera verde
    [3] = {kills = 5, skullType = SKULL_WHITE},  -- 5 kills para calavera blanca
    [4] = {kills = 10, skullType = SKULL_RED}    -- 10 kills para calavera roja
}

function onKill(player, target)
    if isPlayer(player) and isPlayer(target) then
        local playerKills = getCreatureStorage(player, skullStorage)
        local newKills = playerKills + 1
        doCreatureSetStorage(player, skullStorage, newKills)

        for i = #skulls, 1, -1 do
            if newKills >= skulls[i].kills and playerKills < skulls[i].kills then
                doPlayerSetSkullType(player, skulls[i].skullType)
                doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una nueva calavera!")
            end
        end
    end
    return true
end

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified)
    if isPlayer(player) then
        local playerKills = getCreatureStorage(player, skullStorage)
        if playerKills > 0 then
            doCreatureSetStorage(player, skullStorage, 0)
            doPlayerSetSkullType(player, SKULL_NONE)
            doPlayerSendTextMessage(player, MESSAGE_STATUS_WARNING, "Has perdido todas tus kills y tu calavera.")
        end
    end
    return true
end






---- navega hasta la carpeta data/creaturescripts/scripts.
--- Crea un nuevo archivo de texto y nómbralo COMO TU QUIERAS (ejemplo.lua)
--- abres el archivo que creaste y pegas el codigo. Guardas y listo

---- navega hasta la carpeta data/creaturescripts y abre el archivo creaturescripts.xml con un editor de texto.

---- Agrega la siguiente línea dentro de la sección <event-scripts> del archivo creaturescripts.xml: 
--- <event type="kill" name="playerKillSkulls" event="script" value="playerKillSkulls.lua"/>
--- <event type="death" name="playerKillSkullsDeath" event="script" value="playerKillSkulls.lua"/>



---- abre el archivo login.lua ubicado en data/creaturescripts/scripts.
---- Agrega la siguiente línea al final del archivo login.lua:
---     registerCreatureEvent(cid, "playerKillSkulls")
---    registerCreatureEvent(cid, "playerKillSkullsDeath")

---- CREADO POR GALAXYDEV TFS 0.4 02-08-2023

