local fragsFolder = "data/player_frags/"
local skulls = {
    [1] = {frags = 10, skullName = "yellow skull"},
    [2] = {frags = 25, skullName = "green skull"},
    [3] = {frags = 50, skullName = "white skull"},
    [4] = {frags = 100, skullName = "red skull"}
}

function onDeath(cid, corpse, lastHitKiller, mostDamageKiller)
    if isPlayer(cid) == true then
        local playerId = getPlayerGUID(cid)
        local fragsFile = io.open(fragsFolder .. playerId .. ".txt", "r")

        local currentFrags = 0
        if fragsFile then
            currentFrags = tonumber(fragsFile:read("*n"))
            io.close(fragsFile)
        end

        local newFrags = currentFrags + 1
        fragsFile = io.open(fragsFolder .. playerId .. ".txt", "w")
        fragsFile:write(newFrags)
        io.close(fragsFile)

        for i = 1, #skulls do
            if newFrags >= skulls[i].frags and currentFrags < skulls[i].frags then
                doCreatureSetSkullType(cid, i)
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una nueva calavera: " .. skulls[i].skullName .. "!")
            end
        end

        -- Aquí agregamos las recompensas cuando el jugador alcance ciertas cantidades de frags
        if newFrags == 50 then
            doPlayerAddItem(cid, 2140, 1) -- Añadir 1 Crystal Coin (2140)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una Crystal Coin (2140) como recompensa por alcanzar 50 frags!")
        elseif newFrags == 75 then
            doPlayerAddItem(cid, 2366, 1) -- Añadir 1 Platinum Coin (2366)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una Platinum Coin (2366) como recompensa por alcanzar 75 frags!")
        elseif newFrags == 100 then
            doPlayerAddItem(cid, 2160, 1) -- Añadir 1 Crystal Arrow (2160)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "¡Has obtenido una Crystal Arrow (2160) como recompensa por alcanzar 100 frags!")
        end

        -- Pérdida de 1 frag al morir
        if currentFrags > 0 then
            newFrags = math.max(newFrags - 1, 0)

            fragsFile = io.open(fragsFolder .. playerId .. ".txt", "w")
            fragsFile:write(newFrags)
            io.close(fragsFile)

            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Perdiste 1 frag por morir.")
        end
    end
    return true
end




--- Crea una carpeta llamada player_frags dentro de "data"

---- navega hasta la carpeta data/creaturescripts/scripts.
--- Crea un nuevo archivo de texto y nómbralo COMO TU QUIERAS (ejemplo.lua)
--- abres el archivo que creaste y pegas el codigo. Guardas y listo

---- navega hasta la carpeta data/creaturescripts y abre el archivo creaturescripts.xml con un editor de texto.

---- Agrega la siguiente línea dentro de la sección <event-scripts> del archivo creaturescripts.xml: 
--- <event type="death" name="addSkullForFrags" event="script" value="data/creaturescripts/scripts/deathSkulls.lua"/>

---- abre el archivo login.lua ubicado en data/creaturescripts/scripts.
---- Agrega la siguiente línea al final del archivo login.lua: registerCreatureEvent(cid, "addSkullForFrags")
--- registerCreatureEvent(cid, "addSkullForFrags")

---- CREADO POR GALAXYDEV TFS 0.4 02-08-2023

