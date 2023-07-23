-- NO TESTEADO CUALQUIER ERROR ABRIR UN ISSUES
function onMissFortuneAction(cid, item, fromPosition, itemEx, toPosition)
    local itemdecompra = {
        itemid = 4846, -- El ID del item que recibirás al jalar la palanca
        tokenId = 2160, -- El ID del item que se usará como "DiamantesVip" para pagar
        tokenAmount = 100 -- La cantidad necesaria de "DiamantesVip" para realizar la compra
    }

    local player = Player(cid)
    if not player then
        return true
    end

    local DiamanteVip = player:getItemCount(itemdecompra.tokenId)
    if DiamanteVip >= itemdecompra.tokenAmount then
        player:removeItem(itemdecompra.tokenId, itemdecompra.tokenAmount) -- Removemos la cantidad necesaria de "DiamantesVip"
        player:addItem(itemdecompra.itemid, 1) -- Agregamos el item al jugador (si deseas dar más de 1 item, cambia el "1" por la cantidad deseada)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Su compra fue exitosa.") -- Mensaje de compra exitosa
        fromPosition:sendMagicEffect(CONST_ME_HEARTS) -- Efecto sobre el jugador si la compra fue exitosa
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No tienes suficientes DiamantesVip.") -- Mensaje de compra fallida
        fromPosition:sendMagicEffect(CONST_ME_POFF) -- Efecto sobre el jugador si la compra fue fallida
    end

    return true
end

-- Asignamos el "ACTIONID" que se usará en el mapa editor. En este caso, utilizaremos el ID 701.
local action = createAction(onMissFortuneAction, 701)

-- Registramos la acción.
function onUse(cid, item, fromPosition, itemEx, toPosition)
    return action(cid, item, fromPosition, itemEx, toPosition)
end
