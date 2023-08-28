local isRunning = {}

local monstros = {"Demon", "Triple Medusa"}
local messages = {
    "Hora de matar!",
    "Ha llegado tu hora...",
    "Pensaste que iba a pelear solo?",
    "No dejaremos que mates a nuestro jefesito!",
    "Me gusta el pan con palta!",
}

local pos = {x = 104, y = 572, z = 7}

local config = {
    maxPorcentaje = 20,
    segundos = 10,  -- Cambiar el valor para pruebas más rápidas
    mostrarMsgs = true,
}

local function crearMonster(monstruo)
    for i = 1, #monstros do
        local newMonster = doCreateMonster(monstros[i], pos)
        doSendMagicEffect(getCreaturePosition(newMonster), CONST_ME_TELEPORT)
        doCreatureSay(newMonster, messages[math.random(1, #messages)], TALKTYPE_SAY)
    end

    if config.mostrarMsgs then
        print("Monstruo creado.")
    end

    isRunning[monstruo] = false
end

function onStatsChange(cid, attacker, type, combat, value)
    if isMonster(cid) and isPlayer(attacker) then
        local hpPorcentaje = (getCreatureHealth(cid) / getCreatureMaxHealth(cid)) * 100
        if hpPorcentaje < config.maxPorcentaje and not isRunning[cid] then
            if config.mostrarMsgs then
                print("Enviando addEvent...")
            end
            isRunning[cid] = true
            addEvent(crearMonster, config.segundos * 1000, cid)
        end
    end
    return true
end
