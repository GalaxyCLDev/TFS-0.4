local STORAGE_REQUIRED = 1000 -- Cambiar por el valor deseado para el storage
local COOLDOWN_TIME = 86400 -- 1 día en segundos
local MESSAGE_FREQUENCY = 60 -- Cada 60 segundos (1 minuto) se enviará un mensaje

function sendCooldownMessage(cid, remainingTime)
    local remainingDays = math.ceil(remainingTime / 86400)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "NECESITAS ESPERAR " .. remainingDays .. " DIAS PARA VOLVER A USAR EL ITEM")
end

function onUse(cid, item, fromPosition, itemEx, toPosition)

    -- Verificar si el jugador ya tiene el storage y si ha pasado el tiempo de enfriamiento
    local lastTimeUsed = getPlayerStorageValue(cid, STORAGE_REQUIRED)
    if lastTimeUsed == 1 then
        local currentTime = os.time()
        local diffTime = currentTime - lastTimeUsed
        if diffTime < COOLDOWN_TIME then
            local remainingTime = COOLDOWN_TIME - diffTime
            sendCooldownMessage(cid, remainingTime)

            return true
        end
    end

    -- Verificar que el jugador cumpla con los requisitos para obtener el storage
    -- Agrega aquí las comprobaciones adicionales necesarias
    -- Por ejemplo, verifica si el jugador ha completado una misión

    -- Si el jugador cumple con los requisitos, otorgar el storage y restar el item
    setPlayerStorageValue(cid, STORAGE_REQUIRED, os.time()) -- Almacenar el tiempo actual como el último momento de uso
    doRemoveItem(item.uid, 1)

    -- Puedes agregar un mensaje para informar al jugador que ha obtenido el storage
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "EL JUGADOR OBTIENE EL MENSAJE DE CONSEGUIDO EL STORAGE")

    -- Programar un evento para eliminar el storage después de COOLDOWN_TIME segundos
    addEvent(function()
        setPlayerStorageValue(cid, STORAGE_REQUIRED, -1) -- Eliminar el storage al final del tiempo de enfriamiento
    end, COOLDOWN_TIME * 1000)

    return true
end

function onThink(cid, interval)
    -- Verificar si el jugador tiene el storage y si ha pasado el tiempo de enfriamiento
    local lastTimeUsed = getPlayerStorageValue(cid, STORAGE_REQUIRED)
    if lastTimeUsed == 1 then
        local currentTime = os.time()
        local diffTime = currentTime - lastTimeUsed
        if diffTime < COOLDOWN_TIME then
            local remainingTime = COOLDOWN_TIME - diffTime

            -- Enviar un mensaje periódicamente con el tiempo restante (cada MESSAGE_FREQUENCY segundos)
            if remainingTime % MESSAGE_FREQUENCY == 0 then
                sendCooldownMessage(cid, remainingTime)
            end
        end
    end
end
