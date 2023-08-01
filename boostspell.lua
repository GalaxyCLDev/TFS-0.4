local damageIncreaseFactor = 1.5 -- Aumento de daño (1.5 = 150% de daño adicional)

local function applyDamageIncrease(cid)
    local tmpCombat = createCombatObject()
    setCombatParam(tmpCombat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    setCombatParam(tmpCombat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN) -- Puedes cambiar el efecto visual aquí si lo deseas.
    setCombatParam(tmpCombat, COMBAT_PARAM_USECHARGES, true)

    local tmpArea = createCombatArea(AREA_SQUARE1X1)
    setCombatArea(tmpCombat, tmpArea)

    local function onGetFormulaValues(cid, level, skill, attack, factor)
        local skillTotal, levelTotal = skill + attack, level / 5
        return -(skillTotal * damageIncreaseFactor + levelTotal), -(skillTotal * damageIncreaseFactor + levelTotal)
    end

    setCombatCallback(tmpCombat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

    local duration = 15 -- Duración del aumento de daño en segundos
    doCombat(cid, tmpCombat, var)
    addEvent(function() resetCombat(cid) end, duration * 1000) -- Restablecer el combate después de 'duration' segundos
end

function onCastSpell(cid, var)
    applyDamageIncrease(cid)
    return doCombat(cid, combat, var)
end

