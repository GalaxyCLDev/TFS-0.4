-- talkactions.lua

-- Función para mostrar la lista de comandos disponibles
function onHelp(player, words)
    local commands = {
        "/ayuda - Muestra la lista de comandos disponibles.",
        "/tp [nombreCiudad] - Teleporta al jugador a una ciudad específica.",
        "/trade [nombreJugador] - Inicia un comercio con otro jugador.",
        -- Agrega más comandos aquí
    }

    local message = "Comandos disponibles:\n"

    for _, command in ipairs(commands) do
        message = message .. command .. "\n"
    end

    player:popupFYI(message)

    return false
end

-- Registra la TalkAction
function onSay(player, words, param)
    if words:sub(1, 6) == "/ayuda" then
        return onHelp(player, words)
    end

    -- Agrega más TalkActions aquí

    return true
end


