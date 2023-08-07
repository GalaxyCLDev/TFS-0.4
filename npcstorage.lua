local requiredStorages = {
    {id = 1001, message = "la primera misión"},
    {id = 1002, message = "la segunda misión"},
    {id = 1003, message = "la tercera misión"},
    {id = 1004, message = "la cuarta misión"},
    {id = 1005, message = "la quinta misión"}
}

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    if msg:lower() == "hi" then
        local missingStorages = getMissingStorages(cid, requiredStorages)
        if #missingStorages == 0 then
            selfSay("¡Hola, |PLAYERNAME|! Bienvenido. Aquí tienes un pequeño obsequio.", cid)
            doPlayerAddItem(cid, 2140, 1) -- Agregar un ítem al jugador (ID 2140)
        else
            local message = "Lo siento, pero necesitas completar "
            for i, storage in ipairs(missingStorages) do
                if i == #missingStorages then
                    message = message .. storage.message .. " antes de hablar conmigo."
                else
                    message = message .. storage.message .. ", "
                end
            end
            selfSay(message, cid)
        end
    end
end

function getMissingStorages(cid, storages)
    local missingStorages = {}
    for _, storage in ipairs(storages) do
        if getPlayerStorageValue(cid, storage.id) ~= 1 then
            table.insert(missingStorages, storage)
        end
    end
    return missingStorages
end

function onPlayerCloseChannel(cid)
end

function onPlayerEndTrade(cid)
end

function onThink()
end
