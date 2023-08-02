local BUFF_DURATION = 10 * 1000 -- 10 segundos (el valor está en milisegundos)

function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- Si el jugador ya tiene la mejora, no se otorga una nueva.
    if getPlayerCondition(cid, CONDITION_CUSTOM, CONDITIONID_HASTE) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Ya tienes la mejora activa.")
        return true
    end

    -- Aplica la mejora de vida, maná y habilidades.
    doPlayerAddHealth(cid, 200) -- Aumenta 200 puntos de vida.
    doPlayerAddMana(cid, 100)   -- Aumenta 100 puntos de maná.
    doPlayerAddSkillTry(cid, SKILL_FIST, 50) -- Aumenta 50 intentos de habilidad de puño.
    doPlayerAddSkillTry(cid, SKILL_SWORD, 50) -- Aumenta 50 intentos de habilidad de espada.
    doPlayerAddSkillTry(cid, SKILL_AXE, 50) -- Aumenta 50 intentos de habilidad de hacha.

    -- Crea una condición que removerá los efectos de la mejora después del tiempo de duración.
    local condition = {type = CONDITION_CUSTOM, subtype = CONDITIONID_HASTE, ticks = BUFF_DURATION}
    doAddCondition(cid, condition)

    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "¡Has recibido una mejora de vida, maná y habilidades por 10 segundos!")

    return true
end

function onDeath(cid, corpse, deathList)
    -- Elimina la condición de mejora cuando el jugador muere.
    doRemoveCondition(cid, CONDITION_CUSTOM, CONDITIONID_HASTE)
    return true
end


---- Abre el archivo data/actions/scripts/custom.lua en un editor de texto o en tu entorno de desarrollo.
--- copia y pega el codigo. pon el nombre que te guste .lua
--- abre actions.xml
--- agrega : <action itemid="TU_ID_DEL_OBJETO" script="carpeta/custom.lua" />
--- Reemplaza TU_ID_DEL_OBJETO por el ID numérico del objeto que quieres usar para otorgar la mejora.
