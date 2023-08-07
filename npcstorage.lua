local requiredStorages = {1000, 1001, 1002, 1003, 1004} -- Lista de storages requeridos

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    if msg == "hi" then
        local missingStorages = {}
        for _, storage in ipairs(requiredStorages) do
            if getPlayerStorageValue(cid, storage) ~= 1 then
                table.insert(missingStorages, storage)
            end
        end
        
        if #missingStorages == 0 then
            selfSay("¡Hola, " .. getCreatureName(cid) .. "! ¡Bienvenido!")
            -- Aquí puedes agregar el código para otorgar el item al jugador
        else
            local missingStorageNames = {}
            for _, storage in ipairs(missingStorages) do
                table.insert(missingStorageNames, "Storage " .. storage)
            end
            local missingStorageList = table.concat(missingStorageNames, ", ")
            selfSay("¡Hola, " .. getCreatureName(cid) .. "! Para hablar conmigo, necesitas completar los siguientes storages: " .. missingStorageList)
        end
    end
end

function onPlayerCloseChannel(cid)
end

function onPlayerEndTrade(cid)
end

function onThink()
end
