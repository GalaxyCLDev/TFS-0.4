local fragStorage = 1234 -- Identificación de almacenamiento para jugadores asesinos (almacenamiento para el jugador matador)
local skulls = { -- skulls ids
	[1] = {frags = 10}, -- id 1 para yellow skull
	[2] = {frags = 25}, -- id 2 para green skull
	[3] = {frags = 50}, -- id 3 para white skull
	[4] = {frags = 100} -- id 4 para red skull
}

function onDeath(cid, corpse, lastHitKiller, mostDamageKiller)
	if isPlayer(cid) == true then -- Comprueba si la criatura muerta es un jugador.
		local frags = getPlayerStorageValue(cid, fragStorage) + 1
		setPlayerStorageValue(cid, fragStorage, frags)

		for i = 1, #skulls do
			if frags >= skulls[i].frags then
				doCreatureSetSkullType(cid, i)
			end
		end
	end
	return true
end
