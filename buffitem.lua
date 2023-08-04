--- GALAXYDEV
local BUFF_DURATION = 10 * 1000 -- 10 segundos (el valor está en milisegundos)
local CONDITIONID_HASTE = 1000 -- Puedes cambiar este valor si no está en uso

function applyBuff(cid)
    -- Si el jugador ya tiene la mejora, no se otorga una nueva.
    if getCreatureCondition(cid, CONDITIONID_HASTE, CONDITIONID_HASTE) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Ya tienes la mejora activa.")
        return
    end

    -- Aplica la mejora de vida, maná y habilidades.
    doCreatureAddHealth(cid, 200) -- Aumenta 200 puntos de vida.
    doCreatureAddMana(cid, 100)   -- Aumenta 100 puntos de maná.
    doPlayerAddSkillTry(cid, SKILL_FIST, 50) -- Aumenta 50 intentos de habilidad de puño.
    doPlayerAddSkillTry(cid, SKILL_SWORD, 50) -- Aumenta 50 intentos de habilidad de espada.
    doPlayerAddSkillTry(cid, SKILL_AXE, 50) -- Aumenta 50 intentos de habilidad de hacha.

    -- Crea una condición que removerá los efectos de la mejora después del tiempo de duración.
    addEvent(function()
        if isCreature(cid) then
            local conditions = getCreatureConditions(cid)
            local hasHasteCondition = false
            for _, condition in ipairs(conditions) do
                if condition.conditionType == CONDITIONID_HASTE then
                    hasHasteCondition = true
                    break
                end
            end

            if hasHasteCondition then
                doRemoveCondition(cid, CONDITIONID_HASTE)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "La mejora ha desaparecido.")
            end
        end
    end, BUFF_DURATION)

    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "¡Has recibido una mejora de vida, maná y habilidades por 10 segundos!")
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    applyBuff(cid)
    return true
end




---- Abre el archivo data/actions/scripts/custom.lua en un editor de texto o en tu entorno de desarrollo.
--- copia y pega el codigo. pon el nombre que te guste .lua
--- abre actions.xml
--- agrega : <action itemid="TU_ID_DEL_OBJETO" script="carpeta/custom.lua" />
--- Reemplaza TU_ID_DEL_OBJETO por el ID numérico del objeto que quieres usar para otorgar la mejora.
