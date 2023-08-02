local fragsFolder = "data/player_frags/"
local skulls = {
	[1] = {frags = 10}, 
	[2] = {frags = 25}, 
	[3] = {frags = 50}, 
	[4] = {frags = 100} 
}

function onDeath(cid, corpse, lastHitKiller, mostDamageKiller)
	if isPlayer(cid) == true then
		local playerId = getPlayerGUID(cid)
		local fragsFile = io.open(fragsFolder .. playerId .. ".txt", "r")
		local currentFrags = fragsFile and tonumber(fragsFile:read("*n")) or 0
		io.close(fragsFile)

		local newFrags = currentFrags + 1
		fragsFile = io.open(fragsFolder .. playerId .. ".txt", "w")
		fragsFile:write(newFrags)
		io.close(fragsFile)

		for i = 1, #skulls do
			if newFrags >= skulls[i].frags then
				doCreatureSetSkullType(cid, i)
			end
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

