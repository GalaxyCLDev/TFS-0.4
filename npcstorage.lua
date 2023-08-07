local REQUIRED_STORAGE = 1001 -- Cambia este valor al storage que desees usar

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    if msg == "hi" then
        if getPlayerStorageValue(cid, REQUIRED_STORAGE) == 1 then
            selfSay("Hola! ¿En qué puedo ayudarte?", cid)
        else
            selfSay("Hola! Lamento decirte que necesitas completar una misión antes de que pueda hablar contigo.", cid)
        end
    end
end

function onPlayerCloseChannel(cid)
end

function onPlayerEndTrade(cid)
end

function onThink()
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    if getDistanceTo(cid, toPosition) > 3 then
        return false
    end
    
    if getPlayerStorageValue(cid, REQUIRED_STORAGE) == 1 then
        if getPlayerItemCount(cid, 2140) == 0 then
            doPlayerAddItem(cid, 2140, 1)
            selfSay("Aquí tienes un regalo! ¡Disfrútalo!", cid)
        else
            selfSay("Ya tienes uno, no puedo darte más.", cid)
        end
    else
        selfSay("Lo siento, ¡necesitas completar una misión primero!", cid)
    end
end
