-- CDebuff.lua

local spellSchools = {
    ["None"] = 0,
    ["Magic"] = 1,
    ["Curse"] = 2,
    ["Poison"] = 3
}

local function GetImportantDebuffs(debuffs)
    local importantDebuffs = {
        ["None"] = nil,
        ["Magic"] = nil,
        ["Curse"] = nil,
        ["Poison"] = nil
    }

    for _, debuff in ipairs(debuffs) do
        if debuff.spellSchool == spellSchools.None and not importantDebuffs.None then
            importantDebuffs.None = debuff
        elseif debuff.spellSchool == spellSchools.Magic and not importantDebuffs.Magic then
            importantDebuffs.Magic = debuff
        elseif debuff.spellSchool == spellSchools.Curse and not importantDebuffs.Curse then
            importantDebuffs.Curse = debuff
        elseif debuff.spellSchool == spellSchools.Poison and not importantDebuffs.Poison then
            importantDebuffs.Poison = debuff
        end
    end

    local result = {}
    for _, debuff in pairs(importantDebuffs) do
        if debuff then
            table.insert(result, debuff)
        end
    end

    return result
end

return {
    GetImportantDebuffs = GetImportantDebuffs
}
