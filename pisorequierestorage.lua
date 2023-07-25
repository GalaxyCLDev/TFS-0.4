local storageRequerido = 1000

function onStepIn(cid, item, pos)
    if item.itemid == 2579 then
        if not isPlayer(cid) then
            return true
        end

        local hasStorage = getPlayerStorageValue(cid, storageRequerido)
        if hasStorage == 1 then
            doTargetCombatHealth(0, cid, COMBAT_PHYSICALDAMAGE, -15, -30, CONST_ME_NONE)
            doTransformItem(item.uid, item.itemid - 1)
        else
            doPlayerSendCancel(cid, "You need to complete a mission to pass.")
        end
    else
        if isPlayer(cid) then
            doTargetCombatHealth(0, cid, COMBAT_PHYSICALDAMAGE, -50, -100, CONST_ME_NONE)
            doTransformItem(item.uid, item.itemid + 1)
        end
    end
    return true
end
