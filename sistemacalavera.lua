local StorageporMuerte = 1234 -- Identificación de almacenamiento para jugadores asesinos (almacenamiento para el jugador matador)
local skulls = { -- skulls ids
	[1] = {frags = 10}, -- id 1 para yellow skull
	[2] = {frags = 25}, -- id 2 para green skull
	[3] = {frags = 50}, -- id 3 para white skull
	[4] = {frags = 100} -- id 4 para red skull
}

function onDeath(cid, corpse, lastHitKiller, mostDamageKiller)
	if isPlayer(cid) == true then -- Comprueba si la criatura muerta es un jugador.
		local frags = getPlayerStorageValue(cid, StorageporMuerte) + 1
		setPlayerStorageValue(cid, StorageporMuerte, frags)

		for i = 1, #skulls do
			if frags >= skulls[i].frags then
				doCreatureSetSkullType(cid, i)
			end
		end
	end
	return true
end


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

