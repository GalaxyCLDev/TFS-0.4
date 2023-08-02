local skullStorage = 1234 -- ID de storage para el contador de calaveras del jugador
local skullTypeStorage = 5678 -- ID de storage para el tipo de calavera del jugador
local skulls = {
    {frags = 1, skullType = SKULL_YELLOW}, -- 1 frag para calavera amarilla
    {frags = 3, skullType = SKULL_GREEN},  -- 3 frags para calavera verde
    {frags = 5, skullType = SKULL_WHITE},  -- 5 frags para calavera blanca
    {frags = 10, skullType = SKULL_RED}    -- 10 frags para calavera roja
}

function onKill(player, target)
    if isPlayer(player) and isPlayer(target) then
        local playerFrags = getCreatureStorage(player, skullStorage)
        local newFrags = playerFrags + 1
        doCreatureSetStorage(player, skullStorage, newFrags)

        for i = #skulls, 1, -1 do
            if newFrags >= skulls[i].frags and playerFrags < skulls[i].frags then
                doPlayerSetSkullType(player, skulls[i].skullType)
                doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una nueva calavera!")
            end
        end
    end
    return true
end

function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified)
    if isPlayer(player) then
        local playerFrags = getCreatureStorage(player, skullStorage)
        if playerFrags > 0 then
            doCreatureSetStorage(player, skullStorage, 0)
            doPlayerSetSkullType(player, SKULL_NONE)
            doPlayerSendTextMessage(player, MESSAGE_STATUS_WARNING, "Has perdido todos tus frags y tu calavera.")
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

