local storageRequerido = 1000
local SKILL_HABILIDAD_MEJORAR = SKILL_SWORD -- Cambiar por la habilidad que desees mejorar
local SKILL_PUNTOS_A_AGREGAR = 5 -- Cantidad de puntos que se agregarán a la habilidad
local EFECTOALPISAR = 10 -- Cambiar por el efecto deseado (ver lista de efectos)


function onStepIn(cid, item, pos)


        local hasStorage = getPlayerStorageValue(cid, storageRequerido)
        if hasStorage == 1 then
            doPlayerAddSkillTry(cid, SKILL_HABILIDAD_MEJORAR, SKILL_PUNTOS_A_AGREGAR)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Ganaste Sword al pasar")
            doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
            doPlayerAddMana(cid, getCreatureMaxMana(cid))
            doTransformItem(item.uid, item.itemid - 1)
        else
            doPlayerSendCancel(cid, "Necesitas tener un storage para pasar")
            return false -- Evita que el jugador pase si no tiene el storage requerido
        end

        doSendMagicEffect(getCreaturePosition(cid), EFECTOALPISAR)

    return true
end
