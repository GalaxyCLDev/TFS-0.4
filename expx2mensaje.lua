function NormalExp(cid)
    doPlayerSetExperienceRate(cid, 1)
    doPlayerSay(cid, "NORMAL EXP..", TALKTYPE_ORANGE_1)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
end

local doubleExpPlayers = {} -- Almacena los jugadores con experiencia duplicada

function activateDoubleExp(cid)
    doubleExpPlayers[cid] = true
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Exp x2!")
end

function deactivateDoubleExp(cid)
    doubleExpPlayers[cid] = nil
end

function onStepIn(cid, item, position, fromPosition)
    if isPlayer(cid) then
        if getConfigValue("experienceStages") == "yes" then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Welcome " .. getCreatureName(cid) .. ", you will now receive the experience x2 event. It will last until you log out or die.")
            activateDoubleExp(cid)
            doSendMagicEffect(getCreaturePosition(cid), CONST_ME_GIFT_WRAPS)
            doPlayerSetExperienceRate(cid, getExperienceStage(getPlayerLevel(cid)) * 0.08)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Welcome " .. getCreatureName(cid) .. ", you will now receive the experience x2 event. It will last until you log out or die.")
            activateDoubleExp(cid)
            doSendMagicEffect(getCreaturePosition(cid), CONST_ME_GIFT_WRAPS)
            doPlayerSetExperienceRate(cid, getConfigValue("rateExperience") * 0.08)
        end
    end
    return true
end

function onStepOut(cid, item, position, fromPosition)
    if doubleExpPlayers[cid] then
        deactivateDoubleExp(cid)
    end
    return true
end
