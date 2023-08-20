local requiredStorages = {1000, 1001, 1002, 1003, 1004} -- Lista de storages requeridos
local shopItems = {
    {itemid = 2140, price = 10}, -- Ejemplo de item en la tienda: itemid 2140 (Gold Coin) por 10 monedas
    -- Agrega más elementos a la tienda si es necesario
}

local currencyItemID = 3636 -- ID del item utilizado como moneda

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
            selfSay("¡Hola, " .. getCreatureName(cid) .. "! ¡Bienvenido a mi tienda!")
            selfSay("Te ofrezco los siguientes productos:")
            
            for _, item in ipairs(shopItems) do
                local currencyAmount = getPlayerItemCount(cid, currencyItemID)
                selfSay("[" .. item.itemid .. "] " .. getItemNameById(item.itemid) .. " - " .. item.price .. " " .. getItemNameById(currencyItemID) .. " (Tienes: " .. currencyAmount .. ")")
            end
        else
            local missingStorageNames = {}
            for _, storage in ipairs(missingStorages) do
                table.insert(missingStorageNames, "Storage " .. storage)
            end
            local missingStorageList = table.concat(missingStorageNames, ", ")
            selfSay("¡Hola, " .. getCreatureName(cid) .. "! Para hablar conmigo y acceder a la tienda, necesitas completar los siguientes storages: " .. missingStorageList)
        end
    end
end

function onPlayerCloseChannel(cid)
end

function onPlayerEndTrade(cid)
end

function onThink()
end
