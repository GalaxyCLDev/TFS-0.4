local storageRequerido = 1000
local SKILL_HABILIDAD_MEJORAR = SKILL_SWORD -- Cambiar por la habilidad que desees mejorar
local SKILL_PUNTOS_A_AGREGAR = 5 -- Cantidad de puntos que se agregarán a la habilidad

function onStepIn(cid, item, pos)
    if item.itemid == 2579 then --- item que es el piso
        if not isPlayer(cid) then
            return true
        end

        local hasStorage = getPlayerStorageValue(cid, storageRequerido)
        if hasStorage == 1 then
            doPlayerAddSkillTry(cid, SKILL_HABILIDAD_MEJORAR, SKILL_PUNTOS_A_AGREGAR)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Has mejorado tu habilidad por entrar a zona vip!")
       --     doTargetCombatHealth(0, cid, COMBAT_PHYSICALDAMAGE, -15, -30, CONST_ME_NONE) -- esto quita vida
            doTransformItem(item.uid, item.itemid - 1)
        else
            doPlayerSendCancel(cid, "You need to complete a mission to pass.")
        end
    else
        if isPlayer(cid) then
       --     doTargetCombatHealth(0, cid, COMBAT_PHYSICALDAMAGE, -50, -100, CONST_ME_NONE) -- esto quita vida
            doTransformItem(item.uid, item.itemid + 1)
        end
    end
    return true
end
